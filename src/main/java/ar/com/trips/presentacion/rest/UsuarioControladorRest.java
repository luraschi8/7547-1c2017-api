package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IUsuarioDAO;
import ar.com.trips.persistencia.modelo.Usuario;

@RestController
public class UsuarioControladorRest {
	
	public static final String DATA = "data";
	
	@Autowired
	private IUsuarioDAO usuarioDao;
	
	@RequestMapping("/usuariosJson")
	public HashMap<String, List<Usuario>> listar() {
		HashMap<String, List<Usuario>> lista = new HashMap<String, List<Usuario>>();
		lista.put(DATA, usuarioDao.listar(Usuario.class));
		return lista;
	}
}
