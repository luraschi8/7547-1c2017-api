package ar.com.trips.presentacion.rest;

import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import static java.lang.Math.toIntExact;

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
import ar.com.trips.persistencia.dao.IRecorridoIdiomaDAO;
import ar.com.trips.persistencia.dao.impl.AtraccionIdiomaDAOImpl;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.AtraccionIdioma;
import ar.com.trips.persistencia.modelo.Recorrido;
import ar.com.trips.persistencia.modelo.RecorridoIdioma;
import ar.com.trips.presentacion.dto.AtraccionDTO;
import ar.com.trips.presentacion.dto.RecorridoDTO;
import ar.com.trips.presentacion.mapper.AtraccionMapper;
import ar.com.trips.presentacion.mapper.RecorridoMapper;
import ar.com.trips.presentacion.validacion.RecorridoValidacion;

@RestController
public class RecorridoControladorRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IRecorridoDAO recorridoDao;
	
	@Autowired
	private IRecorridoIdiomaDAO recorridoIdiomaDao;
	
	@Autowired
	RecorridoValidacion recorridoValidacion;
	
	@Autowired
	AtraccionIdiomaDAOImpl atraccionIdiomaDao;
	
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
	
	@RequestMapping(path="/recorrido/{idRecorrido}/{idioma}", method=RequestMethod.GET)
	public HashMap<String, RecorridoDTO> getAtraccion(HttpServletRequest request, HttpServletResponse response,
								@PathVariable long idRecorrido,@PathVariable String idioma) {
		HashMap<String, RecorridoDTO> lista = new HashMap<String, RecorridoDTO>();
		RecorridoIdioma a = recorridoIdiomaDao.get(idRecorrido,idioma);
		String url = request.getRequestURL().toString();
		url = url.substring(0, url.indexOf("recorrido"));
		RecorridoDTO dto = RecorridoMapper.map(a);
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
	
	@RequestMapping(path="/atraccionesEnElRecorridoNuevoJson/{idCiudad}", method=RequestMethod.GET)
	public HashMap<String, Set<AtraccionDTO>> listarAtraccionesEnElRecorridoNuevo(@PathVariable int idCiudad) {
		HashMap<String, Set<AtraccionDTO>> lista = new HashMap<String, Set<AtraccionDTO>>();
		List<Atraccion> list = recorridoDao.listarAtraccionesEnElRecorridoNuevo();
		Set<AtraccionDTO> listaRetorno = new LinkedHashSet<>();
		for (Atraccion a : list) {
			AtraccionDTO dto = AtraccionMapper.map(a);
			if (a.getListaImagenes().size() > 0) {
				dto.setImagen(DatatypeConverter.printBase64Binary(a.getListaImagenes().get(0).getImagen()));
			}
		}
		lista.put(DATA, listaRetorno);
		return lista;
	}
	
	@RequestMapping(path="/atraccionesRecorridoJson/{idRecorrido}", method=RequestMethod.GET)
	public HashMap<String, Set<AtraccionDTO>> listarAtraccionesRecorrido(@PathVariable Long idRecorrido) {
		HashMap<String, Set<AtraccionDTO>> lista = new HashMap<String, Set<AtraccionDTO>>();
		Recorrido recorrido = recorridoDao.get(idRecorrido);
		Set<AtraccionDTO> listaRetorno = new LinkedHashSet<>();
		for (Atraccion a : recorrido.getListaAtraccionesEnElRecorrido()) {
			AtraccionDTO dto = AtraccionMapper.map(a);
			if (a.getListaImagenes().size() > 0) {
				dto.setImagen(DatatypeConverter.printBase64Binary(a.getListaImagenes().get(0).getImagen()));
			}
			listaRetorno.add(dto);
		}
		lista.put(DATA, listaRetorno);
		return lista;
	}
	
	@RequestMapping(path="/atraccionesFueraRecorridoJson/{idRecorrido}", method=RequestMethod.GET)
	public HashMap<String, Collection<AtraccionDTO>> listarAtraccionesFueraRecorrido(@PathVariable Long idRecorrido) {
		HashMap<String, Collection<AtraccionDTO>> lista = new HashMap<String, Collection<AtraccionDTO>>();
		Recorrido recorrido = recorridoDao.get(idRecorrido);
		HashMap<Long,Atraccion> listaAtracciones = new HashMap<>();
		for (Atraccion a : recorrido.getListaAtraccionesEnElRecorrido()) {
			listaAtracciones.put(a.getId(), a);
		}
		HashMap<Long,AtraccionDTO> listaRetorno = new HashMap<>();
		for(Atraccion a : recorrido.getCiudad().getListaAtracciones()) {
			if (!listaAtracciones.containsKey(a.getId()) && !listaRetorno.containsKey(a.getId())) {
				AtraccionDTO dto = AtraccionMapper.map(a);
				if (a.getListaImagenes().size() > 0) {
					dto.setImagen(DatatypeConverter.printBase64Binary(a.getListaImagenes().get(0).getImagen()));
				}
				listaRetorno.put(dto.getId(),dto);
			}
		}
		lista.put(DATA, listaRetorno.values());
		return lista;
	}
	
	@RequestMapping(path="/atraccionesFueraRecorridoJson/{idRecorrido}/{idioma}",method=RequestMethod.GET)
	public HashMap<String, Collection<AtraccionDTO>> listarAtraccionesFueraRecorridoIdioma(@PathVariable Long idRecorrido, @PathVariable String idioma) {
		HashMap<String, Collection<AtraccionDTO>> lista = new HashMap<String, Collection<AtraccionDTO>>();
		Recorrido recorrido = recorridoDao.get(idRecorrido);
		HashMap<Long,Atraccion> listaAtracciones = new HashMap<>();
		List<AtraccionIdioma> list = atraccionIdiomaDao.listarPorCiudad(toIntExact(recorrido.getCiudad().getId()), idioma);;
		for (Atraccion a : recorrido.getListaAtraccionesEnElRecorrido()) {
			listaAtracciones.put(a.getId(), a);
		}
		HashMap<Long,AtraccionDTO> listaRetorno = new HashMap<>();
		for(AtraccionIdioma a : list) {
			if (!listaAtracciones.containsKey(a.getId()) && !listaRetorno.containsKey(a.getId())) {
				AtraccionDTO dto = AtraccionMapper.map(a);
				if (a.getAtraccion().getListaImagenes().size() > 0) {
					dto.setImagen(DatatypeConverter.printBase64Binary(a.getAtraccion().getListaImagenes().get(0).getImagen()));
				}
				listaRetorno.put(dto.getId(),dto);
			}
		}
		lista.put(DATA, listaRetorno.values());
		return lista;
	}
}