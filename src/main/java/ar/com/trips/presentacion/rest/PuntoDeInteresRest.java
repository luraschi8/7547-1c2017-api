package ar.com.trips.presentacion.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import ar.com.trips.persistencia.dao.IPuntoDeInteresDAO;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;
import ar.com.trips.presentacion.dto.PuntoDeInteresDTO;
import ar.com.trips.presentacion.validacion.PuntoDeInteresValidacion;

@RestController
public class PuntoDeInteresRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IPuntoDeInteresDAO puntoDao;
	
	@Autowired
	private PuntoDeInteresValidacion puntoValidacion;
	
	@RequestMapping(path="/puntoAtraccionJson/{idAtraccion}",method=RequestMethod.GET)
	public HashMap<String, List> listarPuntoDeInteresesAtraccion(@PathVariable int idAtraccion) {
		HashMap<String, List> lista = new HashMap<String, List>();
		List<PuntoDeInteres> list = puntoDao.listarPorAtraccion(idAtraccion);
		for (PuntoDeInteres punto : list) {
			punto.setImagenString(DatatypeConverter.printBase64Binary(punto.getImagen()));
		}
		lista.put(DATA, list);
		return lista;
	}
	
	@RequestMapping(path="/puntoAtraccionNuevoJson/{idAtraccion}",method=RequestMethod.GET)
	public HashMap<String, List> listarPuntoDeInteresesAtraccionNuevo(@PathVariable int idAtraccion) {
		HashMap<String, List> lista = new HashMap<String, List>();
		List<PuntoDeInteres> list = puntoDao.listarPorAtraccionNuevo(idAtraccion);
		lista.put(DATA, list);
		return lista;
	}
	
	@RequestMapping(path="/punto/{idPuntoDeInteres}",method=RequestMethod.GET)
	public HashMap<String, PuntoDeInteresDTO> getPuntoDeInteres(HttpServletRequest request, HttpServletResponse response,
								@PathVariable long idPuntoDeInteres) {
		HashMap<String, PuntoDeInteresDTO> lista = new HashMap<String, PuntoDeInteresDTO>();
		PuntoDeInteres punto = puntoDao.get(idPuntoDeInteres);
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.indexOf("punto"));
		PuntoDeInteresDTO dto = new PuntoDeInteresDTO();
		dto.setId(idPuntoDeInteres);
		dto.setNombre(punto.getNombre());
		dto.setDescripcion(punto.getDescripcion());
		if (punto.getAudioEN() != null) {
			dto.setAudioEN(url + "audioPunto?id=" + punto.getId());
		}
		dto.setImagen(DatatypeConverter.printBase64Binary(punto.getImagen()));
		lista.put(DATA, dto);
		return lista;
	}
	
	@RequestMapping(path="/crearPunto",method=RequestMethod.POST)
	public HashMap<String, Boolean> crearPunto(@RequestParam("nombre") String nombre,
			@RequestParam("descripcion") String descripcion,
			@RequestParam(name="imagen") MultipartFile imagen,
			@RequestParam(name="idAtraccion",required=false) Integer idAtraccion,
			@RequestParam(name="audio",required=false) MultipartFile audio) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		List<PuntoDeInteres> listaPuntos = puntoDao.listarPorAtraccionNuevo(idAtraccion);
		int orden = 0;
		for (PuntoDeInteres puntoDeInteres : listaPuntos) {
			if (puntoDeInteres.getOrden() > orden) {
				orden = puntoDeInteres.getOrden();
			}
		}
		PuntoDeInteres punto = new PuntoDeInteres();
		punto.setNombre(nombre);
		punto.setDescripcion(descripcion);
		punto.setImagen(imagen.getBytes());
		punto.setOrden(++orden);
		if (audio != null ) {
			punto.setAudioEN(audio.getBytes());
		}
		puntoDao.guardar(punto);
		lista.put(EXISTE, true);
		return lista;
	}
	
	@RequestMapping(path="/validarPuntoDeInteres",method=RequestMethod.POST)
	public HashMap<String, Boolean> validarPuntoDeInteres(@RequestBody PuntoDeInteres punto) {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		List<String> listaErrores = puntoValidacion.validar(punto);
		if (listaErrores.size() != 0) {
			lista.put(EXISTE, true);
		} else {
			lista.put(EXISTE, false);
		}
		return lista;
	}
	
	@RequestMapping(path="/cambiarOrden",method=RequestMethod.POST)
	public HashMap<String, Boolean> cambiarOrden(@RequestParam("ordenPuntos") String ordenPuntos) {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		puntoDao.cambiarOrdenes(ordenPuntos);
		return lista;
	}
	
	@RequestMapping(path="/borrarPunto",method=RequestMethod.POST)
	public HashMap<String, Boolean> borrarPunto(@RequestParam("id") Integer id,@RequestParam("idAtraccion") Integer idAtraccion) {
		HashMap<String, Boolean> respuesta = new HashMap<String, Boolean>();
		puntoDao.borrar(id,idAtraccion);
		return respuesta;
	}
	
	@RequestMapping(path="/modificarPunto",method=RequestMethod.POST)
	public HashMap<String, Boolean> modificarPunto(@RequestParam("nombre") String nombre,
			@RequestParam("descripcion") String descripcion,
			@RequestParam(name="imagen") MultipartFile imagen,
			@RequestParam(name="id",required=false) int id,
			@RequestParam(name="audio",required=false) MultipartFile audio) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		PuntoDeInteres punto = puntoDao.get(id);
		punto.setNombre(nombre);
		punto.setDescripcion(descripcion);
		if (imagen != null) {
			punto.setImagen(imagen.getBytes());
		}
		if (audio != null) {
			punto.setAudioEN(audio.getBytes());
		}
		puntoDao.guardar(punto);
		lista.put(EXISTE, true);
		return lista;
	}
}
