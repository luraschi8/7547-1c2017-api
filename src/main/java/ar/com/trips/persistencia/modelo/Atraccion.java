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
import javax.persistence.Transient;

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
	
	@Column(name="horario")
	private String horario;
	
	@Column(name="descripcion")
	private String descripcion;
	
	@Column(name="precio")
	private String precio;
	
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
	
	@Column(name="audioEN")
	@Lob
	@Type(type="org.hibernate.type.ImageType")
	@JsonBackReference(value="audioEN")
	private byte[] audioEN;
	
	@Column(name="audioES")
	@Lob
	@Type(type="org.hibernate.type.ImageType")
	@JsonBackReference(value="audioES")
	private byte[] audioES;
	
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
	
	@Transient
	private byte[] imagen;
	
	@Transient
	private List<byte[]> imagenes;
	
	@Transient
	private byte[] plan;
	
	@OneToMany(mappedBy="atraccion",fetch=FetchType.EAGER)
	@JsonBackReference(value="listaPuntosDeInteres")
	private List<PuntoDeInteres> listaPuntosDeInteres = new ArrayList<>();
	
	@Transient
	private int cantPuntosDeInteres;
	/*
	@OneToMany(mappedBy="atraccion",fetch=FetchType.EAGER)
	@JsonBackReference(value="listaResenias")
	private List<Resenia> listaResenias = new ArrayList<>();
	
	@Transient
	private int cantResenias;*/

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

	public byte[] getAudioEN() {
		return audioEN;
	}

	public void setAudioEN(byte[] audioEN) {
		this.audioEN = audioEN;
	}

	public byte[] getAudioES() {
		return audioES;
	}

	public void setAudioES(byte[] audioES) {
		this.audioES = audioES;
	}

	public byte[] getVideo() {
		return video;
	}

	public void setVideo(byte[] video) {
		this.video = video;
	}

	public List<byte[]> getImagenes() {
		return imagenes;
	}

	public void setImagenes(List<byte[]> imagenes) {
		this.imagenes = imagenes;
	}

	public byte[] getPlan() {
		return plan;
	}

	public void setPlan(byte[] plan) {
		this.plan = plan;
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

	public byte[] getImagen() {
		return imagen;
	}

	public void setImagen(byte[] imagen) {
		this.imagen = imagen;
	}
	
	/*public List<PuntoDeInteres> getListaPuntosDeInteres() {
		return listaPuntosDeInteres;
	}

	public void setListaPuntosDeInteres(List<PuntoDeInteres> listaPuntosDeInteres) {
		this.listaPuntosDeInteres = listaPuntosDeInteres;
	}
	
	public int getCantPuntosDeInteres() {
		return cantPuntosDeInteres;
	}

	public void setCantPuntosDeInteres(int cantPuntosDeInteres) {
		this.cantPuntosDeInteres = cantPuntosDeInteres;
	}
	
	public List<Resenia> getListaResenias() {
		return listaResenias;
	}

	public void setListaResenias(List<Resenia> listaResenias) {
		this.listaResenias = listaResenias;
	}
	
	public int getCantResenias() {
		return cantResenias;
	}

	public void setCantResenias(int cantResenias) {
		this.cantResenias = cantResenias;
	}*/
}