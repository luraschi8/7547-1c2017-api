package ar.com.trips.persistencia.modelo;

import java.util.LinkedHashSet;
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
import javax.persistence.Table;

@Entity
@Table(name="Usuario")
public class Usuario extends Modelo {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
	
	@Column(name="nombre")
	private String nombre;
	
	@Column(name="idAndroid")
	private String idAndroid;
	
	@Column(name="idRedSocial")
	private String idRedSocial;
	
	@Column(name="pais")
	private String pais;
	
	@Column(name="ultimaFechaConexion")
	private String ultimaFechaConexion;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "AtraccionesFavoritas", joinColumns = {
			@JoinColumn(name = "idUsuario", nullable = false, updatable = false) },
			inverseJoinColumns = { @JoinColumn(name = "idAtraccion", nullable = false, updatable = false) })
	private Set<Atraccion> listaAtraccionesFavoritas = new LinkedHashSet<>();
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "RecorridosFavoritos", joinColumns = {
			@JoinColumn(name = "idUsuario", nullable = false, updatable = false) },
			inverseJoinColumns = { @JoinColumn(name = "idRecorrido", nullable = false, updatable = false) })
	private Set<Recorrido> listaRecorridosFavoritos = new LinkedHashSet<>();
	
	public Usuario(){
		
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

	public String getPais() {
		return pais;
	}

	public void setPais(String pais) {
		this.pais = pais;
	}
	
	public String getUltimaFechaConexion() {
		return ultimaFechaConexion;
	}

	public void setUltimaFechaConexion(String ultimaFechaConexion) {
		this.ultimaFechaConexion = ultimaFechaConexion;
	}

	public Set<Atraccion> getListaAtraccionesFavoritas() {
		return listaAtraccionesFavoritas;
	}

	public void setListaAtraccionesFavoritas(Set<Atraccion> listaAtraccionesFavoritas) {
		this.listaAtraccionesFavoritas = listaAtraccionesFavoritas;
	}
	
	public void addAtraccion(Atraccion atraccion) {
		this.getListaAtraccionesFavoritas().add(atraccion);
	}

	public Set<Recorrido> getListaRecorridosFavoritos() {
		return listaRecorridosFavoritos;
	}

	public void setListaRecorridosFavoritos(Set<Recorrido> listaRecorridosFavoritos) {
		this.listaRecorridosFavoritos = listaRecorridosFavoritos;
	}

	public void addRecorrido(Recorrido recorrido) {
		this.getListaRecorridosFavoritos().add(recorrido);
	}
	
}
