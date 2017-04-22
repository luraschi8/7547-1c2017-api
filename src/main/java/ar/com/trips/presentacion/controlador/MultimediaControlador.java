package ar.com.trips.presentacion.controlador;

import java.io.ByteArrayInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.dao.ICiudadDAO;
import ar.com.trips.persistencia.dao.IImagenAtraccionDAO;
import ar.com.trips.persistencia.dao.IPuntoDeInteresDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Ciudad;
import ar.com.trips.persistencia.modelo.ImagenAtraccion;
import ar.com.trips.persistencia.modelo.PuntoDeInteres;

@Controller
public class MultimediaControlador {

	@Autowired
	private ICiudadDAO ciudadDao;
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@Autowired
	private IPuntoDeInteresDAO puntoDao;
	
	@Autowired
	private IImagenAtraccionDAO imagenAtraccionDao;
	
	@RequestMapping(path="/imagenCiudad", method=RequestMethod.GET)
	public void imagenCiudad(@RequestParam("id") Long id, HttpServletResponse response,HttpServletRequest request) 
	          throws ServletException, IOException {
		Ciudad ciudad = ciudadDao.get(id);        
	    response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    response.getOutputStream().write(ciudad.getImagen());
	    response.getOutputStream().close();
	}
	
	@RequestMapping(path="/planoAtraccion", method=RequestMethod.GET)
	public void planoAtraccion(@RequestParam("id") Long id, HttpServletResponse response,HttpServletRequest request) 
	          throws ServletException, IOException {        
	    response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    response.getOutputStream().write(atraccionDao.get(id).getPlano());
	    response.getOutputStream().close();
	}
	
	@RequestMapping(path="/imagenAtraccion", method=RequestMethod.GET)
	public void imagenAtraccion(@RequestParam("id") Long id, HttpServletResponse response,HttpServletRequest request) 
	          throws ServletException, IOException {
		ImagenAtraccion imagenAtraccion = imagenAtraccionDao.get(id);
		response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
		response.getOutputStream().write(imagenAtraccion.getImagen());
	    response.getOutputStream().close();
	}
	
	@RequestMapping(path="/imagenPunto", method=RequestMethod.GET)
	public void imagenPunto(@RequestParam("id") Long id, HttpServletResponse response,HttpServletRequest request) 
	          throws ServletException, IOException {
		PuntoDeInteres punto = puntoDao.get(id);        
	    response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    response.getOutputStream().write(punto.getImagen());
	    response.getOutputStream().close();
	}
	
	@RequestMapping(path="/imagenPrincipalAtraccion", method=RequestMethod.GET)
	public void imagenPrincipalAtraccion(@RequestParam("id") Integer id, HttpServletResponse response,HttpServletRequest request) 
	          throws ServletException, IOException {
		ImagenAtraccion imagenAtraccion = imagenAtraccionDao.getImagenPrincipal(id);        
	    response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
	    response.getOutputStream().write(imagenAtraccion.getImagen());
	    response.getOutputStream().close();
	}
	
	@RequestMapping(value = "/videoAtraccion", method = RequestMethod.GET)
	@ResponseBody public void getVideo(@RequestParam("id") Long id, HttpServletResponse response) {
	    try {
	        Atraccion atraccion = atraccionDao.get(id);
	        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
	        //response.setHeader("Content-Disposition", "attachment; filename="+file.getName());
	        ByteArrayInputStream iStream = new ByteArrayInputStream(atraccion.getVideo());
	        IOUtils.copy(iStream, response.getOutputStream());
	        response.flushBuffer();
	    } catch (java.nio.file.NoSuchFileException e) {
	        e.printStackTrace();
	    	response.setStatus(HttpStatus.NOT_FOUND.value());
	    } catch (Exception e) {
	    	e.printStackTrace();
	        response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
	    }
	}
	
	@RequestMapping(value = "/audioAtraccion", method = RequestMethod.GET)
	@ResponseBody public void getAudio(@RequestParam("id") Long id, HttpServletResponse response) {
	    try {
	        Atraccion atraccion = atraccionDao.get(id);
	        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
	        //response.setHeader("Content-Disposition", "attachment; filename="+file.getName());
	        ByteArrayInputStream iStream = new ByteArrayInputStream(atraccion.getAudioEN());
	        IOUtils.copy(iStream, response.getOutputStream());
	        response.flushBuffer();
	    } catch (java.nio.file.NoSuchFileException e) {
	        e.printStackTrace();
	    	response.setStatus(HttpStatus.NOT_FOUND.value());
	    } catch (Exception e) {
	    	e.printStackTrace();
	        response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
	    }
	}
	
	@RequestMapping(value = "/audioPunto", method = RequestMethod.GET)
	@ResponseBody public void getAudioPunto(@RequestParam("id") Long id, HttpServletResponse response) {
	    try {
	        PuntoDeInteres punto = puntoDao.get(id);
	        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
	        //response.setHeader("Content-Disposition", "attachment; filename="+file.getName());
	        ByteArrayInputStream iStream = new ByteArrayInputStream(punto.getAudioEN());
	        IOUtils.copy(iStream, response.getOutputStream());
	        response.flushBuffer();
	    } catch (java.nio.file.NoSuchFileException e) {
	        e.printStackTrace();
	    	response.setStatus(HttpStatus.NOT_FOUND.value());
	    } catch (Exception e) {
	    	e.printStackTrace();
	        response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
	    }
	}
	
}
