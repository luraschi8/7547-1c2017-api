package ar.com.trips.presentacion.validacion;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.CiudadModelo;

public class CiudadValidacion {
	
	@Autowired
	private ICiudadDAO ciudadDao;
	
	public List<String> validar(CiudadModelo ciudadModelo) {
		List<String> listaErrores = new ArrayList<>();
		if (ciudadModelo.getNombre().equals("")) {
			listaErrores.add("El nombre de la ciudad no puede estar vacio");
		}
		if (ciudadDao.ciudadExistente(ciudadModelo)) {
			listaErrores.add("Esa ciudad ya se encuentra registrada");
		}
		return listaErrores;
	}

}
