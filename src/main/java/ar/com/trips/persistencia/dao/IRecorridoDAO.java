package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Modelo;
import ar.com.trips.persistencia.modelo.Recorrido;

public interface IRecorridoDAO extends IDAO {

	List<Recorrido> listarPorCiudad(int idCiudad);
	
	Recorrido get(Long id);

	void borrar(long id);

	boolean recorridoExistente(Recorrido recorrido);
	
	List<Atraccion> listarAtraccionesEnElRecorridoNuevo();

	/*List<Atraccion> listarAtraccionesFueraDelRecorrido(long id);

	List<Atraccion> listarAtraccionesFueraDelRecorridoNuevo(int idCiudad);
*/
}