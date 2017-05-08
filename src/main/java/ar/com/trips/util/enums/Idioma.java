package ar.com.trips.util.enums;

public enum Idioma {

	EN,
	ES;
	
	public static boolean contains(String leng) {
		Idioma[] idiomas = values();
		for (Idioma idioma : idiomas) {
			if (idioma.name().equals(leng)) {
				return true;
			}
		}
		return false;
	}
}
