package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.IImagenAtraccionDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.ImagenAtraccion;

public class ImagenAtraccionDAOImpl extends DAOImpl implements IImagenAtraccionDAO {

	public List listarPorAtraccion(int idAtraccion) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + ImagenAtraccion.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion;
		@SuppressWarnings("unchecked")
		List<ImagenAtraccion> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Override
	public ImagenAtraccion getImagenPrincipal(Integer idAtraccion) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + ImagenAtraccion.class.getName() + " a WHERE a.atraccion.id = " + idAtraccion;
		@SuppressWarnings("unchecked")
		List<ImagenAtraccion> lista = session.createQuery(query).list();
		session.close();
		return lista.get(0);
	}

	@Override
	public ImagenAtraccion get(Long id) {
		return get(ImagenAtraccion.class,id);
	}

}
