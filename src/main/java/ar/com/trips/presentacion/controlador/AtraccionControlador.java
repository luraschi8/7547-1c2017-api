package ar.com.trips.presentacion.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.modelo.AtraccionModelo;
import ar.com.trips.persistencia.modelo.CiudadModelo;

@Controller
public class AtraccionControlador {

	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@RequestMapping(path="/atracciones")
	public ModelAndView listar() {
		ModelAndView model = new ModelAndView("atracciones/atracciones");
		model.addObject("listaAtracciones", atraccionDao.listar(AtraccionModelo.class));
		model.addObject("atraccion", new AtraccionModelo());
		return model;
	}
	
}
