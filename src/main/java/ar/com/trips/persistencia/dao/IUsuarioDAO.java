package ar.com.trips.persistencia.dao;

import ar.com.trips.persistencia.modelo.Usuario;

public interface IUsuarioDAO extends IDAO {

	Usuario getByIds(String idAndroid, String idRedSocial);

}
