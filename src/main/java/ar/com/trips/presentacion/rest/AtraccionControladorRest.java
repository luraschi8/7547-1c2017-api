package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Ciudad;
import ar.com.trips.presentacion.validacion.AtraccionValidacion;
import ar.com.trips.presentacion.validacion.CiudadValidacion;

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
		lista.put(DATA, atraccionDao.listarPorCiudad(idCiudad));
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
