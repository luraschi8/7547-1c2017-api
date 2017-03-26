package ar.com.trips.persistencia.modelo;

import java.sql.Time;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="Atraccion")
public class AtraccionModelo {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
	
	@Column(name="nombre")
	private String nombre;
	
	@Column(name="horarioVisitaComienzo")
	private Time horarioVisitaComienzo;
	
	@Column(name="horarioVisitaFin")
	private Time horarioVisitaFin;
	
	@Column(name="precio")
	private float precio;
	
	@Column(name="latitud")
	private float latitud;
	
	@Column(name="longitud")
	private float longitud;
	
	@Column(name="borrado")
	private boolean borrado;
	
	@ManyToOne(fetch=FetchType.EAGER,cascade=CascadeType.PERSIST)
	@JoinColumn(name="idCiudad")
	@JsonBackReference
	private CiudadModelo ciudad;

	public AtraccionModelo() {
		
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public Time getHorarioVisitaComienzo() {
		return horarioVisitaComienzo;
	}

	public void setHorarioVisitaComienzo(Time horarioVisitaComienzo) {
		this.horarioVisitaComienzo = horarioVisitaComienzo;
	}

	public Time getHorarioVisitaFin() {
		return horarioVisitaFin;
	}

	public void setHorarioVisitaFin(Time horarioVisitaFin) {
		this.horarioVisitaFin = horarioVisitaFin;
	}

	public float getPrecio() {
		return precio;
	}

	public void setPrecio(float precio) {
		this.precio = precio;
	}

	public float getLatitud() {
		return latitud;
	}

	public void setLatitud(float latitud) {
		this.latitud = latitud;
	}

	public float getLongitud() {
		return longitud;
	}

	public void setLongitud(float longitud) {
		this.longitud = longitud;
	}

	public CiudadModelo getCiudad() {
		return ciudad;
	}

	public void setCiudad(CiudadModelo ciudad) {
		this.ciudad = ciudad;
	}

	public boolean isBorrado() {
		return borrado;
	}

	public void setBorrado(boolean borrado) {
		this.borrado = borrado;
	}
	
}
