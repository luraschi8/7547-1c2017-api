package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.CiudadModelo;
import ar.com.trips.presentacion.validacion.CiudadValidacion;

@RestController
public class CiudadControladorRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private ICiudadDAO ciudadDao;
	
	@Autowired
	CiudadValidacion ciudadValidacion;
	
	@RequestMapping("/ciudadesJson")
	public HashMap<String, List> listar() {
		HashMap<String, List> lista = new HashMap<String, List>();
		List<CiudadModelo> listaAux = ciudadDao.listar();
		int p = 7;
		int d = 5;
		for (CiudadModelo ciudadModelo : listaAux) {
			ciudadModelo.setCantAtracciones(ciudadModelo.getListaAtracciones().size());
		}
		lista.put(DATA, listaAux);
		return lista;
	}
	
	@RequestMapping("/validarCiudad")
	public HashMap<String, Boolean> validarCiudad(@RequestBody CiudadModelo ciudad) {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		List<String> listaErrores = ciudadValidacion.validar(ciudad);
		if (listaErrores.size() != 0) {
			lista.put(EXISTE, true);
		} else {
			lista.put(EXISTE, false);
		}
		return lista;
	}

}
