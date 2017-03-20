package ar.com.trips.presentacion.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginControlador {
	
	@RequestMapping("/")
	public String inicio() {
		return "redirect:/inicio";
	}
	
	@RequestMapping("/inicio")
	public ModelAndView login(@RequestParam(value = "error", required = false) String error) {
		ModelAndView model = new ModelAndView("inicio");
		if (error != null) {
			model.addObject("error","mensajeErrorLogin");
		}
		return model;
	}
}
