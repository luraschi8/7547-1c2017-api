package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
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
	
	@Override
	public Resenia getResenia(int id) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Resenia.class.getName() + " a WHERE a.id = " + id;
		Resenia resenia = (Resenia) session.createQuery(query).list().get(0);
		session.close();
		return resenia;
	}
	
	@Override
	public void guardar(int id, String comentario) {
		Resenia resenia = getResenia(id);
		Session s = sessionFactory.openSession();
		Transaction tx = s.beginTransaction();
		resenia.setComentario(comentario);
		s.update(resenia);
		tx.commit();
		s.close();
	}

	@Override
	public List<Resenia> listarPorAtraccionPaginada(int idAtraccion, int pagina) {
		Session session = sessionFactory.openSession();
		String queryString = "FROM " + Resenia.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion + " AND a.borrado = 0 "
				+ " ORDER BY a.fecha DESC, a.hora DESC";
		Query query = session.createQuery(queryString);
		query.setFirstResult(pagina * 10);
		query.setMaxResults(10);
		@SuppressWarnings("unchecked")
		List<Resenia> lista = query.list();
		session.close();
		return lista;
	}

	@Override
	public boolean puedeComentar(Resenia resenia) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Resenia.class.getName() + " a WHERE a.atraccion.id = " + resenia.getAtraccion().getId() 
				+ " AND a.usuario.idRedSocial = '" + resenia.getIdRedSocial() + "' AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<Resenia> lista = session.createQuery(query).list();
		session.close();
		if (lista.size() > 0) {
			return false;
		}
		return true;
	}
}