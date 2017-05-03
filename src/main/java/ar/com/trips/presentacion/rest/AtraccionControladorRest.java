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
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.ImagenAtraccion;
import ar.com.trips.presentacion.dto.AtraccionDTO;
import ar.com.trips.presentacion.validacion.AtraccionValidacion;

@RestController
public class AtraccionControladorRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@Autowired
	AtraccionValidacion atraccionValidacion;
	
	@RequestMapping("/atraccionesJson")
	public HashMap<String, List> listar() {
		HashMap<String, List> lista = new HashMap<String, List>();
		lista.put(DATA, atraccionDao.listar(Atraccion.class));
		return lista;
	}

	
	@RequestMapping(path="/atraccionesCiudadJson/{idCiudad}",method=RequestMethod.GET)
	public HashMap<String, List> listarAtraccionesCiudad(@PathVariable int idCiudad) {
		HashMap<String, List> lista = new HashMap<String, List>();
		List<Atraccion> list = atraccionDao.listarPorCiudad(idCiudad);
		for (Atraccion a : list) {
			if (a.getListaImagenes().size() > 0) {
				a.setImagen(a.getListaImagenes().get(0).getImagen());
			}
		}
		lista.put(DATA, list);
		return lista;
	}
	
	@RequestMapping(path="/atraccion/{idAtraccion}",method=RequestMethod.GET)
	public HashMap<String, AtraccionDTO> getAtraccion(HttpServletRequest request, HttpServletResponse response,
								@PathVariable long idAtraccion) {
		HashMap<String, AtraccionDTO> lista = new HashMap<String, AtraccionDTO>();
		Atraccion a = atraccionDao.get(idAtraccion);
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.indexOf("atraccion"));
		AtraccionDTO dto = new AtraccionDTO();
		dto.setId(idAtraccion);
		dto.setNombre(a.getNombre());
		dto.setHorario(a.getHorario());
		dto.setDescripcion(a.getDescripcion());
		dto.setPrecio(a.getPrecio());
		dto.setLatitud(a.getLatitud());
		dto.setLongitud(a.getLongitud());
		dto.setRecorrible(a.getRecorrible());
		dto.setIdioma(a.getIdioma());
		if (a.getAudioEN() != null) {
			dto.setAudioEN(url + "audioAtraccion?id=" + a.getId());
		}
		if (a.getPlano() != null) {
			dto.setPlano(url + "planoAtraccion?id=" + a.getId());
		}
		List<String> imagenes = new ArrayList<>();
		for (ImagenAtraccion i : a.getListaImagenes()) {
			imagenes.add(DatatypeConverter.printBase64Binary(i.getImagen()));
		}
		dto.setListaImagenes(imagenes);
		if (a.getVideo() != null) {
			dto.setVideo(url + "videoAtraccion?id=" + a.getId());
		}
		lista.put(DATA, dto);
		return lista;
	}
	
	@RequestMapping(path="/validarAtraccion",method=RequestMethod.POST)
	public HashMap<String, Boolean> validarAtraccion(@RequestBody Atraccion atraccion) {
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