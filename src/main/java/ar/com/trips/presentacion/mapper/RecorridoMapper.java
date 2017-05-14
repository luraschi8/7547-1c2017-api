package ar.com.trips.presentacion.mapper;

import ar.com.trips.persistencia.modelo.RecorridoIdioma;
import ar.com.trips.presentacion.dto.RecorridoDTO;

public class RecorridoMapper {

	public static RecorridoDTO map(RecorridoIdioma recorrido) {
		RecorridoDTO dto = new RecorridoDTO();
		dto.setId(recorrido.getId());
		dto.setNombre(recorrido.getRecorrido().getNombre());
		dto.setDescripcion(recorrido.getDescripcion());
		dto.setIdRecorrido(recorrido.getRecorrido().getId());
		return dto;
	}
	
	
}
