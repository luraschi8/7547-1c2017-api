package ar.com.trips.persistencia.modelo;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonBackReference;

import ar.com.trips.util.enums.Idioma;

@Entity
@Table(name="PuntoIdioma")
public class PuntoIdioma extends Modelo {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
	
	@Column(name="nombre")
	private String nombre;
	
	@Column(name="descripcion")
	private String descripcion;
	
	@Column(name="borrado")
	private int borrado;
	
	@Column(name="audio")
	@Lob
	@Type(type="org.hibernate.type.ImageType")
	@JsonBackReference(value="audio")
	private byte[] audio;
	
	@ManyToOne(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@JoinColumn(name="idPunto")
	@JsonBackReference(value="puntoDeInteres")
	private PuntoDeInteres puntoDeInteres;
	
	@Column(name="idioma")
	@Enumerated(EnumType.STRING)
	private Idioma idioma;
			
	public PuntoIdioma() {
		
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

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public byte[] getAudio() {
		return audio;
	}

	public void setAudio(byte[] audio) {
		this.audio = audio;
	}

	public int getBorrado() {
		return borrado;
	}

	public void setBorrado(int borrado) {
		this.borrado = borrado;
	}

	public PuntoDeInteres getPuntoDeInteres() {
		return puntoDeInteres;
	}

	public void setPuntoDeInteres(PuntoDeInteres puntoDeInteres) {
		this.puntoDeInteres = puntoDeInteres;
	}

	public Idioma getIdioma() {
		return idioma;
	}

	public void setIdioma(Idioma idioma) {
		this.idioma = idioma;
	}

}