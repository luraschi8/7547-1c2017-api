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
@Table(name="AtraccionIdioma")
public class AtraccionIdioma extends Modelo{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
	
	@Column(name="nombre")
	private String nombre;
	
	@Column(name="horario")
	private String horario;
	
	@Column(name="descripcion")
	private String descripcion;
	
	@Column(name="precio")
	private String precio;
	
	@Column(name="borrado")
	private int borrado;
	
	@Column(name="audio")
	@Lob
	@Type(type="org.hibernate.type.ImageType")
	@JsonBackReference(value="audio")
	private byte[] audio;
	
	@ManyToOne(fetch=FetchType.EAGER,cascade=CascadeType.PERSIST)
	@JoinColumn(name="idAtraccion")
	@JsonBackReference(value="atraccion")
	private Atraccion atraccion;
	
	@Column(name="idioma")
	@Enumerated(EnumType.STRING)
	private Idioma idioma;
	
	public AtraccionIdioma() {
		
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

	public String getHorario() {
		return horario;
	}

	public void setHorario(String horario) {
		this.horario = horario;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getPrecio() {
		return precio;
	}

	public void setPrecio(String precio) {
		this.precio = precio;
	}

	public byte[] getAudio() {
		return audio;
	}

	public void setAudio(byte[] audio) {
		this.audio = audio;
	}

	public Atraccion getAtraccion() {
		return atraccion;
	}

	public void setAtraccion(Atraccion atraccion) {
		this.atraccion = atraccion;
	}

	public int getBorrado() {
		return borrado;
	}

	public void setBorrado(int borrado) {
		this.borrado = borrado;
	}

	public Idioma getIdioma() {
		return idioma;
	}

	public void setIdioma(Idioma idioma) {
		this.idioma = idioma;
	}
	
}