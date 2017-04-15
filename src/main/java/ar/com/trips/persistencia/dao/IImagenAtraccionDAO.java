package ar.com.trips.persistencia.dao;

import ar.com.trips.persistencia.modelo.ImagenAtraccion;

public interface IImagenAtraccionDAO extends IDAO {

	ImagenAtraccion get(Long id);
	
	ImagenAtraccion getImagenPrincipal(Integer idAtraccion);
	
	void borrar(long id);
	
}
