package ar.com.trips.persistencia.dao;

import ar.com.trips.persistencia.modelo.Usuario;

public interface IUsuarioDAO extends IDAO {

	Usuario getByIds(String idAndroid, String idRedSocial);

	int getCantidadUsuariosRedSocial(String fechaInicio, String fechaFin, String pais);

	int getCantidadUsuariosSinLogin(String fechaInicio, String fechaFin, String pais);
}