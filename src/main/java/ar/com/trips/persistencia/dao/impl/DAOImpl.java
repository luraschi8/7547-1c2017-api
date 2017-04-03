package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IDAO;
import ar.com.trips.persistencia.modelo.Modelo;

public class DAOImpl implements IDAO {

	@Autowired
	protected SessionFactory sessionFactory;
	
	@Transactional
	public <T> T get(Class<T> clazz, long id) {
		Session s = sessionFactory.openSession();
		T e = (T) s.get(clazz, id);
		s.close();
		return e;
	}

	public <T> List<T> listar(Class<T> clazz) {
		Session session = sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<T> lista = session.createQuery("from " + clazz.getName() + " where borrado is false").list();
		session.close();
		return lista;
	}

	@Transactional
	public void guardar(Modelo modelo) {
		Session s = sessionFactory.openSession();
		Transaction tx = s.beginTransaction();
		s.save(modelo);
		tx.commit();
		s.close();
	}

	@Transactional
	public void modificar(Modelo modelo) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		s.update(modelo);
		s.getTransaction().commit();
		s.close();
	}

}
