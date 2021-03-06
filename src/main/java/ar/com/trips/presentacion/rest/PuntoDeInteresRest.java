package ar.com.trips.presentacion.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

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

import ar.com.trips.persistencia.dao.IPuntoDeInteresDAO;
import ar.com.trips.persistencia.dao.IPuntoDeInteresIdiomaDAO;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;
import ar.com.trips.persistencia.modelo.PuntoIdioma;
import ar.com.trips.presentacion.dto.PuntoDeInteresDTO;
import ar.com.trips.presentacion.mapper.PuntoMapper;
import ar.com.trips.presentacion.validacion.PuntoDeInteresValidacion;
import ar.com.trips.util.enums.Idioma;

@RestController
public class PuntoDeInteresRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IPuntoDeInteresDAO puntoDao;
	
	@Autowired
	private IPuntoDeInteresIdiomaDAO puntoIdiomaDao;
	
	@Autowired
	private PuntoDeInteresValidacion puntoValidacion;
	
	@RequestMapping(path="/puntoAtraccionJson/{idAtraccion}/{idioma}",method=RequestMethod.GET)
	public HashMap<String, List<PuntoDeInteresDTO>> listarPuntoDeInteresesAtraccion(@PathVariable int idAtraccion,@PathVariable String idioma) {
		HashMap<String, List<PuntoDeInteresDTO>> hash = new HashMap<String, List<PuntoDeInteresDTO>>();
		List<PuntoIdioma> list = puntoIdiomaDao.listarPorAtraccion(idAtraccion,idioma);
		List<PuntoDeInteresDTO> lista = new ArrayList<>();
		for (PuntoIdioma punto : list) {
			PuntoDeInteresDTO puntoDto = PuntoMapper.map(punto);
			lista.add(puntoDto);
		}
		hash.put(DATA, lista);
		return hash;
	}
	
	@RequestMapping(path="/puntoAtraccionNuevoJson/{idAtraccion}/{idioma}",method=RequestMethod.GET)
	public HashMap<String, List<PuntoDeInteresDTO>> listarPuntoDeInteresesAtraccionNuevo(@PathVariable int idAtraccion,
			@PathVariable String idioma) {
		HashMap<String, List<PuntoDeInteresDTO>> hash = new HashMap<String, List<PuntoDeInteresDTO>>();
		List<PuntoIdioma> list = puntoIdiomaDao.listarPorAtraccionNuevo(idAtraccion,idioma);
		List<PuntoDeInteresDTO> lista = new ArrayList<>();
		for (PuntoIdioma punto : list) {
			PuntoDeInteresDTO puntoDto = PuntoMapper.map(punto);
			lista.add(puntoDto);
		}
		hash.put(DATA, lista);
		return hash;
	}
	
	@RequestMapping(path="/punto/{idPuntoDeInteres}/{idioma}",method=RequestMethod.GET)
	public HashMap<String, PuntoDeInteresDTO> getPuntoDeInteres(HttpServletRequest request, HttpServletResponse response,
								@PathVariable long idPuntoDeInteres,@PathVariable String idioma) {
		HashMap<String, PuntoDeInteresDTO> lista = new HashMap<String, PuntoDeInteresDTO>();
		PuntoIdioma punto = puntoIdiomaDao.get(idPuntoDeInteres, idioma);
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.indexOf("punto"));
		PuntoDeInteresDTO dto = PuntoMapper.map(punto);
		if (punto.getAudio() != null) {
			dto.setAudio(url + "audioPunto?id=" + punto.getId());
		}
		dto.setImagen(DatatypeConverter.printBase64Binary(punto.getPuntoDeInteres().getImagen()));
		lista.put(DATA, dto);
		return lista;
	}
	
	@RequestMapping(path="/crearPunto",method=RequestMethod.POST)
	public HashMap<String, Boolean> crearPunto(@RequestParam("nombre") String nombre,
			@RequestParam("descripcion") String descripcion,
			@RequestParam("idioma") String idioma,
			@RequestParam(name="imagen") MultipartFile imagen,
			@RequestParam(name="idAtraccion",required=false) Integer idAtraccion,
			@RequestParam(name="audio",required=false) MultipartFile audio) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		List<PuntoIdioma> listaPuntos = puntoIdiomaDao.listarPorAtraccionNuevo(idAtraccion,idioma);
		int orden = 0;
		for (PuntoIdioma puntoDeInteres : listaPuntos) {
			if (puntoDeInteres.getOrden() > orden) {
				orden = puntoDeInteres.getOrden();
			}
		}
		PuntoDeInteres punto = new PuntoDeInteres();
		punto.setNombre(nombre);
		punto.setImagen(imagen.getBytes());
		PuntoIdioma puntoIdioma = new PuntoIdioma();
		puntoIdioma.setDescripcion(descripcion);
		puntoIdioma.setIdioma(Idioma.valueOf(idioma));
		puntoIdioma.setOrden(++orden);
		if (audio != null ) {
			puntoIdioma.setAudio(audio.getBytes());
		}
		puntoIdioma.setPuntoDeInteres(punto);
		punto.add(puntoIdioma);
		puntoDao.guardar(puntoIdioma);
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
		puntoIdiomaDao.cambiarOrdenes(ordenPuntos);
		return lista;
	}
	
	@RequestMapping(path="/borrarPunto",method=RequestMethod.POST)
	public HashMap<String, Boolean> borrarPunto(@RequestParam("id") Integer id,@RequestParam("idAtraccion") Integer idAtraccion) {
		HashMap<String, Boolean> respuesta = new HashMap<String, Boolean>();
		puntoIdiomaDao.borrar(id);
		PuntoIdioma punto = puntoIdiomaDao.get(new Long(id));
		Set<PuntoIdioma> lista = new LinkedHashSet(punto.getPuntoDeInteres().getListaPuntoIdioma());
		int cont = 0;
		for (PuntoIdioma puntoIdioma : lista) {
			if (puntoIdioma.getBorrado() == 0) {
				cont++;
			}
		}
		if (cont == 0) {
			puntoDao.borrar(punto.getPuntoDeInteres().getId());
		}
		return respuesta;
	}
	
	@RequestMapping(path="/modificarPunto",method=RequestMethod.POST)
	public HashMap<String, Boolean> modificarPunto(@RequestParam(name="id") Long id, @RequestParam("nombre") String nombre,
			@RequestParam("descripcion") String descripcion, @RequestParam(name="imagenCambiada") Long imagenCambiada,
			@RequestParam(name="imagen", required=false) MultipartFile imagen, @RequestParam(name="audioCambiado") Long audioCambiado,
			@RequestParam(name="audio", required=false) MultipartFile audio) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		PuntoIdioma punto = puntoIdiomaDao.get(id);
		punto.getPuntoDeInteres().setNombre(nombre);
		punto.setDescripcion(descripcion);
		if (imagenCambiada == 1) {
			punto.getPuntoDeInteres().setImagen(imagen.getBytes());
		}
		if (audioCambiado == 1) {
			punto.setAudio(null);
			if (audio != null) {
				punto.setAudio(audio.getBytes());
			}
		}
		puntoDao.modificar(punto);
		lista.put(EXISTE, true);
		return lista;
	}
	
	@RequestMapping(path="/checkAgregarLenguajePunto",method=RequestMethod.POST)
	public Boolean needToHidePointAddLanguageButton(@RequestParam("id") Long idPunto) throws IOException {
		PuntoDeInteres a = puntoDao.get(idPunto);
		LinkedHashSet<PuntoIdioma> listaIdiomas = new LinkedHashSet<PuntoIdioma>(a.getListaPuntoIdioma());
		if (listaIdiomas.size() > 1 ) {
			return true;
		}
		return false;
	}
	
	@RequestMapping(path="/agregarLenguajePunto",method=RequestMethod.POST)
	public HashMap<String, Boolean> crearPunto(@RequestParam("id") Long idPunto,
			@RequestParam("descripcion") String descripcion,
			@RequestParam(name="audio",required=false) MultipartFile audio) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		PuntoDeInteres a = puntoDao.get(idPunto);
		LinkedHashSet<PuntoIdioma> listaIdiomas = new LinkedHashSet<PuntoIdioma>(a.getListaPuntoIdioma());
		if (listaIdiomas.size() > 1 ) {
			lista.put(EXISTE, false);
			return lista;
		}
		Idioma idioma = a.getListaPuntoIdioma().get(0).getIdioma();
		if (idioma == Idioma.EN) {
			idioma = Idioma.ES;
		} else {
			idioma = Idioma.EN;
		}
		PuntoIdioma punto = new PuntoIdioma();
		punto.setDescripcion(descripcion);
		punto.setIdioma(idioma);
		if (audio != null ) {
			punto.setAudio(audio.getBytes());
		}
		punto.setPuntoDeInteres(a);;
		a.add(punto);
		puntoIdiomaDao.guardar(punto);
		lista.put(EXISTE, true);
		return lista;
	}
}
