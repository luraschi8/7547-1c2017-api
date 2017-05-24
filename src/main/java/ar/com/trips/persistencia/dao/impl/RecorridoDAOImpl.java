package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IRecorridoDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Recorrido;

public class RecorridoDAOImpl extends DAOImpl implements IRecorridoDAO {

	@Override
	public List<Recorrido> listarPorCiudad(int idCiudad) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Recorrido.class.getName() + " a WHERE a.ciudad.id = " + idCiudad + " AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<Recorrido> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Transactional
	public void borrar(long id) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		Recorrido model = (Recorrido) s.get(Recorrido.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
	}

	@Override
	public boolean recorridoExistente(Recorrido recorrido) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Recorrido.class.getName() + " a WHERE a.nombre = '" + recorrido.getNombre() + "'"
						+ " AND a.ciudad.id = '" + recorrido.getCiudad().getId() + "' AND a.borrado = 0"
						+ " AND a.id != '" + recorrido.getId() + "'";
		@SuppressWarnings("unchecked")
		List<Recorrido> lista = session.createQuery(query).list();
		session.close();
		return lista.size() != 0;
	}

	@Override
	public Recorrido get(Long id) {
		return this.get(Recorrido.class, id);
	}
	
	@Override
	public List<Atraccion> listarAtraccionesEnElRecorridoNuevo() {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Atraccion.class.getName() + " a WHERE a.ciudad.id = -1 AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<Atraccion> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}
	
	@Override
	public List<Atraccion> listarAtracciones(int idCiudad) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Atraccion.class.getName() + " a WHERE a.ciudad.id = " + idCiudad + " AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<Atraccion> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Override
	public void guardarRecorrido(Recorrido recorrido) {
		Session s = sessionFactory.openSession();
		Transaction tx = s.beginTransaction();
		s.merge(recorrido);
		tx.commit();
		s.close();
	}
}