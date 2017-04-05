package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.List;

import org.hibernate.tool.hbm2ddl.DatabaseMetadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.Ciudad;
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
		List<Ciudad> listaAux = ciudadDao.listar(Ciudad.class);
		for (Ciudad ciudad : listaAux) {
			ciudad.setCantAtracciones(ciudad.getListaAtracciones().size());
		}
		lista.put(DATA, listaAux);
		return lista;
	}
	
	@RequestMapping("/validarCiudad")
	public HashMap<String, Boolean> validarCiudad(@RequestBody Ciudad ciudad) {
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
