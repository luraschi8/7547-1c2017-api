package ar.com.trips.presentacion.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller

public class LoginControlador {
	
	@RequestMapping("/")
	public String inicio() {
		return "inicio";
	}
}
