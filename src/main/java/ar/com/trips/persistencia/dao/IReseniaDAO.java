package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.Resenia;

public interface IReseniaDAO extends IDAO {

	List<Resenia> listarPorAtraccion(int idAtraccion);
	
	Resenia get(Long id);

	void borrar(long id);
}