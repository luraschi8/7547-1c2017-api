package ar.com.trips.presentacion.rest;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IReseniaDAO;
import ar.com.trips.persistencia.modelo.Resenia;
import ar.com.trips.presentacion.dto.ReseniaDTO;

@RestController
public class ReseniaRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IReseniaDAO reseniaDao;
	
	@RequestMapping(path="/reseniaDaoJson/{idAtraccion}",method=RequestMethod.GET)
	public HashMap<String, List> listarReseniaAtraccion(@PathVariable int idAtraccion) {
		HashMap<String, List> lista = new HashMap<String, List>();
		List<Resenia> list = reseniaDao.listarPorAtraccion(idAtraccion);
		lista.put(DATA, list);
		return lista;
	}

	@RequestMapping(path="/reseniasAtraccionJson/{idAtraccion}",method=RequestMethod.GET)
	public HashMap<String, List> listarReseniasAtraccionNuevo(@PathVariable int idAtraccion) {
		HashMap<String, List> lista = new HashMap<String, List>();
		List<Resenia> list = reseniaDao.listarPorAtraccion(idAtraccion);
		lista.put(DATA, list);
		return lista;
	}
	
	@RequestMapping(path="/resenia/{idResenia}",method=RequestMethod.GET)
	public HashMap<String, ReseniaDTO> getResenia(HttpServletRequest request, HttpServletResponse response,
								@PathVariable long idResenia) {
		HashMap<String, ReseniaDTO> lista = new HashMap<String, ReseniaDTO>();
		Resenia resenia = reseniaDao.get(idResenia);
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.indexOf("resenia"));
		ReseniaDTO dto = new ReseniaDTO();
		dto.setNombreUsuario(resenia.getNombreUsuario());
		dto.setFecha(resenia.getFecha());
		dto.setHora(resenia.getHora());
		dto.setCalificacion(resenia.getCalificacion());
		dto.setComentario(resenia.getComentario());
		lista.put(DATA, dto);
		return lista;
	}
	
	@RequestMapping(path="/crearResenia",method=RequestMethod.POST)
	public HashMap<String, Boolean> crearResenia(@RequestParam("nombreUsuario") String nombreUsuario,
			@RequestParam("fecha") String fecha,
			@RequestParam("hora") String hora,
			@RequestParam("calificacion") float calificacion,
			@RequestParam("comentario") String comentario) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		Resenia resenia = new Resenia();
		resenia.setNombreUsuario(nombreUsuario);
		resenia.setFecha(fecha);
		resenia.setHora(hora);
		resenia.setCalificacion(calificacion);
		resenia.setComentario(comentario);
		reseniaDao.guardar(resenia);
		lista.put(EXISTE, true);
		return lista;
	}
	
	@RequestMapping(path="/borrarResenia",method=RequestMethod.POST)
 	public HashMap<String, Boolean> borrarResenia(@RequestParam("id") int id) {
 		HashMap<String, Boolean> respuesta = new HashMap<String, Boolean>();
 		reseniaDao.borrar(id);
 		return respuesta;
 	}
}