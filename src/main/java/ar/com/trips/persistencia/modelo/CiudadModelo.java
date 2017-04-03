package ar.com.trips.persistencia.modelo;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="Ciudad")
public class CiudadModelo extends Modelo {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
	
	@Column(name="nombre")
	private String nombre;
	
	@Column(name="pais")
	private String pais;
	
	@Column(name="latitud")
	private float latitud;
	
	@Column(name="longitud")
	private float longitud;
	
	@Column(name="imagen")
	@Lob
	@Type(type="org.hibernate.type.TextType")
	private byte[] imagen;
	
	@Column(name="borrado")
	private int borrado;
	
	@OneToMany(mappedBy="ciudad",fetch=FetchType.EAGER)
	@JsonBackReference
	private List<AtraccionModelo> listaAtracciones = new ArrayList<>();	
	
	@Transient
	private int cantAtracciones;
	
	public CiudadModelo() {
		
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

	public String getPais() {
		return pais;
	}

	public void setPais(String pais) {
		this.pais = pais;
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

	public List<AtraccionModelo> getListaAtracciones() {
		return listaAtracciones;
	}

	public void setListaAtracciones(List<AtraccionModelo> listaAtracciones) {
		this.listaAtracciones = listaAtracciones;
	}

	public int getCantAtracciones() {
		return cantAtracciones;
	}

	public void setCantAtracciones(int cantAtracciones) {
		this.cantAtracciones = cantAtracciones;
	}

	public byte[] getImagen() {
		return imagen;
	}

	public void setImagen(byte[] imagen) {
		this.imagen = imagen;
	}

	public int getBorrado() {
		return borrado;
	}

	public void setBorrado(int borrado) {
		this.borrado = borrado;
	}

}
