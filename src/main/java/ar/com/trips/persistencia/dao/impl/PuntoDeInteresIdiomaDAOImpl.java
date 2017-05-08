package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IPuntoDeInteresIdiomaDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;
import ar.com.trips.persistencia.modelo.PuntoIdioma;

public class PuntoDeInteresIdiomaDAOImpl extends DAOImpl implements IPuntoDeInteresIdiomaDAO {

	@Override
	public List<PuntoIdioma> listarPorAtraccion(int idAtraccion, String idioma) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoIdioma.class.getName() + " a WHERE a.puntoDeInteres.atraccion.id = " + idAtraccion 
				+ " AND a.idioma = '" + idioma + "' AND a.borrado = 0 ORDER BY a.puntoDeInteres.orden ASC";
		@SuppressWarnings("unchecked")
		List<PuntoIdioma> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Override
	public List<PuntoIdioma> listarPorAtraccionNuevo(Integer idAtraccion, String idioma) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoIdioma.class.getName() + " a WHERE (a.puntoDeInteres.atraccion.id = " + idAtraccion + 
				" OR a.puntoDeInteres.atraccion.id is null) AND a.idioma = '" + idioma + "' AND a.borrado = 0 "
				+ "ORDER BY a.puntoDeInteres.orden ASC";
		@SuppressWarnings("unchecked")
		List<PuntoIdioma> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Override
	public PuntoIdioma get(Long id) {
		return this.get(PuntoIdioma.class, id);
	}
	
	@Override
	public PuntoIdioma get(Long id, String idioma) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoIdioma.class.getName() + " a WHERE a.puntoDeInteres.id = " + id + 
				" AND a.idioma = '" + idioma + "' AND a.puntoDeInteres.borrado = 0 "
				+ "ORDER BY a.orden ASC";
		@SuppressWarnings("unchecked")
		List<PuntoIdioma> lista = session.createQuery(query).list();
		session.close();
		if (lista.size() == 0) {
			return null;
		} else {
			return lista.get(0);
		}
	}
	
	@Transactional
	public void borrar(long id,Integer idAtraccion) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		PuntoIdioma model = (PuntoIdioma) s.get(PuntoIdioma.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
	}
	
	@Override
	public boolean puntoExistente(PuntoIdioma punto) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + PuntoDeInteres.class.getName() + " a WHERE (a.atraccion.id = '"
				+ punto.getPuntoDeInteres().getAtraccion().getId() + "' OR a.atraccion.id is null) AND a.borrado = 0"
				+ " AND a.id != '" + punto.getId() + "' AND a.idioma = '" + punto.getIdioma() + "'";
		@SuppressWarnings("unchecked")
		List<Atraccion> lista = session.createQuery(query).list();
		session.close();
		return lista.size() != 0;
	}
	
}