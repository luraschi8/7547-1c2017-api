package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.AtraccionIdioma;

public interface IAtraccionIdiomaDAO extends IDAO {

	List listarPorCiudad(int idCiudad);
	
	AtraccionIdioma get(Long id);

	void borrar(long id);

	boolean atraccionExistente(AtraccionIdioma atraccion);

	AtraccionIdioma get(long idAtraccion, String idioma);
}
