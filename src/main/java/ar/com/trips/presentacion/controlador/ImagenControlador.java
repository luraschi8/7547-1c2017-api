package ar.com.trips.presentacion.controlador;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

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
	
	@RequestMapping(value = "/videoAtraccion", method = RequestMethod.GET)
	@ResponseBody public void getPreview2(@RequestParam("id") Long id, HttpServletResponse response) {
	    try {
	        String path = atraccionDao.get(Atraccion.class, id).getVideo();
	        File file = new File(path);
	        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
	        response.setHeader("Content-Disposition", "attachment; filename="+file.getName());
	        InputStream iStream = new FileInputStream(file);
	        IOUtils.copy(iStream, response.getOutputStream());
	        response.flushBuffer();
	    } catch (java.nio.file.NoSuchFileException e) {
	        response.setStatus(HttpStatus.NOT_FOUND.value());
	    } catch (Exception e) {
	        response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
	    }
	}
	
}
