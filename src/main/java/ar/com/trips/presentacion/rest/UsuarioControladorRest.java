package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IUsuarioDAO;
import ar.com.trips.persistencia.modelo.Usuario;
import ar.com.trips.presentacion.dto.UsuarioDTO;
import ar.com.trips.util.Fecha;

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
	
	@RequestMapping("/accesoUsuario")
	public void accesoUsuario(@RequestBody UsuarioDTO usuarioDto) {
		Usuario usuario = usuarioDao.getByIds(usuarioDto.getIdAndroid(),usuarioDto.getIdRedSocial());
		if (usuario == null) {
			crearUsuario(usuarioDto);
		} else {
			usuario.setUltimaFechaConexion(Fecha.getFecha());
			usuarioDao.modificar(usuario);
		}
	}
	
	private void crearUsuario(UsuarioDTO usuarioDto) {
		Usuario usuario = new Usuario();
		usuario.setIdAndroid(usuarioDto.getIdAndroid());
		usuario.setIdRedSocial(usuarioDto.getIdRedSocial());
		usuario.setNombre(usuarioDto.getNombre());
		usuario.setPais(usuarioDto.getPais());
		usuario.setUltimaFechaConexion(Fecha.getFecha());
		usuarioDao.guardar(usuario);
	}
	
}
