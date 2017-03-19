package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.modelo.AtraccionModelo;

@RestController
public class AtraccionControladorRest {
	
	public static final String DATA = "data";
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@RequestMapping("/atraccionesJson")
	public HashMap<String, List> listar() {
		HashMap<String, List> lista = new HashMap<String, List>();
		lista.put(DATA, atraccionDao.listar(AtraccionModelo.class));
		return lista;
	}
	
	@RequestMapping(path = "/atraccionesCiudadJson/{idCiudad}", method = RequestMethod.GET)
	public HashMap<String, List> listarAtraccionesCiudad(@PathVariable int idCiudad) {
		HashMap<String, List> lista = new HashMap<String, List>();
		lista.put(DATA, atraccionDao.listarPorCiudad(idCiudad));
		return lista;
	}
}
