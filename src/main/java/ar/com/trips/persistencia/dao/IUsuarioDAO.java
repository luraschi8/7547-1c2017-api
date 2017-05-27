package ar.com.trips.persistencia.dao;

import java.util.List;

import ar.com.trips.persistencia.modelo.Usuario;

public interface IUsuarioDAO extends IDAO {

	Usuario getByIds(String idAndroid, String idRedSocial);

	int getCantidadUsuariosRedSocial(String fechaInicio, String fechaFin, String pais);

	int getCantidadUsuariosSinLogin(String fechaInicio, String fechaFin, String pais);

	List<Usuario> getUsuariosParaRangoFechas(String fechaInicio, String fechaFin);

}