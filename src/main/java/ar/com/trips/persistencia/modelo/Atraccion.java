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
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="Atraccion")
public class Atraccion extends Modelo{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private long id;
		
	@Column(name="nombre")
	private String nombre;
	
	@Column(name="latitud")
	private float latitud;
	
	@Column(name="longitud")
	private float longitud;
	
	@Column(name="borrado")
	private int borrado;
	
	@Column(name="plano")
	@Lob
	@Type(type="org.hibernate.type.ImageType")
	@JsonBackReference(value="plano")
	private byte[] plano;
	
	@Column(name="video")
	@Lob
	@Type(type="org.hibernate.type.ImageType")
	@JsonBackReference(value="video")
	private byte[] video;
	
	@Column(name="recorrible")
	private int recorrible;
	
	@ManyToOne(fetch=FetchType.EAGER,cascade=CascadeType.PERSIST)
	@JoinColumn(name="idCiudad")
	@JsonBackReference(value="ciudad")
	private Ciudad ciudad;
	
	@OneToMany(mappedBy="atraccion",fetch=FetchType.EAGER)
	@JsonBackReference(value="listaImagenes")
	private List<ImagenAtraccion> listaImagenes = new ArrayList<>();
	
	@OneToMany(mappedBy="atraccion",fetch=FetchType.EAGER)
	@JsonBackReference(value="listaPuntosDeInteres")
	private List<PuntoDeInteres> listaPuntosDeInteres = new ArrayList<>();
	
	@OneToMany(mappedBy="atraccion",fetch=FetchType.EAGER)
	@JsonBackReference(value="listaResenias")
	private List<Resenia> listaResenias = new ArrayList<>();
	
	@OneToMany(mappedBy="atraccion",fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JsonBackReference(value="listaAtraccionIdioma")
	private List<AtraccionIdioma> listaAtraccionIdioma = new ArrayList<>();
	
	@ManyToMany(fetch = FetchType.EAGER, mappedBy = "listaAtraccionesEnElRecorrido")
	@JsonBackReference(value="listaRecorridos")
	private List<Recorrido> listaRecorridos;
	
	@ManyToMany(fetch = FetchType.EAGER, mappedBy = "listaAtraccionesFavoritas")
	@JsonBackReference(value="listaUsuarios")
	private List<Usuario> listaUsuarios;

	public Atraccion() {
		
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

	public int getBorrado() {
		return borrado;
	}

	public void setBorrado(int borrado) {
		this.borrado = borrado;
	}

	public byte[] getPlano() {
		return plano;
	}

	public void setPlano(byte[] plano) {
		this.plano = plano;
	}

	public byte[] getVideo() {
		return video;
	}

	public void setVideo(byte[] video) {
		this.video = video;
	}

	public int getRecorrible() {
		return recorrible;
	}

	public void setRecorrible(int recorrible) {
		this.recorrible = recorrible;
	}

	public Ciudad getCiudad() {
		return ciudad;
	}

	public void setCiudad(Ciudad ciudad) {
		this.ciudad = ciudad;
	}

	public List<ImagenAtraccion> getListaImagenes() {
		return listaImagenes;
	}

	public void setListaImagenes(List<ImagenAtraccion> listaImagenes) {
		this.listaImagenes = listaImagenes;
	}

	public List<PuntoDeInteres> getListaPuntosDeInteres() {
		return listaPuntosDeInteres;
	}

	public void setListaPuntosDeInteres(List<PuntoDeInteres> listaPuntosDeInteres) {
		this.listaPuntosDeInteres = listaPuntosDeInteres;
	}

	public List<Resenia> getListaResenias() {
		return listaResenias;
	}

	public void setListaResenias(List<Resenia> listaResenias) {
		this.listaResenias = listaResenias;
	}

	public List<AtraccionIdioma> getListaAtraccionIdioma() {
		return listaAtraccionIdioma;
	}

	public void setListaAtraccionIdioma(List<AtraccionIdioma> listaAtraccionIdioma) {
		this.listaAtraccionIdioma = listaAtraccionIdioma;
	}

	public void addAtraccionIdioma(AtraccionIdioma atraccion) {
		this.getListaAtraccionIdioma().add(atraccion);
	}
	
	public List<Recorrido> getListaRecorridos() {
		return listaRecorridos;
	}

	public void setListaRecorridos(List<Recorrido> listaRecorridos) {
		this.listaRecorridos = listaRecorridos;
	}

	public void addRecorrido(Recorrido recorrido) {
		this.getListaRecorridos().add(recorrido);
	}

	public void eraseRecorrido(Recorrido recorrido) {
		for (int i = 0; i < this.listaRecorridos.size(); i ++) {
			if (this.listaRecorridos.get(i).getId() == recorrido.getId()) {
				this.listaRecorridos.remove(i);
			}
		}
	}
	
	public List<Usuario> getListaUsuarios() {
		return listaUsuarios;
	}

	public void setListaUsuarios(List<Usuario> listaUsuarios) {
		this.listaUsuarios = listaUsuarios;
	}
	
	public void addUsuario(Usuario usuario) {
		this.getListaUsuarios().add(usuario);
	}
}