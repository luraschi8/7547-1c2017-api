package ar.com.trips.presentacion.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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

	
	@RequestMapping(path="/atraccionesCiudadJson/{idCiudad}/{idioma}",method=RequestMethod.GET)
	public HashMap<String, List<AtraccionDTO>> listarAtraccionesCiudad(@PathVariable int idCiudad, @PathVariable String idioma) {
		if (!Idioma.contains(idioma)) {
			return null;
		}
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
		List<String> listaErrores = atraccionValidacion.validar(atraccion);
		if (listaErrores.size() != 0) {
			lista.put(EXISTE, true);
		} else {
			lista.put(EXISTE, false);
		}
		return lista;
	}
}