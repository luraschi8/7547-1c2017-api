package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;

public interface IPuntoDeInteresDAO extends IDAO {

	List<PuntoDeInteres> listarPorAtraccion(int idAtraccion);
	
	PuntoDeInteres get(Long id);
	
	void borrar(long id, Integer idAtraccion);

	List<PuntoDeInteres> listarPorAtraccionNuevo(Integer idAtraccion);

	void guardarPuntosConAtraccionNula(Atraccion atraccion, String idioma);

	void borrarPuntosSinAtraccion();

	void cambiarOrdenes(String ordenPuntos);

	void borrarPuntosDeAtraccion(Atraccion atraccion);

	boolean puntoExistente(PuntoDeInteres punto);

	void rollbackPuntosBorrados(String puntosBorrados);
}