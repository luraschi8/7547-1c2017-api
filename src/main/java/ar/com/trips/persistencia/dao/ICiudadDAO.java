package ar.com.trips.persistencia.dao;

import ar.com.trips.persistencia.modelo.Ciudad;

public interface ICiudadDAO extends IDAO {

	Ciudad get(Long id);
	
	boolean ciudadExistente(Ciudad ciudadModelo);
	
	void borrar(long id);

}