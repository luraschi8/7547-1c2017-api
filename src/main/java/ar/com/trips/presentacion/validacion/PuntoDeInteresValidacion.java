package ar.com.trips.presentacion.validacion;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import ar.com.trips.persistencia.dao.IPuntoDeInteresDAO;
import ar.com.trips.persistencia.dao.IPuntoDeInteresIdiomaDAO;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;
import ar.com.trips.persistencia.modelo.PuntoIdioma;

public class PuntoDeInteresValidacion {
	
	@Autowired
	private IPuntoDeInteresIdiomaDAO puntoDao;
	
	public List<String> validar(PuntoIdioma punto) {
		List<String> listaErrores = new ArrayList<>();
		if (punto.getNombre().equals("")) {
			listaErrores.add("El nombre del punto no puede estar vacio");
		}
		if (puntoDao.puntoExistente(punto)) {
			listaErrores.add("Esa punto ya se encuentra registrada");
		}
		return listaErrores;
	}

}
