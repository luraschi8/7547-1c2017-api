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
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion + " AND a.borrado = 0 "
				+ "ORDER BY a.orden ASC";
		@SuppressWarnings("unchecked")
		List<PuntoDeInteres> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}
	
	@Override
	public List<PuntoDeInteres> listarPorAtraccionNuevo(int idAtraccion) {
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

	@Override
	public void guardarPuntosConAtraccionNula(Atraccion atraccion) {
		List<PuntoDeInteres> lista = listarPorAtraccionNuevo((int)atraccion.getId());
		Session s = sessionFactory.openSession();
		Transaction tx = s.beginTransaction();
		int orden = 1;
		int ordenMasAlto = 0;
		int ordenMasBajo = 9999;
		for (PuntoDeInteres puntoDeInteres : lista) {
			puntoDeInteres.setAtraccion(atraccion);
			if (puntoDeInteres.getOrden() > ordenMasAlto) {
				ordenMasAlto = puntoDeInteres.getOrden();
			}
			if (puntoDeInteres.getOrden() < ordenMasBajo) {
				ordenMasBajo = puntoDeInteres.getOrden();
			}
		}
		if (ordenMasAlto > 0) {
			orden = ordenMasAlto + 1;
		}
		if (ordenMasBajo == 0) {
			for (PuntoDeInteres puntoDeInteres : lista) {
				if (puntoDeInteres.getOrden() == 0) {
					puntoDeInteres.setOrden(orden++);
					s.update(puntoDeInteres);
				}
			}
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
}