package ar.com.trips.persistencia.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.springframework.transaction.annotation.Transactional;

import ar.com.trips.persistencia.dao.IRecorridoDAO;
import ar.com.trips.persistencia.dao.IRecorridoIdiomaDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Recorrido;
import ar.com.trips.persistencia.modelo.RecorridoIdioma;

public class RecorridoIdiomaDAOImpl extends DAOImpl implements IRecorridoIdiomaDAO {

	@Override
	public List<RecorridoIdioma> listarPorCiudad(int idCiudad, String idioma) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Recorrido.class.getName() + " a WHERE a.ciudad.id = " + idCiudad 
					+ " AND a.idioma = '" + idioma + "' AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<RecorridoIdioma> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}

	@Transactional
	public void borrar(long id) {
		Session s = sessionFactory.openSession();
		s.beginTransaction();
		RecorridoIdioma model = (RecorridoIdioma) s.get(RecorridoIdioma.class, id);
		model.setBorrado(1);
		s.update(model);
		s.getTransaction().commit();
		s.close();
	}

	@Override
	public RecorridoIdioma get(Long id) {
		return this.get(RecorridoIdioma.class, id);
	}
	
	/*@Override
	public List<Atraccion> listarAtraccionesFueraDelRecorridoNuevo(int idCiudad) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + Atraccion.class.getName() + " a WHERE a.ciudad.id = " + idCiudad + " AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<Atraccion> lista = session.createQuery(query).list();
		session.close();
		return lista;
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

	/*@Override
	public List<Atraccion> listarAtraccionesFueraDelRecorrido(long id) {
		Recorrido recorrido = this.get(id);
		System.out.print("\nId: " + id + "\n\n");
		System.out.print("\nRecorrido borrado: " + recorrido.getBorrado() + "\n\n");
		List<Atraccion> atracciones = recorrido.getListaAtraccionesFueraDelRecorrido();
		int last = atracciones.size() - 1;
		Session session = sessionFactory.openSession();
		String query = "FROM " + Atraccion.class.getName() + " a WHERE ";
		for (int i = 0; i < atracciones.size(); i++) {
			query += "a.id = '" + atracciones.get(i).getId() + "'";
			if (i != last) {
				query += " OR ";
			}
		}
		@SuppressWarnings("unchecked")
		List<Atraccion> lista = session.createQuery(query).list();
		session.close();
		return lista;
	}
*/
	@Override
	public RecorridoIdioma get(Long idRecorrido, String idioma) {
		Session session = sessionFactory.openSession();
		String query = "FROM " + RecorridoIdioma.class.getName() + " a WHERE a.recorrido.id = " + idRecorrido 
				+ " AND a.idioma = '" + idioma + "' AND a.borrado = 0";
		@SuppressWarnings("unchecked")
		List<RecorridoIdioma> lista = session.createQuery(query).list();
		session.close();
		if (lista.size() == 0) {
			return null;
		} else {
			return lista.get(0);
		}
	}
}