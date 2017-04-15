package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IReseniaDAO;
import ar.com.trips.persistencia.modelo.Resenia;

public class ReseniaDAOImpl extends DAOImpl implements IReseniaDAO {

	@Override
	public List<Resenia> listarPorAtraccion(int idAtraccion) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Resenia.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion + " AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<Resenia> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}
	
	@Override
	public Resenia get(Long id) {
		return this.get(Resenia.class, id);
	}

	@Transactional
	public void borrar(long id) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		Resenia model = (Resenia) s.get(Resenia.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
	}
}