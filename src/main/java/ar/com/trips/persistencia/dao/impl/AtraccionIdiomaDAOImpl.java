package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IAtraccionIdiomaDAO;
import ar.com.trips.persistencia.modelo.AtraccionIdioma;

public class AtraccionIdiomaDAOImpl extends DAOImpl implements IAtraccionIdiomaDAO {

	@Override
	public List listarPorCiudad(int idCiudad,String idioma) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + AtraccionIdioma.class.getName() + " a WHERE a.atraccion.ciudad.id = " + idCiudad 
				+ " AND a.idioma = '" + idioma + "' AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<AtraccionIdioma> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Transactional
	public void borrar(long id) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		AtraccionIdioma model = (AtraccionIdioma) s.get(AtraccionIdioma.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
	}

	@Override
	public boolean atraccionExistente(AtraccionIdioma atraccionIdioma) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + AtraccionIdioma.class.getName() + " a WHERE a.nombre = '" + atraccionIdioma.getNombre() + "'"
						+ " AND a.atraccion.ciudad.id = '" + atraccionIdioma.getAtraccion().getCiudad().getId() + "' AND a.borrado = 0"
						+ " AND a.idioma = '" + atraccionIdioma.getIdioma() + "' AND a.id != '" + atraccionIdioma.getId() + "'";
		@SuppressWarnings("unchecked")
		List<AtraccionIdioma> lista = session.createQuery(query).list();
		session.close();
		return lista.size() != 0;
	}

	@Override
	public AtraccionIdioma get(Long id) {
		return this.get(AtraccionIdioma.class, id);
	}

	@Override
	public AtraccionIdioma get(long idAtraccion, String idioma) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + AtraccionIdioma.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion 
				+ " AND a.idioma = '" + idioma + "' AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<AtraccionIdioma> lista = session.createQuery(query).list();
		session.close();
		if (lista.size() == 0) {
			return null;
		} else {
			return lista.get(0);
		}
	}
	
}
