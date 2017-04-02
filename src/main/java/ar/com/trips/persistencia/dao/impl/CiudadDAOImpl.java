package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.modelo.CiudadModelo;

public class CiudadDAOImpl extends DAOImpl implements ICiudadDAO {

	@Autowired
	protected SessionFactory sessionFactoryAux;
	
	@Override
	public boolean ciudadExistente(CiudadModelo ciudadModelo) {
		Session session = sessionFactoryAux.openSession();
		String query = "FROM " + CiudadModelo.class.getName() + " c WHERE c.nombre = '" + ciudadModelo.getNombre() + "'"
						+ " AND c.pais = '" + ciudadModelo.getPais() + "'";
		@SuppressWarnings("unchecked")
		List<CiudadModelo> lista = session.createQuery(query).list();
		session.close();
		return lista.size() != 0;
	}
	
	@Override
	public List<CiudadModelo> listar() {
		Session session = sessionFactoryAux.openSession();
		@SuppressWarnings("unchecked")
		List<CiudadModelo> lista = (List<CiudadModelo>)session.createQuery("from "  + CiudadModelo.class.getName() + " where borrado = 0").list();
		session.close();
		return lista;
	}
	
	@Transactional
	public void borrar(long id) {
		Session s = sessionFactoryAux.openSession();
		s.beginTransaction();
		CiudadModelo model = s.get(CiudadModelo.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
	}

}
