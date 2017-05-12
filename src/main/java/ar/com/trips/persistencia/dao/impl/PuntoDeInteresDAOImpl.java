package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IPuntoDeInteresDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;

public class PuntoDeInteresDAOImpl extends DAOImpl implements IPuntoDeInteresDAO {

	@Override
	public List<PuntoDeInteres> listarPorAtraccion(int idAtraccion) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion + " AND a.borrado = 0 ";
		@SuppressWarnings("unchecked")
		List<PuntoDeInteres> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Override
	public List<PuntoDeInteres> listarPorAtraccionNuevo(Integer idAtraccion) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE (a.atraccion.id = " + idAtraccion + 
				" OR a.atraccion.id is null) AND a.borrado = 0 ";
		@SuppressWarnings("unchecked")
		List<PuntoDeInteres> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Override
	public PuntoDeInteres get(Long id) {
		return this.get(PuntoDeInteres.class, id);
	}
	
	@Transactional
	public void borrar(long id) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		PuntoDeInteres model = (PuntoDeInteres) s.get(PuntoDeInteres.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
	}

	@Override
	public void guardarPuntosConAtraccionNula(Atraccion atraccion,String idioma) {
		List<PuntoDeInteres> lista = listarPorAtraccionNuevo((int)atraccion.getId());
		Session s = sessionFactory.openSession();
		Transaction tx = s.beginTransaction();
		for (PuntoDeInteres puntoDeInteres : lista) {
			puntoDeInteres.setAtraccion(atraccion);
			s.update(puntoDeInteres);
		}
		tx.commit();
		s.close();
	}

	@Override
	public void borrarPuntosSinAtraccion() {
		List<PuntoDeInteres> lista = listarPorAtraccionNuevo(-1);
		Session s = sessionFactory.openSession();
		Transaction tx = s.beginTransaction();
		for (PuntoDeInteres puntoDeInteres : lista) {
			s.delete(puntoDeInteres);
		}
		tx.commit();
		s.close();
	}

	@Override
	public void borrarPuntosDeAtraccion(Atraccion atraccion) {
		List<PuntoDeInteres> lista = listarPorAtraccionNuevo((int)atraccion.getId());
		Session s = sessionFactory.openSession();
		Transaction tx = s.beginTransaction();
		for (PuntoDeInteres puntoDeInteres : lista) {
			s.delete(puntoDeInteres);
		}
		tx.commit();
		s.close();
	}

	@Override
	public boolean puntoExistente(PuntoDeInteres punto) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE a.nombre = '" + punto.getNombre() + "'"
				+ " AND (a.atraccion.id = '"+ punto.getAtraccion().getId() + "' OR a.atraccion.id is null) AND a.borrado = 0"
				+ " AND a.id != '" + punto.getId() + "'";
		@SuppressWarnings("unchecked")
		List<Atraccion> lista = session.createQuery(query).list();
		session.close();
		return lista.size() != 0;
	}
	
}