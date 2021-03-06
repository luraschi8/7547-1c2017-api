package ar.com.trips.persistencia.modelo;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="PuntoDeInteres")
public class PuntoDeInteres extends Modelo {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
	
	@Column(name="nombre")
	private String nombre;
	
	@Column(name="borrado")
	private int borrado;
	
	@Column(name="imagen")
	@Lob
	@Type(type="org.hibernate.type.ImageType")
	@JsonBackReference(value="imagen")
	private byte[] imagen;
	
	@ManyToOne(fetch=FetchType.EAGER, cascade=CascadeType.PERSIST)
	@JoinColumn(name="idAtraccion")
	@JsonBackReference(value="atraccion")
	private Atraccion atraccion;
	
	@OneToMany(mappedBy="puntoDeInteres",fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@JsonBackReference(value="listaPuntoIdioma")
	private List<PuntoIdioma> listaPuntoIdioma = new ArrayList<>();

	public PuntoDeInteres() {
		
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

	public int getBorrado() {
		return borrado;
	}

	public void setBorrado(int borrado) {
		this.borrado = borrado;
	}

	public byte[] getImagen() {
		return imagen;
	}

	public void setImagen(byte[] imagen) {
		this.imagen = imagen;
	}

	public Atraccion getAtraccion() {
		return atraccion;
	}

	public void setAtraccion(Atraccion atraccion) {
		this.atraccion = atraccion;
	}

	public List<PuntoIdioma> getListaPuntoIdioma() {
		return listaPuntoIdioma;
	}

	public void setListaPuntoIdioma(List<PuntoIdioma> listaPuntoIdioma) {
		this.listaPuntoIdioma = listaPuntoIdioma;
	}
	
	public void add(PuntoIdioma puntoIdioma) {
		getListaPuntoIdioma().add(puntoIdioma);
	}
}