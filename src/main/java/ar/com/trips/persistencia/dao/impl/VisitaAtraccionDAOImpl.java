package ar.com.trips.persistencia.dao.impl;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;

import ar.com.trips.persistencia.dao.IVisitaAtraccionDAO;
import ar.com.trips.persistencia.modelo.VisitaAtraccion;

public class VisitaAtraccionDAOImpl extends DAOImpl implements IVisitaAtraccionDAO {

	@Override
	public Set<VisitaAtraccion> getAll(String fechaInicio) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + VisitaAtraccion.class.getName() + " WHERE fecha >= '" + fechaInicio + "'";
		@SuppressWarnings("unchecked")
		List<VisitaAtraccion> lista = session.createQuery(query).list();
		session.close();
		return new LinkedHashSet<>(lista);
	}

}
