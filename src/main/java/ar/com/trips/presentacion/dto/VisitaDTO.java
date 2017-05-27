package ar.com.trips.presentacion.dto;

public class VisitaDTO implements Comparable<VisitaDTO> {

	private String nombre;
	
	private Integer cantVisitas;

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public Integer getCantVisitas() {
		return cantVisitas;
	}

	public void setCantVisitas(Integer cantVisitas) {
		this.cantVisitas = cantVisitas;
	}

	@Override
	public int compareTo(VisitaDTO o) {
		if (this.cantVisitas < o.getCantVisitas()) {
			return 1;
		} else if (this.cantVisitas > o.getCantVisitas()) {
			return -1;
		}
		return 0;
	}
	
}
