package ar.com.trips.presentacion.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		ModelAndView model = new ModelAndView("inicio");
		model.addObject("listaCiudades", ciudadDao.listar(CiudadModelo.class));
		//model.addObject("listaCiudades", ciudadDao.listar());
		return model;
	}
	
}
