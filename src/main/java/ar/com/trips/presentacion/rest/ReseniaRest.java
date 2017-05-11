package ar.com.trips.presentacion.rest;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
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
	public HashMap<String, List<Resenia>> listarReseniaAtraccion(@PathVariable int idAtraccion) {
		HashMap<String, List<Resenia>> lista = new HashMap<String, List<Resenia>>();
		List<Resenia> list = reseniaDao.listarPorAtraccion(idAtraccion);
		lista.put(DATA, list);
		return lista;
	}

	@RequestMapping(path="/reseniasAtraccionJson/{idAtraccion}",method=RequestMethod.GET)
	public HashMap<String, List<Resenia>> listarReseniasAtraccionNuevo(@PathVariable int idAtraccion) {
		HashMap<String, List<Resenia>> lista = new HashMap<String, List<Resenia>>();
		List<Resenia> list = reseniaDao.listarPorAtraccion(idAtraccion);
		lista.put(DATA, list);
		return lista;
	}
	
	@RequestMapping(path="/reseniasPaginadasAtraccionJson/{idAtraccion}/{pagina}",method=RequestMethod.GET)
	public HashMap<String, List<Resenia>> listarReseniaPaginadasAtraccion(@PathVariable int idAtraccion, @PathVariable int pagina) {
		HashMap<String, List<Resenia>> lista = new HashMap<String, List<Resenia>>();
		List<Resenia> list = reseniaDao.listarPorAtraccionPaginada(idAtraccion,pagina);
		lista.put(DATA, list);
		return lista;
	}
	
	@RequestMapping(path="/resenia/{idResenia}",method=RequestMethod.GET)
	public HashMap<String, ReseniaDTO> getResenia(HttpServletRequest request, HttpServletResponse response,
								@PathVariable long idResenia) {
		HashMap<String, ReseniaDTO> lista = new HashMap<String, ReseniaDTO>();
		Resenia resenia = reseniaDao.get(idResenia);
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
	public HashMap<String, Boolean> crearResenia(@RequestBody Resenia resenia) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		Date date = new Date();
		String[] fechaHora = dateFormat.format(date).split(" ");
		resenia.setFecha(fechaHora[0]);
		resenia.setHora(fechaHora[1]);
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
	
	@RequestMapping(path="/editarResenia",method=RequestMethod.POST)
 	public HashMap<String, Boolean> editarResenia(@RequestParam("idResenia") int id, @RequestParam("comentario") String comentario) {
 		HashMap<String, Boolean> respuesta = new HashMap<String, Boolean>();
 		reseniaDao.guardar(id, comentario);
 		return respuesta;
 	}
}