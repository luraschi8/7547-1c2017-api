package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.PuntoDeInteres;

public interface IPuntoDeInteresDAO extends IDAO {

	List<PuntoDeInteres> listarPorAtraccion(int idAtraccion);
	
	PuntoDeInteres get(Long id);

	void borrar(long id);

	boolean puntoDeInteresExistente(PuntoDeInteres puntoDeInteres);
}