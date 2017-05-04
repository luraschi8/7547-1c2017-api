package ar.com.trips.presentacion.validacion;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import ar.com.trips.persistencia.dao.IRecorridoDAO;
import ar.com.trips.persistencia.modelo.Recorrido;

public class RecorridoValidacion {
	
	@Autowired
	private IRecorridoDAO recorridoDao;
	
	public List<String> validar(Recorrido recorrido) {
		List<String> listaErrores = new ArrayList<>();
		if (recorrido.getNombre().equals("")) {
			listaErrores.add("El nombre del recorrido no puede estar vacío");
		}
		if (recorridoDao.recorridoExistente(recorrido)) {
			listaErrores.add("Ese recorrido ya se encuentra registrado");
		}
		return listaErrores;
	}
}