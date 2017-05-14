package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.PuntoIdioma;

public interface IPuntoDeInteresIdiomaDAO extends IDAO {

	PuntoIdioma get(Long id, String idioma);
	
	void borrar(long id);

	List<PuntoIdioma> listarPorAtraccion(int idAtraccion, String idioma);

	List<PuntoIdioma> listarPorAtraccionNuevo(Integer idAtraccion, String idioma);

	PuntoIdioma get(Long id);

	void cambiarOrdenes(String ordenPuntos);
	
	void rollbackPuntosBorrados(String puntosBorrados);

}