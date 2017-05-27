package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;

import ar.com.trips.persistencia.dao.IUsuarioDAO;
import ar.com.trips.persistencia.modelo.Usuario;

public class UsuarioDAOImpl extends DAOImpl implements IUsuarioDAO {

	@Override
	public Usuario getByIds(String idAndroid, String idRedSocial) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Usuario.class.getName() + " a WHERE a.idAndroid = '" + idAndroid + "'";
		if (idRedSocial != null) {
			query += " AND a.idRedSocial = '" + idRedSocial + "'";
		}
		@SuppressWarnings("unchecked")
		List<Usuario> lista = session.createQuery(query).list();
		session.close();
		if (lista == null || lista.size() == 0) {
			return null;
		}
		return lista.get(0);
	}
	
	@Override
	public int getCantidadUsuariosRedSocial(String fechaInicio, String fechaFin, String pais) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Usuario.class.getName() + " a WHERE a.pais = '" + pais +
				"' AND a.ultimaFechaConexion > '" + fechaInicio + "' AND a.ultimaFechaConexion < '" + fechaFin +
				"' AND a.idRedSocial is not null";
		@SuppressWarnings("unchecked")
		List<Usuario> lista = session.createQuery(query).list();
		session.close();
		if (lista == null || lista.size() == 0) {
			return 0;
		}
		return lista.size();
	}

	@Override
	public int getCantidadUsuariosSinLogin(String fechaInicio, String fechaFin, String pais) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Usuario.class.getName() + " a WHERE a.pais = '" + pais +
				"' AND a.ultimaFechaConexion > '" + fechaInicio + "' AND a.ultimaFechaConexion < '" + fechaFin +
				"' AND a.idRedSocial is null";
		@SuppressWarnings("unchecked")
		List<Usuario> lista = session.createQuery(query).list();
		session.close();
		if (lista == null || lista.size() == 0) {
			return 0;
		}
		return lista.size();
	}
}