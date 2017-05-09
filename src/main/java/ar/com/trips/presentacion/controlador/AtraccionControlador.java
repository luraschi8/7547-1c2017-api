package ar.com.trips.presentacion.controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.IAtraccionIdiomaDAO;
import ar.com.trips.persistencia.dao.IImagenAtraccionDAO;
import ar.com.trips.persistencia.dao.IPuntoDeInteresDAO;
import ar.com.trips.persistencia.dao.IReseniaDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.AtraccionIdioma;
import ar.com.trips.persistencia.modelo.Ciudad;
import ar.com.trips.persistencia.modelo.ImagenAtraccion;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;
import ar.com.trips.util.enums.Idioma;

@Controller
public class AtraccionControlador {

	private static final String ATRACCION_NUEVO_PATH = "atracciones/atraccionNuevo";
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@Autowired
	private IAtraccionIdiomaDAO atraccionIdiomaDao;
	
	@Autowired
	private IPuntoDeInteresDAO puntoDao;
	
	@Autowired
	private IReseniaDAO reseniaDao;
	
	@Autowired
	private IImagenAtraccionDAO imagenAtraccionDao;
	
	@RequestMapping(path="/atracciones")
	public ModelAndView listar() {
		ModelAndView model = new ModelAndView("atracciones/atracciones");
		model.addObject("listaAtracciones", atraccionDao.listar(Atraccion.class));
		model.addObject("atraccion", new Atraccion());
		return model;
	}
	
	@RequestMapping("atraccionNuevo")
	public ModelAndView nuevo(@RequestParam("idCiudad") int idCiudad, @RequestParam("latitudCiudad") float latitudCiudad, @RequestParam("longitudCiudad") float longitudCiudad) {
		ModelAndView model = new ModelAndView(ATRACCION_NUEVO_PATH);
		Atraccion atraccion = new Atraccion();
		Ciudad ciudad = new Ciudad();
		ciudad.setId(idCiudad);
		ciudad.setLatitud(latitudCiudad);
		ciudad.setLongitud(longitudCiudad);
		atraccion.setCiudad(ciudad);
		AtraccionIdioma a = new AtraccionIdioma();
		a.setAtraccion(atraccion);
		model.addObject("atraccion", a);
		model.addObject("puntoDeInteres",new PuntoDeInteres());
		return model;
	}
	
