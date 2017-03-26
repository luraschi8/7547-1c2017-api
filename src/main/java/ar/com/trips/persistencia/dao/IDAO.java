package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.Modelo;

public interface IDAO {

	public <T> T get(Class<T> clazz, long id);
	
	public <T> List<T> listar(Class<T> clazz);
	
	public void guardar(Modelo modelo);
	
	public void modificar(Modelo modelo);
}
