package ar.com.trips.presentacion.mapper;

import javax.xml.bind.DatatypeConverter;

import ar.com.trips.persistencia.modelo.PuntoIdioma;
import ar.com.trips.presentacion.dto.PuntoDeInteresDTO;

public class PuntoMapper {

	public static PuntoDeInteresDTO map(PuntoIdioma punto) {
		PuntoDeInteresDTO dto = new PuntoDeInteresDTO();
		dto.setId(punto.getId());
		dto.setNombre(punto.getPuntoDeInteres().getNombre());
		dto.setDescripcion(punto.getDescripcion());
		dto.setOrden(punto.getOrden());
		dto.setImagen(DatatypeConverter.printBase64Binary(punto.getPuntoDeInteres().getImagen()));
		dto.setIdPunto(punto.getPuntoDeInteres().getId());
		return dto;
	}
	
	
}