	@RequestMapping("atraccionNuevoValidar")
	public String nuevo(@ModelAttribute("atraccion") AtraccionIdioma atraccion, @RequestParam("idCiudad") int idCiudad,
							@RequestParam("archivoPlano") MultipartFile plano,
							@RequestParam(name="archivoAudioguia") MultipartFile audio,
							@RequestParam(name="archivoGaleria0",required = false) MultipartFile galeria1,
							@RequestParam(name="archivoGaleria1",required = false) MultipartFile galeria2,
							@RequestParam(name="archivoGaleria2",required = false) MultipartFile galeria3,
							@RequestParam(name="archivoGaleria3",required = false) MultipartFile galeria4,
							@RequestParam(name="archivoGaleria4",required = false) MultipartFile galeria5,
							@RequestParam(name="unVideo",required = false) MultipartFile video,
							@RequestParam("recorrible") int recorrible,
							@RequestParam("idioma") String idioma) {
		Atraccion a = atraccion.getAtraccion();
		Ciudad ciudad = new Ciudad();
		ciudad.setId(idCiudad);
		a.setCiudad(ciudad);
		guardarPlano(a,plano);
		try {
			a.setVideo(video.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		guardarAudio(atraccion,audio);
		atraccion.setBorrado(0);
		atraccion.setIdioma(Idioma.valueOf(idioma));
		atraccion.setAtraccion(a);
		a.addAtraccionIdioma(atraccion);
		atraccionDao.guardar(a);
		guardarMultimediaMultiple(a,galeria1,galeria2,galeria3,galeria4,galeria5);
		guardarPuntosDeInteres(a,idioma);
		return "redirect:/ciudadVer?idCiudad=" + idCiudad;
	}

	private void guardarPuntosDeInteres(Atraccion atraccion,String idioma) {
		if (atraccion.getRecorrible() == 1) {
			puntoDao.guardarPuntosConAtraccionNula(atraccion,idioma);
		} else {
			puntoDao.borrarPuntosDeAtraccion(atraccion);
		}
	}

	private void guardarAudio(AtraccionIdioma atraccion, MultipartFile audio) {
		try {
			byte[] bytes = audio.getBytes();
			if (bytes.length != 0) {
				atraccion.setAudio(bytes);
			}
		} catch (Exception e) {
			atraccion.setAudio(null);
			e.printStackTrace();
		}
	}

	private void guardarPlano(Atraccion atraccion, MultipartFile plano) {
		try {
			byte[] bytes = plano.getBytes();
			if (bytes.length != 0) {
				atraccion.setPlano(bytes);
			}
		} catch (Exception e) {
			atraccion.setPlano(null);
			e.printStackTrace();
		}
	}

	private void guardarMultimediaMultiple(Atraccion atraccion, MultipartFile galeria1, MultipartFile galeria2, MultipartFile galeria3,
											MultipartFile galeria4, MultipartFile galeria5) {
		guardarMultimediaSingle(atraccion, galeria1);
		guardarMultimediaSingle(atraccion, galeria2);
		guardarMultimediaSingle(atraccion, galeria3);
		guardarMultimediaSingle(atraccion, galeria4);
		guardarMultimediaSingle(atraccion, galeria5);
	}

	private void guardarMultimediaSingle(Atraccion atraccion, MultipartFile galeria) {
		if (galeria != null) {
			ImagenAtraccion imagen = new ImagenAtraccion();
			imagen.setAtraccion(atraccion);
			try {
				imagen.setImagen(galeria.getBytes());
			} catch (IOException e) {
				e.printStackTrace();
			}
			imagenAtraccionDao.guardar(imagen);
		}
	}
	
	@RequestMapping("atraccionBorrar")
	public ModelAndView borrar(@RequestParam("idAtraccion") int id,@RequestParam("idCiudadAtraccion") int idCiudad) {
		atraccionDao.borrar(id);
		return new ModelAndView("redirect:/ciudadVer?idCiudad=" + idCiudad);
	}
	
	@RequestMapping("atraccionBorrarResenia")
	public ModelAndView borrarResenia(@RequestParam("idResenia") int id, @RequestParam("idAtraccion") int idAtraccion) {
		reseniaDao.borrar(id);
		return new ModelAndView("redirect:/atraccionVer?idAtraccion=" + idAtraccion);
	}

	@RequestMapping(path="atraccionVer")
	public ModelAndView ver(@RequestParam("idAtraccion") long id) {
		Atraccion atraccion = atraccionDao.get(id);
		ModelAndView model = new ModelAndView("atracciones/atraccion");
		model.addObject("atraccion", atraccion);		
		return model;
	}
	
	@RequestMapping("atraccionModificar")
	public ModelAndView modificar(@ModelAttribute("atraccion") AtraccionIdioma atraccion,
									@RequestParam("nombre") String nombreModificado,
									@RequestParam("descripcion") String descripcionModificada,
									@RequestParam("horario") String horarioModificado,
									@RequestParam("precio") String precioModificado,
									@RequestParam("latitud") float latitudModificada,
									@RequestParam("longitud") float longitudModificada,
									@RequestParam("recorrible") int recorribleModificado,
									@RequestParam(name="archivoAudioguia") MultipartFile audio,
									@RequestParam(name="archivoGaleria0",required = false) MultipartFile galeria1,
									@RequestParam(name="archivoGaleria1",required = false) MultipartFile galeria2,
									@RequestParam(name="archivoGaleria2",required = false) MultipartFile galeria3,
									@RequestParam(name="archivoGaleria3",required = false) MultipartFile galeria4,
									@RequestParam(name="archivoGaleria4",required = false) MultipartFile galeria5,
									@RequestParam(name="unVideo",required = false) MultipartFile video,
									@RequestParam(name="imagenesCambiadas") String imagenesCambiadas,
									@RequestParam(name="videoCambiado") int videoCambiado,
									@RequestParam("planoCambiado") int planoCambiado,
									@RequestParam("audioCambiado") int audioCambiado,
									@RequestParam("archivoPlano") MultipartFile plano,
									@RequestParam("idioma") String idiomaModificado) throws IOException {
		atraccion = atraccionIdiomaDao.get(atraccion.getId());
		
		if (planoCambiado == 1) {
			guardarPlano(atraccion.getAtraccion(),plano);
		}
		if (videoCambiado == 1) {
			atraccion.getAtraccion().setVideo(null);
		}
		if (audioCambiado == 1) {
			atraccion.setAudio(null);
		}
		eliminarImagenes(imagenesCambiadas);
		atraccion.getAtraccion().setNombre(nombreModificado);
		atraccion.setDescripcion(descripcionModificada);
		atraccion.setHorario(horarioModificado);
		atraccion.setPrecio(precioModificado);
		atraccion.getAtraccion().setLatitud(latitudModificada);
		atraccion.getAtraccion().setLongitud(longitudModificada);
		atraccion.getAtraccion().setRecorrible(recorribleModificado);
		atraccion.setIdioma(Idioma.valueOf(idiomaModificado));
		if (video != null) {
			atraccion.getAtraccion().setVideo(video.getBytes());
		}
		guardarAudio(atraccion,audio);
		guardarMultimediaMultiple(atraccion.getAtraccion(),galeria1,galeria2,galeria3,galeria4,galeria5);
		atraccionDao.modificar(atraccion);
		guardarPuntosDeInteres(atraccion.getAtraccion(),idiomaModificado);
		return new ModelAndView("redirect:/ciudadVer?idCiudad=" + atraccion.getAtraccion().getCiudad().getId());
	}

	private void eliminarImagenes(String imagenesCambiadas) {
		if (imagenesCambiadas == null || imagenesCambiadas.equals("")) {
			return;
		}
		String[] ids = imagenesCambiadas.split(";");
		for (String id : ids) {
			imagenAtraccionDao.borrar(Long.parseLong(id));
		}
	}
}