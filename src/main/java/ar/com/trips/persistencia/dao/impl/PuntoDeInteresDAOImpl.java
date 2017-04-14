package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IPuntoDeInteresDAO;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;

public class PuntoDeInteresDAOImpl extends DAOImpl implements IPuntoDeInteresDAO {

	@Override
	public List<PuntoDeInteres> listarPorAtraccion(int idAtraccion) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion + " AND a.borrado = 0";
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
	public boolean puntoDeInteresExistente(PuntoDeInteres puntoDeInteres) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE a.nombre = '" + puntoDeInteres.getNombre() + "'"
						+ " AND a.atraccion.id = '" + puntoDeInteres.getAtraccion().getId() + "' AND a.borrado = 0"
						+ " AND a.id != '" + puntoDeInteres.getId() + "'";
		@SuppressWarnings("unchecked")
		List<PuntoDeInteres> lista = session.createQuery(query).list();
		session.close();
		return lista.size() != 0;
	}
}