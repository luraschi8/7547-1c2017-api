package ar.com.trips.persistencia.modelo;

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
@Table(name="VisitaAtraccion")
public class VisitaAtraccion extends Modelo{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
		
	@Column(name="idAndroid")
	private String idAndroid;
	
	@Column(name="idRedSocial")
	private String idRedSocial;
	
	@Column(name="fecha")
	private String fecha;
	
	@ManyToOne(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@JoinColumn(name="idAtraccion")
	@JsonBackReference(value="atraccion")
	private Atraccion atraccion;
	
	public VisitaAtraccion() {
		
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getIdAndroid() {
		return idAndroid;
	}

	public void setIdAndroid(String idAndroid) {
		this.idAndroid = idAndroid;
	}

	public String getIdRedSocial() {
		return idRedSocial;
	}

	public void setIdRedSocial(String idRedSocial) {
		this.idRedSocial = idRedSocial;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public Atraccion getAtraccion() {
		return atraccion;
	}

	public void setAtraccion(Atraccion atraccion) {
		this.atraccion = atraccion;
	}
	
}