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
import ar.com.trips.persistencia.dao.IImagenAtraccionDAO;
import ar.com.trips.persistencia.dao.IPuntoDeInteresDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Ciudad;
import ar.com.trips.persistencia.modelo.ImagenAtraccion;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;

@Controller
public class AtraccionControlador {

	private static final String ATRACCION_NUEVO_PATH = "atracciones/atraccionNuevo";
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@Autowired
	private IPuntoDeInteresDAO puntoDao;
	
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
		model.addObject("atraccion", atraccion);
		model.addObject("puntoDeInteres",new PuntoDeInteres());
		return model;
	}
	
	@RequestMapping("atraccionNuevoValidar")
	public String nuevo(@ModelAttribute("atraccion") Atraccion atraccion, @RequestParam("idCiudad") int idCiudad,
							@RequestParam("archivoPlano") MultipartFile plano,
							@RequestParam(name="archivoAudioguia") MultipartFile audio,
							@RequestParam(name="archivoGaleria0",required = false) MultipartFile galeria1,
							@RequestParam(name="archivoGaleria1",required = false) MultipartFile galeria2,
							@RequestParam(name="archivoGaleria2",required = false) MultipartFile galeria3,
							@RequestParam(name="archivoGaleria3",required = false) MultipartFile galeria4,
							@RequestParam(name="archivoGaleria4",required = false) MultipartFile galeria5,
							@RequestParam(name="unVideo",required = false) MultipartFile video,
							@RequestParam("recorrible") int recorrible) {
		Ciudad ciudad = new Ciudad();
		ciudad.setId(idCiudad);
		atraccion.setCiudad(ciudad);
		guardarPlano(atraccion,plano);
		try {
			atraccion.setVideo(video.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		guardarAudio(atraccion,audio);
		atraccion.setBorrado(0);
		atraccion.setRecorrible(recorrible);
		atraccionDao.guardar(atraccion);
		guardarMultimediaMultiple(atraccion,galeria1,galeria2,galeria3,galeria4,galeria5);
		guardarPuntosDeInteres(atraccion);
		return "redirect:/ciudadVer?idCiudad=" + idCiudad;
	}

	private void guardarPuntosDeInteres(Atraccion atraccion) {
		if (atraccion.getRecorrible() == 1) {
			puntoDao.guardarPuntosConAtraccionNula(atraccion);
		} else {
			puntoDao.borrarPuntosDeAtraccion(atraccion);
		}
	}

	private void guardarAudio(Atraccion atraccion, MultipartFile audio) {
		try {
			byte[] bytes = audio.getBytes();
			if (bytes.length != 0) {
				atraccion.setAudioEN(bytes);
			}
		} catch (Exception e) {
			atraccion.setAudioEN(null);
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

	@RequestMapping(path="atraccionVer")
	public ModelAndView ver(@RequestParam("idAtraccion") long id) {
		Atraccion atraccion = atraccionDao.get(id);
		ModelAndView model = new ModelAndView("atracciones/atraccion");
		model.addObject("atraccion", atraccion);		
		return model;
	}
	
	@RequestMapping("atraccionModificar")
	public ModelAndView modificar(@ModelAttribute("atraccion") Atraccion atraccionId,
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
									@RequestParam("archivoPlano") MultipartFile plano) throws IOException {
		Atraccion atraccion = atraccionDao.get(atraccionId.getId());
		
		if (planoCambiado == 1) {
			guardarPlano(atraccion,plano);
		}
		if (videoCambiado == 1) {
			atraccion.setVideo(null);
		}
		if (audioCambiado == 1) {
			atraccion.setAudioEN(null);
		}
		eliminarImagenes(imagenesCambiadas);
		atraccion.setNombre(nombreModificado);
		atraccion.setDescripcion(descripcionModificada);
		atraccion.setHorario(horarioModificado);
		atraccion.setPrecio(precioModificado);
		atraccion.setLatitud(latitudModificada);
		atraccion.setLongitud(longitudModificada);
		atraccion.setRecorrible(recorribleModificado);
		if (video != null) {
			atraccion.setVideo(video.getBytes());
		}
		guardarAudio(atraccion,audio);
		guardarMultimediaMultiple(atraccion,galeria1,galeria2,galeria3,galeria4,galeria5);
		atraccionDao.modificar(atraccion);
		guardarPuntosDeInteres(atraccion);
		return new ModelAndView("redirect:/ciudadVer?idCiudad=" + atraccion.getCiudad().getId());
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