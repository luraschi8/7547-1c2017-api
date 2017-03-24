package ar.com.trips.presentacion.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.CiudadModelo;

@Controller
public class CiudadControlador {

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
		ModelAndView model = new ModelAndView("ciudades/ciudadNuevo");
		model.addObject("ciudad", new CiudadModelo());
		return model;
	}
	
	@RequestMapping("ciudadNuevoValidar")
	public  String nuevoValidar(@ModelAttribute("ciudad") CiudadModelo ciudad) {
		//validar(ciudad);
		ciudad.setPais("Pais");
		ciudad.setLatitud(98);
		ciudad.setLongitud(98);
		ciudadDao.guardar(ciudad);
		return "redirect:/ciudades";
	}
	
}
