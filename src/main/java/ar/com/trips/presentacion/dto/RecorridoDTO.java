package ar.com.trips.presentacion.dto;

import java.util.ArrayList;
import java.util.List;

public class RecorridoDTO {

	private long id;
	
	private String nombre;
	
	private String descripcion;
	
	private int borrado;
	
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
}