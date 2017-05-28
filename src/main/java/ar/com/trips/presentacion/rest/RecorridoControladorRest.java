package ar.com.trips.presentacion.rest;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.LinkedList;
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

import ar.com.trips.persistencia.dao.IAtraccionDAO;
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
import ar.com.trips.util.enums.Idioma;

@RestController
public class RecorridoControladorRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IRecorridoDAO recorridoDao;
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
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
		for (Recorrido recorrido : list) {
			recorrido.setCantAtracciones(recorrido.getListaAtraccionesEnElRecorrido().size());
		}
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
		if (a.getAudio() != null) {
			dto.setAudio(url + "audioRecorrido?id=" + a.getId());
		}
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
		String atracciones_separadas[] = recorrido.getAtraccionesOrdenadas().split(",");
		for (int i = 0; i < atracciones_separadas.length; i++) {
			Atraccion atraccion  = atraccionDao.get(Long.parseLong(atracciones_separadas[i]));
			AtraccionDTO dto = AtraccionMapper.map(atraccion);
			dto.setOrden(new Long(i+1));
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
		List<AtraccionIdioma> list = atraccionIdiomaDao.listarPorCiudad((int)recorrido.getCiudad().getId(), idioma);
		for (Atraccion a : recorrido.getListaAtraccionesEnElRecorrido()) {
			listaAtracciones.put(a.getId(), a);
		}		
		LinkedList<AtraccionDTO> listaRetornoBis = new LinkedList<>();
		for(AtraccionIdioma a : list) {
			if (!listaAtracciones.containsKey(a.getAtraccion().getId()) && (a.getAtraccion().getBorrado() == 0)) {
				AtraccionDTO dto = AtraccionMapper.map(a.getAtraccion());
				if (a.getAtraccion().getListaImagenes().size() > 0) {
					dto.setImagen(DatatypeConverter.printBase64Binary(a.getAtraccion().getListaImagenes().get(0).getImagen()));
				}				
				listaRetornoBis.add(dto);
			}
		}
		lista.put(DATA, listaRetornoBis);
		return lista;
	}
	
	@RequestMapping(path="/checkLenguajeRecorridoExiste", method=RequestMethod.POST)
	public Boolean languageOfRouteExists(@RequestParam("id") Long id,
			@RequestParam("language") String language) throws IOException {
		Recorrido rec = recorridoDao.get(id);
		LinkedHashSet<RecorridoIdioma> listaIdiomas = new LinkedHashSet<RecorridoIdioma>(rec.getListaRecorridoIdioma());
		if (listaIdiomas.size() > 1) {
			return true;
		} else {
			if (((RecorridoIdioma) listaIdiomas.toArray()[0]).getIdioma().toString().equals(language)) {
				return true;
			}
		}
		return false;
	}
	
	@RequestMapping(path="/checkAgregarLenguajeRecorrido",method=RequestMethod.POST)
	public Boolean needToHideRouteAddLanguageButton(@RequestParam("id") Long id) throws IOException {
		Recorrido rec = recorridoDao.get(id);
		LinkedHashSet<RecorridoIdioma> listaIdiomas = new LinkedHashSet<RecorridoIdioma>(rec.getListaRecorridoIdioma());
		if (listaIdiomas.size() > 1 ) {
			return true;
		}
		return false;
	}
	
	@RequestMapping(path="/agregarLenguajeRecorrido",method=RequestMethod.POST)
	public HashMap<String, Boolean> crearPunto(@RequestParam("id") Long id,
			@RequestParam("descripcion") String descripcion,
			@RequestParam(name="audio",required=false) MultipartFile audio) throws IOException {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		Recorrido rec = recorridoDao.get(id);
		LinkedHashSet<RecorridoIdioma> listaIdiomas = new LinkedHashSet<RecorridoIdioma>(rec.getListaRecorridoIdioma());
		if (listaIdiomas.size() > 1 ) {
			lista.put(EXISTE, false);
			lista.put("otroIdioma", true);
			return lista;
		}
		Idioma idioma = rec.getListaRecorridoIdioma().get(0).getIdioma();
		if (idioma == Idioma.EN) {
			idioma = Idioma.ES;
		} else {
			idioma = Idioma.EN;
		}
		int contador = 0;
		for(Atraccion a : rec.getListaAtraccionesEnElRecorrido()) {
			Set<AtraccionIdioma> listaAtraccionIdiomas = new HashSet<AtraccionIdioma>(a.getListaAtraccionIdioma());
			for (AtraccionIdioma aIdioma : listaAtraccionIdiomas) {
				if (aIdioma.getIdioma() == idioma) {
					contador++;
				}
			}
		}
		if (contador < 2) {
			lista.put(EXISTE, false);
			lista.put("otroIdioma", false);
			return lista;
		}
		RecorridoIdioma recorrido = new RecorridoIdioma();
		recorrido.setDescripcion(descripcion);
		recorrido.setIdioma(idioma);
		if (audio != null ) {
			recorrido.setAudio(audio.getBytes());
		}
		recorrido.setRecorrido(rec);
		rec.addRecorridoIdioma(recorrido);
		recorridoIdiomaDao.guardar(recorrido);
		lista.put(EXISTE, true);
		return lista;
	}
}