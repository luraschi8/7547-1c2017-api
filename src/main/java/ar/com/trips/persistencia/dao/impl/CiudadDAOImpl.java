package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Override
	public List<CiudadModelo> listar() {
		Session session = sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<CiudadModelo> lista = (List<CiudadModelo>)session.createQuery("from CiudadModelo where borrado = 0").list();
		session.close();
		return lista;
	}
	
	@Transactional
	public void borrar(long id) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		CiudadModelo model = s.get(CiudadModelo.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
	}

}
