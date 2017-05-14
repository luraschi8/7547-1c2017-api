package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.RecorridoIdioma;

public interface IRecorridoIdiomaDAO extends IDAO {

	List<RecorridoIdioma> listarPorCiudad(int idCiudad, String idioma);
	
	RecorridoIdioma get(Long id);
	
	RecorridoIdioma get(Long idRecorrido, String idioma);

	void borrar(long id);

	/*List<Atraccion> listarAtraccionesFueraDelRecorrido(long id);

	List<Atraccion> listarAtraccionesFueraDelRecorridoNuevo(int idCiudad);

	List<Atraccion> listarAtraccionesEnElRecorridoNuevo();*/
}