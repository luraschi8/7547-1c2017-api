package ar.com.trips.presentacion.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.CiudadModelo;

@Controller
public class CiudadControlador {

	private static final String CIUDAD_NUEVO_PATH = "ciudades/ciudadNuevo";
	
	@Autowired
	private ICiudadDAO ciudadDao;
	
	@RequestMapping(path="/ciudades")
	public ModelAndView listar() {
		ModelAndView model = new ModelAndView("ciudades/ciudades");
		model.addObject("listaCiudades", ciudadDao.listar(CiudadModelo.class));
		model.addObject("ciudad", new CiudadModelo());
		return model;
	}
	
	@RequestMapping("ciudadNuevo")
	public ModelAndView nuevo() {
		ModelAndView model = new ModelAndView(CIUDAD_NUEVO_PATH);
		model.addObject("ciudad", new CiudadModelo());
		return model;
	}
	
	@RequestMapping("ciudadNuevoValidar")
	public ModelAndView nuevoValidar(@ModelAttribute("ciudad") CiudadModelo ciudad,
									@RequestParam("archivoImagenPiso") MultipartFile imagen) {
		try {
			byte[] bytes = imagen.getBytes();
			ciudad.setImagen(bytes);
		} catch (Exception e) {
			
		}
		ciudad.setLatitud(98);
		ciudad.setLongitud(98);
		ciudadDao.guardar(ciudad);
		return new ModelAndView("redirect:/ciudades");
	}
	
	@RequestMapping("ciudadBorrar")
	public ModelAndView borrar(@RequestParam("id") int id) {
		ciudadDao.borrar(id);
		return new ModelAndView("redirect:/ciudades");
	}
	
	@RequestMapping("ciudadVer")
	public ModelAndView ver(@RequestParam("id") int id) {
		CiudadModelo ciudad = ciudadDao.get(CiudadModelo.class, id);
		ModelAndView model = new ModelAndView("ciudades/ciudad");
		model.addObject("ciudad",ciudad);		
		return model;
	}
}
