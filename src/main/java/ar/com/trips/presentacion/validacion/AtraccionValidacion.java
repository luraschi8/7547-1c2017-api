package ar.com.trips.presentacion.validacion;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.modelo.Atraccion;

public class AtraccionValidacion {
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	public List<String> validar(Atraccion atraccion) {
		List<String> listaErrores = new ArrayList<>();
		if (atraccion.getNombre().equals("")) {
			listaErrores.add("El nombre de la atraccion no puede estar vacio");
		}
		if (atraccionDao.atraccionExistente(atraccion)) {
			listaErrores.add("Esa atraccion ya se encuentra registrada");
		}
		return listaErrores;
	}

}
