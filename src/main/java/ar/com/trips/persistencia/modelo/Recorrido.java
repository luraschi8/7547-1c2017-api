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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="Recorrido")
public class Recorrido extends Modelo {

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
	
	@Column(name="idioma")
	private String idioma;
		
	@ManyToOne(fetch=FetchType.EAGER,cascade=CascadeType.PERSIST)
	@JoinColumn(name="idCiudad")
	@JsonBackReference(value="ciudad")
	private Ciudad ciudad;
	
	@OneToMany(mappedBy="ciudad",fetch=FetchType.EAGER)
	@JsonBackReference(value="listaAtraccionesEnElRecorrido")
	private List<Atraccion> listaAtraccionesEnElRecorrido = new ArrayList<>();
	
	@OneToMany(mappedBy="ciudad",fetch=FetchType.EAGER)
	@JsonBackReference(value="listaAtraccionesFueraDelRecorrido")
	private List<Atraccion> listaAtraccionesFueraDelRecorrido = new ArrayList<>();
	
	@Transient
	private int cantAtracciones;

	public Recorrido() {
		
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

	public int getBorrado() {
		return borrado;
	}

	public void setBorrado(int borrado) {
		this.borrado = borrado;
	}

	public Ciudad getCiudad() {
		return ciudad;
	}

	public void setCiudad(Ciudad ciudad) {
		this.ciudad = ciudad;
	}
	
	public List<Atraccion> getListaAtraccionesEnElRecorrido() {
		return listaAtraccionesEnElRecorrido;
	}

	public void setListaAtraccionesEnElRecorrido(List<Atraccion> listaAtraccionesEnElRecorrido) {
		this.listaAtraccionesEnElRecorrido = listaAtraccionesEnElRecorrido;
	}
	
	public List<Atraccion> getListaAtraccionesFueraDelRecorrido() {
		return listaAtraccionesFueraDelRecorrido;
	}

	public void setListaAtraccionesFueraDelRecorrido(List<Atraccion> listaAtraccionesFueraDelRecorrido) {
		this.listaAtraccionesFueraDelRecorrido = listaAtraccionesFueraDelRecorrido;
	}
	
	public int getCantAtracciones() {
		return cantAtracciones;
	}

	public void setCantAtracciones(int cantAtracciones) {
		this.cantAtracciones = cantAtracciones;
	}
	
	public String getIdioma() {
		return idioma;
	}

	public void setIdioma(String idioma) {
		this.idioma = idioma;
	}
	
	public void addAtractionToRoute(Atraccion atraccion) {
		this.listaAtraccionesEnElRecorrido.add(atraccion);
	}
}