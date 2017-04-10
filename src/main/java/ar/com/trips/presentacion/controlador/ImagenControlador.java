package ar.com.trips.presentacion.controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.dao.IImagenAtraccionDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Ciudad;
import ar.com.trips.persistencia.modelo.ImagenAtraccion;

@Controller
public class ImagenControlador {

	@Autowired
	private ICiudadDAO ciudadDao;
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@Autowired
	private IImagenAtraccionDAO imagenAtraccionDao;
	
	@RequestMapping(path="/imagenCiudad", method=RequestMethod.GET)
	public void imagenCiudad(@RequestParam("id") Integer id, HttpServletResponse response,HttpServletRequest request) 
	          throws ServletException, IOException {
		Ciudad ciudad = ciudadDao.get(Ciudad.class, id);        
	    response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    response.getOutputStream().write(ciudad.getImagen());
	    response.getOutputStream().close();
	}
	
	@RequestMapping(path="/imagenAtraccion", method=RequestMethod.GET)
	public void imagenAtraccion(@RequestParam("id") Integer id, HttpServletResponse response,HttpServletRequest request) 
	          throws ServletException, IOException {
		ImagenAtraccion imagenAtraccion = imagenAtraccionDao.get(ImagenAtraccion.class, id);        
	    response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    response.getOutputStream().write(imagenAtraccion.getImagen());
	    response.getOutputStream().close();
	}
}