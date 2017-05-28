package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.IUsuarioDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Usuario;
import ar.com.trips.presentacion.dto.FavoritoDTO;
import ar.com.trips.presentacion.dto.UsuarioDTO;
import ar.com.trips.util.Fecha;

@RestController
public class UsuarioControladorRest {
	
	public static final String DATA = "data";
	
	@Autowired
	private IUsuarioDAO usuarioDao;
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@RequestMapping("/usuariosJson")
	public HashMap<String, List<Usuario>> listar() {
		HashMap<String, List<Usuario>> lista = new HashMap<String, List<Usuario>>();
		lista.put(DATA, usuarioDao.listar(Usuario.class));
		return lista;
	}
	
	@RequestMapping("/accesoUsuario")
	public ResponseEntity<String> accesoUsuario(@RequestBody UsuarioDTO usuarioDto) {
		Usuario usuario = usuarioDao.getByIds(usuarioDto.getIdAndroid(),usuarioDto.getIdRedSocial());
		if (usuario == null) {
			crearUsuario(usuarioDto);
		} else {
			usuario.setUltimaFechaConexion(Fecha.getFecha());
			usuarioDao.modificar(usuario);
		}
		return ResponseEntity.ok("{}");
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
	
	@RequestMapping("/agregarFavorito")
	public ResponseEntity<String> agregarFavorito(@RequestBody FavoritoDTO favoritoDto) {
		Usuario usuario = usuarioDao.getByIds(favoritoDto.getIdAndroid(),favoritoDto.getIdRedSocial());
		if (usuario == null) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Usuario no encontrado");
		}
		Atraccion atraccion = atraccionDao.get(favoritoDto.getIdAtraccion());
		if (atraccion == null) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Atraccion no encontrada");
		}
		usuario.addAtraccion(atraccion);
		atraccion.addUsuario(usuario);
		usuario.setUltimaFechaConexion(Fecha.getFecha());
		usuarioDao.modificar(usuario);
		return ResponseEntity.ok("{}");
	}
	
	@RequestMapping("/usuarioFavoritos")
	public HashMap<String, Set<Atraccion>> usuarioFavoritos(@RequestBody FavoritoDTO favoritoDto) {
		Usuario usuario = usuarioDao.getByIds(favoritoDto.getIdAndroid(),favoritoDto.getIdRedSocial());
		Set<Atraccion> listaAtracciones = new LinkedHashSet<Atraccion>();
		for (Atraccion a : usuario.getListaAtraccionesFavoritas()) {
			if (a.getCiudad().getId() == favoritoDto.getIdCiudad()) {
				listaAtracciones.add(a);
			}
		}
		HashMap<String, Set<Atraccion>> lista = new HashMap<String, Set<Atraccion>>();
		lista.put(DATA, listaAtracciones);
		return lista;
	}
	
	@RequestMapping("/sacarFavorito")
	public ResponseEntity<String> sacarFavorito(@RequestBody FavoritoDTO favoritoDto) {
		Usuario usuario = usuarioDao.getByIds(favoritoDto.getIdAndroid(),favoritoDto.getIdRedSocial());
		if (usuario == null) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Usuario no encontrado");
		}
		Atraccion atraccion = atraccionDao.get(favoritoDto.getIdAtraccion());
		if (atraccion == null) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Atraccion no encontrada");
		}
		Set<Atraccion> atracciones = usuario.getListaAtraccionesFavoritas(); 
		for (Iterator<Atraccion> iterator = atracciones.iterator(); iterator.hasNext();) {
			Atraccion a = iterator.next();
			if (a.getId() == atraccion.getId()) {
				iterator.remove();
			}
		}
		List<Usuario> usuarios = atraccion.getListaUsuarios(); 
		for (Iterator<Usuario> iterator = usuarios.iterator(); iterator.hasNext();) {
			Usuario u = iterator.next();
			if (u.getIdRedSocial().equals(usuario.getIdRedSocial())) {
				iterator.remove();
			}
		}
		usuario.setUltimaFechaConexion(Fecha.getFecha());
		usuarioDao.modificar(usuario);
		return ResponseEntity.ok("{}");
	}
	
	@RequestMapping(path="/cantidadUsuarios", method=RequestMethod.POST)
	public HashMap<String, HashMap<String,Long>> getCantidadUsuarios(@RequestParam("fechaInicio") String fechaInicio,
			@RequestParam("fechaFin") String fechaFin) {
		HashMap<String, HashMap<String,Long>> lista = new HashMap<String, HashMap<String,Long>>();
		HashMap<String,Long> cantidadPorMes = new HashMap<String,Long>();
		List<Usuario> usuarios = usuarioDao.getUsuariosParaRangoFechas(fechaInicio, fechaFin);
		for (Usuario usuario : usuarios) {
			String fechaUsuario[] = usuario.getUltimaFechaConexion().split("/");
			String fechaIni[] = fechaInicio.split("/");
			Long mes = null;
			Long mesInicio = Long.parseLong(fechaIni[1]);
			Long mesUsuario = Long.parseLong(fechaUsuario[1]);
			if (mesInicio < mesUsuario) {
				mes = mesUsuario - mesInicio;
			} else {
				mes = 12 - mesInicio + mesUsuario;
			}
			if (Long.parseLong(fechaIni[2]) < Long.parseLong(fechaUsuario[2])) {
				mes += 1;
			}
			if (mesInicio == mesUsuario) {
				if (Long.parseLong(fechaIni[2]) > Long.parseLong(fechaUsuario[2])) {
					mes = 12L;
				} else {
					mes = 1L;
				}
			}
			Long cantidad = cantidadPorMes.get(mes);
			if (cantidad == null) {
				cantidad = 0L;
			}
			cantidad++;
			cantidadPorMes.put(mes.toString(), cantidad);
		}
		lista.put(DATA, cantidadPorMes);
		return lista;
	}
	
	@RequestMapping(path="/cantidadUsuariosRedSocialYSinLogin", method=RequestMethod.POST)
	public HashMap<String, String> getCantidadUsuariosRedSocialYSinLogin(@RequestParam("fechaInicio") String fechaInicio,
			@RequestParam("fechaFin") String fechaFin, @RequestParam("pais") String pais) {
		HashMap<String, String> lista = new HashMap<String, String>();
		String resultados = Integer.toString(usuarioDao.getCantidadUsuariosRedSocial(fechaInicio, fechaFin, pais));
		resultados += "," + Integer.toString(usuarioDao.getCantidadUsuariosSinLogin(fechaInicio, fechaFin, pais));
		lista.put(DATA, resultados);
		return lista;
	}
	
	@RequestMapping(path="/cantidadUsuariosPais", method=RequestMethod.POST)
	public HashMap<String, String> getCantidadUsuariosPais(@RequestParam("fechaInicio") String fechaInicio,
			@RequestParam("fechaFin") String fechaFin) {
		HashMap<String, String> lista = new HashMap<String, String>();
		List<Usuario> usuarios = usuarioDao.getUsuariosParaRangoFechas(fechaInicio, fechaFin);
		if (usuarios != null) {
			for (int i = 0; i < usuarios.size(); i++) {
				String pais = usuarios.get(i).getPais();
				if (lista.containsKey(pais)) {
					int cantidad = Integer.parseInt((lista.get(pais)));
					lista.remove(pais);
					lista.put(pais, String.valueOf(cantidad + 1));
				} else {
					lista.put(pais, "1");
				}
			}
			return lista;
		} else {
			return null;
		}
	}
}