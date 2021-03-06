package ar.com.trips.presentacion.dto;

public class RecorridoDTO {

	private long id;
	
	private long idRecorrido;
	
	private String nombre;
	
	private String descripcion;
	
	private int borrado;
	
	private String idioma;
	
	private String audio;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public long getIdRecorrido() {
		return idRecorrido;
	}

	public void setIdRecorrido(long idRecorrido) {
		this.idRecorrido = idRecorrido;
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
	
	public String getIdioma() {
		return idioma;
	}

	public void setIdioma(String idioma) {
		this.idioma = idioma;
	}

	public String getAudio() {
		return audio;
	}

	public void setAudio(String audio) {
		this.audio = audio;
	}
	
}