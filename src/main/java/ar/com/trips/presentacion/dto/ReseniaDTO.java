package ar.com.trips.presentacion.dto;

public class ReseniaDTO {

	private long id;
	
	private String nombre_usuario;
	
	private String fecha;
	
	private String hora;
	
	private String comentario;
	
	private float calificacion;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNombreUsuario() {
		return nombre_usuario;
	}

	public void setNombreUsuario(String nombre) {
		this.nombre_usuario = nombre;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	public float getCalificacion() {
		return calificacion;
	}

	public void setCalificacion(float calificacion) {
		this.calificacion = calificacion;
	}
}