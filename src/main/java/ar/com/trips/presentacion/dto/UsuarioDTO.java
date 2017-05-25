package ar.com.trips.presentacion.dto;

public class UsuarioDTO {

	/*
	 * Nombre y pais solo cuando se accede/loggea a la aplicacion
	 * 
	 */
	
	private String nombre;
	
	private String pais;

	private String idAndroid;
	
	private String idRedSocial;
	

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

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
}
