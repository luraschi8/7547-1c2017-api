package ar.com.trips.presentacion.mapper;

import javax.xml.bind.DatatypeConverter;

import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.AtraccionIdioma;
import ar.com.trips.presentacion.dto.AtraccionDTO;

public class AtraccionMapper {

	public static AtraccionDTO map(AtraccionIdioma atraccion) {
		AtraccionDTO dto = new AtraccionDTO();
		dto.setId(atraccion.getId());
		dto.setIdAtraccion(atraccion.getAtraccion().getId());
		dto.setNombre(atraccion.getAtraccion().getNombre());
		dto.setHorario(atraccion.getHorario());
		dto.setDescripcion(atraccion.getDescripcion());
		dto.setPrecio(atraccion.getPrecio());
		dto.setLatitud(atraccion.getAtraccion().getLatitud());
		dto.setLongitud(atraccion.getAtraccion().getLongitud());
		dto.setRecorrible(atraccion.getAtraccion().getRecorrible());
		dto.setIdioma(atraccion.getIdioma());
		if (atraccion.getAtraccion().getListaImagenes().size() > 0) {
			dto.setImagen(DatatypeConverter.printBase64Binary(atraccion.getAtraccion().getListaImagenes().get(0).getImagen()));
		}
		return dto;
	}
	
	public static AtraccionDTO map(Atraccion atraccion) {
		AtraccionDTO dto = new AtraccionDTO();
		dto.setId(atraccion.getId());
		dto.setNombre(atraccion.getNombre());
		dto.setLatitud(atraccion.getLatitud());
		dto.setLongitud(atraccion.getLongitud());
		dto.setRecorrible(atraccion.getRecorrible());
		if (atraccion.getListaImagenes().size() > 0) {
			dto.setImagen(DatatypeConverter.printBase64Binary(atraccion.getListaImagenes().get(0).getImagen()));
		}
		return dto;
	}
	
}
