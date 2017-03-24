package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;

import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.CiudadModelo;

public class CiudadDAOImpl extends DAOImpl implements ICiudadDAO {

	@Override
	public boolean ciudadExistente(CiudadModelo ciudadModelo) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + CiudadModelo.class.getName() + " c WHERE c.nombre = '" + ciudadModelo.getNombre() + "'"
						+ " AND c.pais = '" + ciudadModelo.getPais() + "'";
		@SuppressWarnings("unchecked")
		List<CiudadModelo> lista = session.createQuery(query).list();
		session.close();
		return lista.size() != 0;
	}

}
