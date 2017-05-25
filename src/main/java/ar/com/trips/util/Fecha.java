package ar.com.trips.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Fecha {

	private static final String FECHA_HORA = "dd/MM/yyyy HH:mm";
	
	private static final String FECHA = "dd/MM/yyyy";
	
	public static String getFechaHora() {
		DateFormat dateFormat = new SimpleDateFormat(FECHA_HORA);
		Date date = new Date();
		return dateFormat.format(date);		
	}
	
	public static String getFecha() {
		DateFormat dateFormat = new SimpleDateFormat(FECHA);
		Date date = new Date();
		return dateFormat.format(date);
	}
	
}
