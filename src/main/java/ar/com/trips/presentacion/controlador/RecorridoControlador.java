package ar.com.trips.presentacion.controlador;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.IRecorridoDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Ciudad;
import ar.com.trips.persistencia.modelo.Recorrido;

@Controller
public class RecorridoControlador {

	private static final String RECORRIDO_NUEVO_PATH = "recorridos/recorridoNuevo";
	
	@Autowired
	private IRecorridoDAO recorridoDao;
	
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
	public ModelAndView nuevo(@RequestParam("idCiudad") int idCiudad, @RequestParam("latitudCiudad") float latitudCiudad, @RequestParam("longitudCiudad") float longitudCiudad) {
		ModelAndView model = new ModelAndView(RECORRIDO_NUEVO_PATH);
		Recorrido recorrido = new Recorrido();
		Ciudad ciudad = new Ciudad();
		ciudad.setId(idCiudad);
		ciudad.setLatitud(latitudCiudad);
		ciudad.setLongitud(longitudCiudad);
		recorrido.setCiudad(ciudad);

		List<Atraccion> list = atraccionDao.listarPorCiudad(idCiudad);
		for (Atraccion a : list) {
			if (a.getBorrado() != 0) {
				recorrido.addAtractionToRoute(a);
			}
		}

		
		model.addObject("recorrido", recorrido);
		return model;
	}
	
	@RequestMapping("recorridoNuevoValidar")
	public String nuevo(@ModelAttribute("recorrido") Recorrido recorrido, @RequestParam("idCiudad") int idCiudad,
							@RequestParam("idioma") String idioma) {
		Ciudad ciudad = new Ciudad();
		ciudad.setId(idCiudad);
		recorrido.setCiudad(ciudad);
		recorrido.setBorrado(0);
		recorrido.setIdioma(idioma);
		recorridoDao.guardar(recorrido);
		return "redirect:/ciudadVer?idCiudad=" + idCiudad;
	}
	
	@RequestMapping("recorridoBorrar")
	public ModelAndView borrar(@RequestParam("idRecorrido") int id,@RequestParam("idCiudadRecorrido") int idCiudad) {
		recorridoDao.borrar(id);
		return new ModelAndView("redirect:/ciudadVer?idCiudad=" + idCiudad);
	}

	@RequestMapping(path="recorridoVer")
	public ModelAndView ver(@RequestParam("idRecorrido") long id) {
		Recorrido recorrido = recorridoDao.get(id);
		ModelAndView model = new ModelAndView("recorridos/recorrido");
		model.addObject("recorrido", recorrido);		
		return model;
	}
	
	@RequestMapping("recorridoModificar")
	public ModelAndView modificar(@ModelAttribute("recorrido") Recorrido recorridoId,
									@RequestParam("nombre") String nombreModificado,
									@RequestParam("descripcion") String descripcionModificada,
									@RequestParam("idioma") String idiomaModificado) throws IOException {
		Recorrido recorrido = recorridoDao.get(recorridoId.getId());
		recorrido.setNombre(nombreModificado);
		recorrido.setDescripcion(descripcionModificada);
		recorrido.setIdioma(idiomaModificado);
		recorridoDao.modificar(recorrido);
		return new ModelAndView("redirect:/ciudadVer?idCiudad=" + recorrido.getCiudad().getId());
	}
}