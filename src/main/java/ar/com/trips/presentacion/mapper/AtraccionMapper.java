package ar.com.trips.presentacion.mapper;

import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.AtraccionIdioma;
import ar.com.trips.presentacion.dto.AtraccionDTO;

public class AtraccionMapper {

	public static AtraccionDTO map(AtraccionIdioma atraccion) {
		AtraccionDTO dto = new AtraccionDTO();
		dto.setId(atraccion.getId());
		dto.setNombre(atraccion.getAtraccion().getNombre());
		dto.setHorario(atraccion.getHorario());
		dto.setDescripcion(atraccion.getDescripcion());
		dto.setPrecio(atraccion.getPrecio());
		dto.setLatitud(atraccion.getAtraccion().getLatitud());
		dto.setLongitud(atraccion.getAtraccion().getLongitud());
		dto.setRecorrible(atraccion.getAtraccion().getRecorrible());
		dto.setIdioma(atraccion.getIdioma());
		return dto;
	}
	
	public static AtraccionDTO map(Atraccion atraccion) {
		AtraccionDTO dto = new AtraccionDTO();
		dto.setId(atraccion.getId());
		dto.setNombre(atraccion.getNombre());
		dto.setLatitud(atraccion.getLatitud());
		dto.setLongitud(atraccion.getLongitud());
		dto.setRecorrible(atraccion.getRecorrible());
		return dto;
	}
	
}
