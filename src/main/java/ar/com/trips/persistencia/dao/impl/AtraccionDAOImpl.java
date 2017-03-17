package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.modelo.AtraccionModelo;

public class AtraccionDAOImpl extends DAOImpl implements IAtraccionDAO {

	@Override
	public List listarPorCiudad(int idCiudad) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + AtraccionModelo.class.getName() + " a WHERE a.ciudad.id = " + idCiudad;
		@SuppressWarnings("unchecked")
		List<AtraccionModelo> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

}
