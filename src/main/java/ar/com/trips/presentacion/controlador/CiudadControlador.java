package ar.com.trips.presentacion.controlador;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.CiudadModelo;
import ar.com.trips.presentacion.validacion.CiudadValidacion;

@Controller
public class CiudadControlador {

	private static final String CIUDAD_NUEVO_PATH = "ciudades/ciudadNuevo";
	
	@Autowired
	private ICiudadDAO ciudadDao;
	
	@Autowired
	CiudadValidacion ciudadValidacion;
	
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
	public ModelAndView nuevoValidar(@ModelAttribute("ciudad") CiudadModelo ciudad) {
		ciudad.setPais("Pais");
		List<String> listaErrores = ciudadValidacion.validar(ciudad);
		if (listaErrores.size() != 0) {
			ModelAndView model = new ModelAndView(CIUDAD_NUEVO_PATH);
			model.addObject("listaErrores",listaErrores);
			model.addObject("ciudad",ciudad);
			return model;
		}
		ciudad.setLatitud(98);
		ciudad.setLongitud(98);
		ciudadDao.guardar(ciudad);
		return new ModelAndView("redirect:/ciudades");
	}
	
}
