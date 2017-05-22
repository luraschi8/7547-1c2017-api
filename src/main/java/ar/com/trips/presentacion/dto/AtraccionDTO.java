package ar.com.trips.presentacion.dto;

import java.util.LinkedHashSet;
import java.util.Set;

import ar.com.trips.util.enums.Idioma;

public class AtraccionDTO {

	private long id;
	
	private long idAtraccion;
	
	private String nombre;
	
	private String horario;
	
	private String descripcion;
	
	private String precio;
	
	private float latitud;
	
	private float longitud;
	
	private int borrado;
	
	private String plano;
	
	private String audioEN;
	
	private String audioES;
	
	private String video;
	
	private int recorrible;
		
	private Set<String> listaImagenes = new LinkedHashSet<>();
	
	private String imagen;
	
	private Idioma idioma;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getIdAtraccion() {
		return idAtraccion;
	}

	public void setIdAtraccion(long idAtraccion) {
		this.idAtraccion = idAtraccion;
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

	public String getPlano() {
		return plano;
	}

	public void setPlano(String plano) {
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

	public Set<String> getListaImagenes() {
		return listaImagenes;
	}

	public void setListaImagenes(Set<String> listaImagenes) {
		this.listaImagenes = listaImagenes;
	}

	public Idioma getIdioma() {
		return idioma;
	}

	public void setIdioma(Idioma idioma) {
		this.idioma = idioma;
	}

	public String getImagen() {
		return imagen;
	}

	public void setImagen(String imagen) {
		this.imagen = imagen;
	}
	
}