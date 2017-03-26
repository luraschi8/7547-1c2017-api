package ar.com.trips.persistencia.dao;

import ar.com.trips.persistencia.modelo.CiudadModelo;

public interface ICiudadDAO extends IDAO {

	boolean ciudadExistente(CiudadModelo ciudadModelo);
	
	void borrar(long id);

}