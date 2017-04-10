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
import javax.persistence.JoinColumns;
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
	@JsonBackReference(value="audioEN")
	private String audioEN;
	
	@Column(name="audioES")
	@JsonBackReference(value="audioES")
	private String audioES;
	
	@Column(name="video")
	@JsonBackReference(value="video")
	private String video;
	
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

	public String getAudioEN() {
		return audioEN;
	}

	public void setAudioEN(String audioEN) {
		this.audioEN = audioEN;
	}

	public String getAudioES() {
		return audioES;
	}

	public void setAudioES(String audioES) {
		this.audioES = audioES;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
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

	public byte[] getImagen() {
		return imagen;
	}

	public void setImagen(byte[] imagen) {
		this.imagen = imagen;
	}
	
}
