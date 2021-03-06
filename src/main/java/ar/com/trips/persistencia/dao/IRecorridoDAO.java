package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Recorrido;

public interface IRecorridoDAO extends IDAO {

	List<Recorrido> listarPorCiudad(int idCiudad);
	
	Recorrido get(Long id);

	void borrar(long id);

	boolean recorridoExistente(Recorrido recorrido);
	
	List<Atraccion> listarAtraccionesEnElRecorridoNuevo();
	
	void guardarRecorrido(Recorrido recorrido);
	
	public List<Atraccion> listarAtracciones(int idCiudad);
}