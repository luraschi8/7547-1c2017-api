package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.Atraccion;

public interface IAtraccionDAO extends IDAO {

	List<Atraccion> listarPorCiudad(int idCiudad);
	
	Atraccion get(Long id);

	void borrar(long id);

	boolean atraccionExistente(Atraccion atraccion);
}
