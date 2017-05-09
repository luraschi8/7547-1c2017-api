package ar.com.trips.presentacion.mapper;

import javax.xml.bind.DatatypeConverter;

import ar.com.trips.persistencia.modelo.PuntoIdioma;
import ar.com.trips.presentacion.dto.PuntoDeInteresDTO;

public class PuntoMapper {

	public static PuntoDeInteresDTO map(PuntoIdioma atraccion) {
		PuntoDeInteresDTO dto = new PuntoDeInteresDTO();
		dto.setId(atraccion.getId());
		dto.setNombre(atraccion.getPuntoDeInteres().getNombre());
		dto.setDescripcion(atraccion.getDescripcion());
		dto.setImagen(DatatypeConverter.printBase64Binary(atraccion.getPuntoDeInteres().getImagen()));
		return dto;
	}
	
	
}
