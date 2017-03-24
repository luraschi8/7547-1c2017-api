package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.CiudadModelo;

@RestController
public class CiudadControladorRest {
	
	public static final String DATA = "data";
	
	@Autowired
	private ICiudadDAO ciudadDao;
	
	@RequestMapping("/ciudadesJson")
	public HashMap<String, List> listar() {
		HashMap<String, List> lista = new HashMap<String, List>();
		List<CiudadModelo> listaAux = ciudadDao.listar(CiudadModelo.class);
		for (CiudadModelo ciudadModelo : listaAux) {
			ciudadModelo.setCantAtracciones(ciudadModelo.getListaAtracciones().size());
		}
		lista.put(DATA, listaAux);
		return lista;
	}

}
