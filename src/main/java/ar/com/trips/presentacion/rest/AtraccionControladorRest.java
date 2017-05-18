package ar.com.trips.presentacion.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
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

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.IAtraccionIdiomaDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.AtraccionIdioma;
import ar.com.trips.persistencia.modelo.ImagenAtraccion;
import ar.com.trips.presentacion.dto.AtraccionDTO;
import ar.com.trips.presentacion.mapper.AtraccionMapper;
import ar.com.trips.presentacion.validacion.AtraccionValidacion;
import ar.com.trips.util.enums.Idioma;

@RestController
public class AtraccionControladorRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@Autowired
	private IAtraccionIdiomaDAO atraccionIdiomaDao;
	
	@Autowired
	AtraccionValidacion atraccionValidacion;
	
	@RequestMapping("/atraccionesJson")
	public HashMap<String, List<Atraccion>> listar() {
		HashMap<String, List<Atraccion>> lista = new HashMap<String, List<Atraccion>>();
		lista.put(DATA, atraccionDao.listar(Atraccion.class));
		return lista;
	}

	@RequestMapping(path="/atraccionesCiudadJson/{idCiudad}",method=RequestMethod.GET)
	public HashMap<String, List<AtraccionDTO>> listarAtraccionesCiudad(@PathVariable int idCiudad) {
		HashMap<String, List<AtraccionDTO>> lista = new HashMap<String, List<AtraccionDTO>>();
		List<AtraccionDTO> listaAtracciones = new ArrayList<>();
		List<Atraccion> list = atraccionDao.listarPorCiudad(idCiudad);
		for (Atraccion a : list) {
			AtraccionDTO atraccion = AtraccionMapper.map(a);
			if (a.getListaImagenes().size() > 0) {
				atraccion.setImagen(DatatypeConverter.printBase64Binary(a.getListaImagenes().get(0).getImagen()));
			}
			listaAtracciones.add(atraccion);
		}
		lista.put(DATA, listaAtracciones);
		return lista;
	}
	
	@RequestMapping(path="/atraccionesCiudadJson/{idCiudad}/{idioma}",method=RequestMethod.GET)
	public HashMap<String, List<AtraccionDTO>> listarAtraccionesCiudadIdioma(@PathVariable int idCiudad,@PathVariable String idioma) {
		HashMap<String, List<AtraccionDTO>> lista = new HashMap<String, List<AtraccionDTO>>();
		List<AtraccionDTO> listaAtracciones = new ArrayList<>();
		List<AtraccionIdioma> list = atraccionIdiomaDao.listarPorCiudad(idCiudad,idioma);
		for (AtraccionIdioma a : list) {
			AtraccionDTO atraccion = AtraccionMapper.map(a);
			if (a.getAtraccion().getListaImagenes().size() > 0) {
				atraccion.setImagen(DatatypeConverter.printBase64Binary(a.getAtraccion().getListaImagenes().get(0).getImagen()));
			}
			listaAtracciones.add(atraccion);
		}
		lista.put(DATA, listaAtracciones);
		return lista;
	}
	
	@RequestMapping(path="/atraccion/{idAtraccion}/{idioma}",method=RequestMethod.GET)
	public HashMap<String, AtraccionDTO> getAtraccion(HttpServletRequest request, HttpServletResponse response,
								@PathVariable long idAtraccion,@PathVariable String idioma) {
		HashMap<String, AtraccionDTO> lista = new HashMap<String, AtraccionDTO>();
		if (!Idioma.contains(idioma)) {
			return null;
		}
		AtraccionIdioma atraccion = atraccionIdiomaDao.get(idAtraccion,idioma);
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.indexOf("atraccion"));
		AtraccionDTO dto = AtraccionMapper.map(atraccion);
		if (atraccion.getAudio() != null) {
			dto.setAudioEN(url + "audioAtraccion?id=" + atraccion.getId());
		}
		if (atraccion.getAtraccion().getPlano() != null) {
			dto.setPlano(url + "planoAtraccion?id=" + atraccion.getAtraccion().getId());
		}
		List<String> imagenes = new ArrayList<>();
		for (ImagenAtraccion i : atraccion.getAtraccion().getListaImagenes()) {
			imagenes.add(DatatypeConverter.printBase64Binary(i.getImagen()));
		}
		dto.setListaImagenes(imagenes);
		if (atraccion.getAtraccion().getVideo() != null) {
			dto.setVideo(url + "videoAtraccion?id=" + atraccion.getAtraccion().getId());
		}
		lista.put(DATA, dto);
		return lista;
	}
	
	@RequestMapping(path="/validarAtraccion",method=RequestMethod.POST)
	public HashMap<String, Boolean> validarAtraccion(@RequestBody AtraccionIdioma atraccion) {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		List<String> listaErrores = atraccionValidacion.validar(atraccion.getAtraccion());
		if (listaErrores.size() != 0) {
			lista.put(EXISTE, true);
		} else {
			lista.put(EXISTE, false);
		}
		return lista;
	}
	
	@RequestMapping(path="/checkAgregarLenguajeAtraccion", method=RequestMethod.POST)
	public Boolean needToHideAtractionAddLanguageButton(@RequestParam("id") Long idAtraccion) throws IOException {
		Atraccion a = atraccionDao.get(idAtraccion);
		LinkedHashSet<AtraccionIdioma> listaIdiomas = new LinkedHashSet<AtraccionIdioma>(a.getListaAtraccionIdioma());
		if (listaIdiomas.size() > 1 ) {
			return true;
		}
		return false;
	}
	
	@RequestMapping(path="/agregarLenguajeAtraccion",method=RequestMethod.POST)
	public HashMap<String, Boolean> crearPunto(@RequestParam("id") Long idAtraccion,
			@RequestParam("descripcion") String descripcion,
			@RequestParam("horario") String horario,
			@RequestParam("precio") String precio,
			@RequestParam(name="audio",required=false) MultipartFile audio) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		Atraccion a = atraccionDao.get(idAtraccion);
		LinkedHashSet<AtraccionIdioma> listaIdiomas = new LinkedHashSet<AtraccionIdioma>(a.getListaAtraccionIdioma());
		if (listaIdiomas.size() > 1 ) {
			lista.put(EXISTE, false);
			return lista;
		}
		Idioma idioma = a.getListaAtraccionIdioma().get(0).getIdioma();
		if (idioma == Idioma.EN) {
			idioma = Idioma.ES;
		} else {
			idioma = Idioma.EN;
		}
		AtraccionIdioma atraccion = new AtraccionIdioma();
		atraccion.setDescripcion(descripcion);
		atraccion.setHorario(horario);
		atraccion.setPrecio(precio);
		atraccion.setIdioma(idioma);
		if (audio != null ) {
			atraccion.setAudio(audio.getBytes());
		}
		atraccion.setAtraccion(a);
		a.addAtraccionIdioma(atraccion);
		atraccionIdiomaDao.guardar(atraccion);
		lista.put(EXISTE, true);
		return lista;
	}
}