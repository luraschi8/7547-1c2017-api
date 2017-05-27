package ar.com.trips.persistencia.dao;

import java.util.Set;

import ar.com.trips.persistencia.modelo.VisitaAtraccion;

public interface IVisitaAtraccionDAO extends IDAO {

	Set<VisitaAtraccion> getAll();

}
