package ar.com.trips.presentacion.controlador;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Ciudad;

@Controller
public class AtraccionControlador {

	private static final String ATRACCION_NUEVO_PATH = "atracciones/atraccionNuevo";
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@Autowired
	private ICiudadDAO ciudadDao;
	
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
		return model;
	}
	
	@RequestMapping("atraccionNuevoValidar")
	public String nuevo(@ModelAttribute("atraccion") Atraccion atraccion, @RequestParam("idCiudad") int idCiudad,
							@RequestParam("archivoAudioguia") MultipartFile audio) {
		Ciudad ciudad = new Ciudad();
		ciudad.setId(idCiudad);
		atraccion.setCiudad(ciudad);
		/*try {
			atraccion.setAudioEN(audio.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}*/
		guardarAudio(atraccion, audio);
		atraccion.setBorrado(0);
		atraccionDao.guardar(atraccion);
		return "redirect:/ciudadVer?idCiudad=" + idCiudad;
	}

	private void guardarAudio(Atraccion atraccion, MultipartFile audio) {
		try {
			String ext = "." + FilenameUtils.getExtension(audio.getOriginalFilename());
			File f = new File("./audio/" + audio.hashCode() + ext);
			FileUtils.writeByteArrayToFile(f, audio.getBytes());
			atraccion.setAudioEN(f.getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
	}
	
	@RequestMapping("atraccionBorrar")
	public ModelAndView borrar(@RequestParam("idAtraccion") int id,@RequestParam("idCiudadAtraccion") int idCiudad) {
		atraccionDao.borrar(id);
		return new ModelAndView("redirect:/ciudadVer?idCiudad=" + idCiudad);
	}

	@RequestMapping(path="atraccionVer")
	public ModelAndView ver(@RequestParam("idAtraccion") int id) {
		Atraccion atraccion = atraccionDao.get(Atraccion.class, id);
		ModelAndView model = new ModelAndView("atracciones/atraccion");
		model.addObject("atraccion", atraccion);		
		return model;
	}
}