package ar.com.trips.persistencia.modelo;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
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
	
	@Column(name="borrado")
	private int borrado;
	
	@ManyToOne(fetch=FetchType.EAGER,cascade=CascadeType.PERSIST)
	@JoinColumn(name="idCiudad")
	@JsonBackReference(value="ciudad")
	private Ciudad ciudad;
	
	@OneToMany(mappedBy="recorrido",fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@JsonBackReference(value="listaRecorridoIdioma")
	private List<RecorridoIdioma> listaRecorridoIdioma = new ArrayList<>();
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "RecorridoAtraccion", joinColumns = {
			@JoinColumn(name = "idRecorrido", nullable = false, updatable = false) },
			inverseJoinColumns = { @JoinColumn(name = "idAtraccion", nullable = false, updatable = false) })
	private Set<Atraccion> listaAtraccionesEnElRecorrido = new LinkedHashSet<>();
	
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
	
	public Set<Atraccion> getListaAtraccionesEnElRecorrido() {
		return listaAtraccionesEnElRecorrido;
	}

	public void setListaAtraccionesEnElRecorrido(Set<Atraccion> listaAtraccionesEnElRecorrido) {
		this.listaAtraccionesEnElRecorrido = listaAtraccionesEnElRecorrido;
	}

	public int getCantAtracciones() {
		return cantAtracciones;
	}

	public void setCantAtracciones(int cantAtracciones) {
		this.cantAtracciones = cantAtracciones;
	}
	
	public void addAtractionToRoute(Atraccion atraccion) {
		this.getListaAtraccionesEnElRecorrido().add(atraccion);
	}

	public List<RecorridoIdioma> getListaRecorridoIdioma() {
		return listaRecorridoIdioma;
	}

	public void setListaRecorridoIdioma(List<RecorridoIdioma> listaRecorridoIdioma) {
		this.listaRecorridoIdioma = listaRecorridoIdioma;
	}
	
	public void addRecorridoIdioma(RecorridoIdioma recorrido) {
		this.getListaRecorridoIdioma().add(recorrido);
	}
}