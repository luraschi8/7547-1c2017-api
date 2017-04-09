package ar.com.trips.persistencia.modelo;

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
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="ImagenAtraccion")
public class ImagenAtraccion extends Modelo {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
	
	@Column(name="imagen")
	@Lob
	@Type(type="org.hibernate.type.ImageType")
	private byte[] imagen;
	
	@ManyToOne(fetch=FetchType.EAGER,cascade=CascadeType.PERSIST)
	@JoinColumn(name="idAtraccion")
	@JsonBackReference(value="atraccion")
	private Atraccion atraccion;
	
	public ImagenAtraccion() {
		
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
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
	
}
