package ar.com.trips.persistencia.dao;

import java.util.List;

public interface IAtraccionDAO extends IDAO {

	List listarPorCiudad(int idCiudad);

}
