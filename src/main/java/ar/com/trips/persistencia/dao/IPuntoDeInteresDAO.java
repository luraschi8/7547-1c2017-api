package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;

public interface IPuntoDeInteresDAO extends IDAO {

	List<PuntoDeInteres> listarPorAtraccion(int idAtraccion);
	
	PuntoDeInteres get(Long id);

	void borrar(long id);

	boolean puntoDeInteresExistente(PuntoDeInteres puntoDeInteres);

	List<PuntoDeInteres> listarPorAtraccionNuevo(int idAtraccion);

	void guardarPuntosConAtraccionNula(Atraccion atraccion);

	void borrarPuntosSinAtraccion();

	void cambiarOrdenes(String ordenPuntos);

	void borrarPuntosDeAtraccion(Atraccion atraccion);
}