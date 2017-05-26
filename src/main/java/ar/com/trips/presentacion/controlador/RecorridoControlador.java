package ar.com.trips.presentacion.controlador;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.IRecorridoDAO;
import ar.com.trips.persistencia.dao.IRecorridoIdiomaDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Ciudad;
import ar.com.trips.persistencia.modelo.Recorrido;
import ar.com.trips.persistencia.modelo.RecorridoIdioma;
import ar.com.trips.util.enums.Idioma;

@Controller
public class RecorridoControlador {

	private static final String RECORRIDO_NUEVO_PATH = "recorridos/recorridoNuevo";
	
	@Autowired
	private IRecorridoDAO recorridoDao;
	
	@Autowired
	private IRecorridoIdiomaDAO recorridoIdiomaDao;
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@RequestMapping(path="/recorridos")
	public ModelAndView listar() {
		ModelAndView model = new ModelAndView("recorridos/recorridos");
		model.addObject("listaRecorridos", recorridoDao.listar(Recorrido.class));
		model.addObject("recorrido", new Recorrido());
		return model;
	}
	
	@RequestMapping("recorridoNuevo")
	public ModelAndView nuevo(@RequestParam("idCiudad") int idCiudad, @RequestParam("latitudCiudad") float latitudCiudad,
			@RequestParam("longitudCiudad") float longitudCiudad, @RequestParam(name="idioma",required=false)String idioma) {
		ModelAndView model = new ModelAndView(RECORRIDO_NUEVO_PATH);
		Recorrido r = new Recorrido();
		RecorridoIdioma recorrido = new RecorridoIdioma();
		Ciudad ciudad = new Ciudad();
		ciudad.setId(idCiudad);
		ciudad.setLatitud(latitudCiudad);
		ciudad.setLongitud(longitudCiudad);
		recorrido.setRecorrido(r);
		recorrido.getRecorrido().setCiudad(ciudad);

		List<Atraccion> list = atraccionDao.listarPorCiudad(idCiudad);
		for (Atraccion a : list) {
			if (a.getBorrado() != 0) {
				recorrido.getRecorrido().addAtractionToRoute(a);
			}
		}

		model.addObject("recorrido", recorrido);
		model.addObject("idioma",idioma);
		return model;
	}
	
	private void agregarAtracciones(Recorrido recorrido, String atracciones) {
		String atracciones_separadas[] = atracciones.split(",");
		recorrido.setAtraccionesOrdenadas(atracciones);
		recorrido.getListaAtraccionesEnElRecorrido().clear();
		for (int i = 0; i < atracciones_separadas.length; i++) {
			Atraccion atraccion  = atraccionDao.get(Long.parseLong(atracciones_separadas[i]));
			atraccion.addRecorrido(recorrido);
			recorrido.addAtractionToRoute(atraccion);
		}
		recorrido.setCantAtracciones(atracciones_separadas.length);
	}
	
	@RequestMapping("recorridoNuevoValidar")
	public String nuevo(@ModelAttribute("recorrido") RecorridoIdioma recorrido, @RequestParam("idCiudad") int idCiudad,
							@RequestParam("idioma") String idioma, @RequestParam("atracciones") String atracciones,
							@RequestParam(name="archivoAudioguiaRecorrido") MultipartFile audio) {
		Recorrido r = recorrido.getRecorrido();
		r.addRecorridoIdioma(recorrido);
		Ciudad ciudad = new Ciudad();
		ciudad.setId(idCiudad);
		r.setCiudad(ciudad);
		recorrido.setBorrado(0);
		recorrido.setIdioma(Idioma.valueOf(idioma));
		try {
			recorrido.setAudio(audio.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		agregarAtracciones(r, atracciones);
		recorridoDao.guardar(r);
		return "redirect:/ciudadVer?idCiudad=" + idCiudad;
	}
	
	@RequestMapping("recorridoBorrar")
	public ModelAndView borrar(@RequestParam("idRecorrido") long id, @RequestParam("idCiudadRecorrido") int idCiudad) {
		List<Atraccion> atracciones = recorridoDao.listarAtracciones(idCiudad);
		for (int i = 0; i < atracciones.size(); i++) {
			atracciones.get(i).eraseRecorrido(recorridoDao.get(id));
		}
		recorridoDao.borrar(id);
		return new ModelAndView("redirect:/ciudadVer?idCiudad=" + idCiudad + "&showRoutes=true");
	}

	@RequestMapping(path="recorridoVer")
	public ModelAndView ver(@RequestParam("idRecorrido") long id, @RequestParam("idioma") String idioma) {
		Recorrido recorrido = recorridoDao.get(id);
		RecorridoIdioma r = recorridoIdiomaDao.get(id, idioma);
		if (r == null) {
			if (idioma.equals("ES")) {
				idioma = "EN";
			} else {
				idioma = "ES";
			}
			r = recorridoIdiomaDao.get(id, idioma);
		}
		r.setRecorrido(recorrido);
		ModelAndView model = new ModelAndView("recorridos/recorrido");
		model.addObject("recorrido", r);
		model.addObject("idioma",idioma);
		return model;
	}
	
	@RequestMapping("recorridoModificar")
	public ModelAndView modificar(@ModelAttribute("recorrido") RecorridoIdioma recorrido,
									@RequestParam("nombre") String nombreModificado,
									@RequestParam("descripcion") String descripcionModificada,
									@RequestParam("audioCambiadoRecorrido") Long audioCambiado,
									@RequestParam("atracciones") String atracciones,
									@RequestParam("atraccionesCambiadas") Long atraccionesCambiadas,
									@RequestParam(name="archivoAudioguiaRecorrido") MultipartFile audio) throws IOException {
		recorrido = recorridoIdiomaDao.get(recorrido.getId());
		recorrido.getRecorrido().setNombre(nombreModificado);
		recorrido.setDescripcion(descripcionModificada);
		if (audioCambiado == 1) {
			recorrido.setAudio(null);
		}
		guardarAudio(recorrido,audio);
		if (atraccionesCambiadas == 1) {
			agregarAtracciones(recorrido.getRecorrido(), atracciones);
		}
		recorrido.getRecorrido().setAtraccionesOrdenadas(atracciones);
		recorridoDao.modificar(recorrido);
		return new ModelAndView("redirect:/ciudadVer?idCiudad=" + recorrido.getRecorrido().getCiudad().getId());
	}
	
	private void guardarAudio(RecorridoIdioma recorrido, MultipartFile audio) {
		try {
			byte[] bytes = audio.getBytes();
			if (bytes.length != 0) {
				recorrido.setAudio(bytes);
			}
		} catch (Exception e) {
			recorrido.setAudio(null);
			e.printStackTrace();
		}
	}
}