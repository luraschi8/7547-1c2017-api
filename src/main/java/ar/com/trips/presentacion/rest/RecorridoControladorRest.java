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

import ar.com.trips.persistencia.dao.IRecorridoDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Recorrido;
import ar.com.trips.presentacion.dto.AtraccionDTO;
import ar.com.trips.presentacion.dto.RecorridoDTO;
import ar.com.trips.presentacion.mapper.AtraccionMapper;
import ar.com.trips.presentacion.validacion.RecorridoValidacion;

@RestController
public class RecorridoControladorRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IRecorridoDAO recorridoDao;
	
	@Autowired
	RecorridoValidacion recorridoValidacion;
	
	@RequestMapping("/recorridosJson")
	public HashMap<String, List<Recorrido>> listar() {
		HashMap<String, List<Recorrido>> lista = new HashMap<String, List<Recorrido>>();
		lista.put(DATA, recorridoDao.listar(Recorrido.class));
		return lista;
	}

	
	@RequestMapping(path="/recorridosCiudadJson/{idCiudad}", method=RequestMethod.GET)
	public HashMap<String, List<Recorrido>> listarRecorridoCiudad(@PathVariable int idCiudad) {
		HashMap<String, List<Recorrido>> lista = new HashMap<String, List<Recorrido>>();
		List<Recorrido> list = recorridoDao.listarPorCiudad(idCiudad);
		lista.put(DATA, list);
		return lista;
	}
	
	@RequestMapping(path="/recorrido/{idRecorrido}", method=RequestMethod.GET)
	public HashMap<String, RecorridoDTO> getAtraccion(HttpServletRequest request, HttpServletResponse response,
								@PathVariable long idRecorrido) {
		HashMap<String, RecorridoDTO> lista = new HashMap<String, RecorridoDTO>();
		Recorrido a = recorridoDao.get(idRecorrido);
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.indexOf("recorrido"));
		RecorridoDTO dto = new RecorridoDTO();
		dto.setId(idRecorrido);
		dto.setNombre(a.getNombre());
		dto.setDescripcion(a.getDescripcion());
		dto.setIdioma(a.getIdioma());
		lista.put(DATA, dto);
		return lista;
	}
	
	@RequestMapping(path="/validarRecorrido", method=RequestMethod.POST)
	public HashMap<String, Boolean> validarRecorrido(@RequestBody Recorrido recorrido) {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		List<String> listaErrores = recorridoValidacion.validar(recorrido);
		if (listaErrores.size() != 0) {
			lista.put(EXISTE, true);
		} else {
			lista.put(EXISTE, false);
		}
		return lista;
	}
	
	@RequestMapping(path="/atraccionesFueraDelRecorridoNuevoJson/{idCiudad}", method=RequestMethod.GET)
	public HashMap<String, List<AtraccionDTO>> getAtraccionesFueraDelRecorridoNuevo(@PathVariable int idCiudad) {
		HashMap<String, List<AtraccionDTO>> lista = new HashMap<String, List<AtraccionDTO>>();
		List<Atraccion> list = recorridoDao.listarAtraccionesFueraDelRecorridoNuevo(idCiudad);
		List<AtraccionDTO> listaRetorno = new ArrayList<>();
		for (Atraccion a : list) {
			AtraccionDTO dto = AtraccionMapper.map(a);
			if (a.getListaImagenes().size() > 0) {
				dto.setImagen(DatatypeConverter.printBase64Binary(a.getListaImagenes().get(0).getImagen()));
			}
			listaRetorno.add(dto);
		}
		lista.put(DATA, listaRetorno);
		return lista;
	}
	
	@RequestMapping(path="/atraccionesEnElRecorridoNuevoJson/{idCiudad}", method=RequestMethod.GET)
	public HashMap<String, List<AtraccionDTO>> listarAtraccionesEnElRecorridoNuevo(@PathVariable int idCiudad) {
		HashMap<String, List<AtraccionDTO>> lista = new HashMap<String, List<AtraccionDTO>>();
		List<Atraccion> list = recorridoDao.listarAtraccionesEnElRecorridoNuevo();
		List<AtraccionDTO> listaRetorno = new ArrayList<>();
		for (Atraccion a : list) {
			AtraccionDTO dto = AtraccionMapper.map(a);
			if (a.getListaImagenes().size() > 0) {
				dto.setImagen(DatatypeConverter.printBase64Binary(a.getListaImagenes().get(0).getImagen()));
			}
		}
		lista.put(DATA, listaRetorno);
		return lista;
	}
	
	/*@RequestMapping(path="/atraccionesEnElRecorridoCiudadJson/{idRecorrido}", method=RequestMethod.GET)
	public HashMap<String, List<Atraccion>> listarAtraccionesEnElRecorrido(@PathVariable int idCiudad) {
		HashMap<String, List<Atraccion>> lista = new HashMap<String, List<Atraccion>>();
		List<Atraccion> list = atraccionDao.listarPorCiudad(idCiudad);
		for (Atraccion a : list) {
			if (a.getListaImagenes().size() > 0) {
				a.setImagen(a.getListaImagenes().get(0).getImagen());
			}
		}
		lista.put(DATA, list);
		return lista;
	}*/
}