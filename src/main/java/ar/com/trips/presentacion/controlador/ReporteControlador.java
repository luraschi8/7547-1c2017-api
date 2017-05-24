package ar.com.trips.presentacion.controlador;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReporteControlador {
	@RequestMapping(path="/atraccionesDeMayorInteres")
	public ModelAndView getReporteAtraccionesDeMayorInteres() {
		ModelAndView model = new ModelAndView("reportes/atraccionesDeMayorInteres");
		return model;
	}
	
	@RequestMapping(path="/usuariosUnicosGlobales")
	public ModelAndView getReporteUsuariosUnicosGlobales() {
		ModelAndView model = new ModelAndView("reportes/usuariosUnicosGlobales");
		return model;
	}
	
	@RequestMapping(path="/usuariosUnicosPorPaisYRedSocial")
	public ModelAndView getReporteUsuariosUnicosPorPaisYRedSocial() {
		ModelAndView model = new ModelAndView("reportes/usuariosUnicosPorPaisYRedSocial");
		return model;
	}
}