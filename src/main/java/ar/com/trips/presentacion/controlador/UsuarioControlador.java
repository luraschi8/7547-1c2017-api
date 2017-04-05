package ar.com.trips.presentacion.controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ar.com.trips.persistencia.dao.IUsuarioDAO;
import ar.com.trips.persistencia.modelo.Usuario;

@Controller
public class UsuarioControlador {

	@Autowired
	private IUsuarioDAO usuarioDao;
	
	@RequestMapping(path="/usuarioes")
	public ModelAndView depositos() {
		ModelAndView model = new ModelAndView("inicio");
		model.addObject("listaUsuarioes", usuarioDao.listar(Usuario.class));
		return model;
	}
	
}
