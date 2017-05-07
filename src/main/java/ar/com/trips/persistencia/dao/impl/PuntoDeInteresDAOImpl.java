package ar.com.trips.persistencia.dao.impl;

import java.util.ArrayList;
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
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion + " AND a.borrado = 0 "
				+ "ORDER BY a.orden ASC";
		@SuppressWarnings("unchecked")
		List<PuntoDeInteres> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Override
	public List<PuntoDeInteres> listarPorAtraccionNuevo(Integer idAtraccion) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE (a.atraccion.id = " + idAtraccion + 
				" OR a.atraccion.id is null) AND a.borrado = 0 "
				+ "ORDER BY a.orden ASC";
		@SuppressWarnings("unchecked")
		List<PuntoDeInteres> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Override
	public PuntoDeInteres get(Long id) {
		return this.get(PuntoDeInteres.class, id);
	}
	
	@Override
	public PuntoDeInteres get(int id) {
		return this.get(PuntoDeInteres.class, id);
	}

	@Transactional
	public void borrar(long id,Integer idAtraccion) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		PuntoDeInteres model = (PuntoDeInteres) s.get(PuntoDeInteres.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
		this.actualizarOrdenes(idAtraccion);
	}

	@Override
	public void guardarPuntosConAtraccionNula(Atraccion atraccion) {
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
	public void cambiarOrdenes(String ordenPuntos) {
		Session s = sessionFactory.openSession();
		Transaction tx = s.beginTransaction();
		String[] idOrdenes = ordenPuntos.split(";");
		for (String idOrdenJuntos : idOrdenes) {
			String[] idOrden = idOrdenJuntos.split(",");
			int id = Integer.parseInt(idOrden[0]);
			int orden = Integer.parseInt(idOrden[1]);
			PuntoDeInteres punto = get(new Long(id));
			punto.setOrden(orden);
			s.update(punto);
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
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE (a.atraccion.id = '"
				+ punto.getAtraccion().getId() + "' OR a.atraccion.id is null) AND a.borrado = 0"
				+ " AND a.id != '" + punto.getId() + "'";
		@SuppressWarnings("unchecked")
		List<Atraccion> lista = session.createQuery(query).list();
		session.close();
		return lista.size() != 0;
	}
	
	private void actualizarOrdenes(Integer idAtraccion) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		List<PuntoDeInteres> lista = listarPorAtraccionNuevo(idAtraccion);
		int orden = 1;
		for (PuntoDeInteres puntoDeInteres : lista) {
			if (puntoDeInteres.getOrden() != orden) {
				puntoDeInteres.setOrden(orden);
				s.update(puntoDeInteres);
			}
			orden++;
		}
		s.getTransaction().commit();
		s.close();
	}

	@Override
	public void rollbackPuntosBorrados(String ordenOriginal) {
		String[] ids = ordenOriginal.split(";");
		List<PuntoDeInteres> lista = new ArrayList<>();
		int orden = 1;
		for (String id : ids) {
			PuntoDeInteres punto = get(Long.parseLong(id));
			punto.setBorrado(0);
			punto.setOrden(orden);
			lista.add(punto);
			orden++;
		}
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		for (PuntoDeInteres puntoDeInteres : lista) {
			s.update(puntoDeInteres);
		}
		s.getTransaction().commit();
		s.close();
	}
}