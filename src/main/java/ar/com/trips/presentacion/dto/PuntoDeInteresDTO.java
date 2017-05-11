package ar.com.trips.presentacion.dto;

public class PuntoDeInteresDTO {

	private long id;
	
	private String nombre;
	
	private String descripcion;
	
	private String audioEN;
	
	private String audioES;
	
	private String imagen;
	
	private String idioma;

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

	public String getImagen() {
		return imagen;
	}

	public void setImagen(String imagen) {
		this.imagen = imagen;
	}
	
	public String getIdioma() {
		return idioma;
	}

	public void setIdioma(String idioma) {
		this.idioma = idioma;
	}
}