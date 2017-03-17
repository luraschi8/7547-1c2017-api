package ar.com.trips.presentacion.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.modelo.AtraccionModelo;

@Controller
public class AtraccionControlador {

	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@RequestMapping(path="/atracciones")
	public ModelAndView listar() {
		ModelAndView model = new ModelAndView("inicio");
		model.addObject("listaAtracciones", atraccionDao.listar(AtraccionModelo.class));
		//model.addObject("listaAtracciones", atraccionDao.listar());
		return model;
	}
	
}
