package ar.com.trips.presentacion.rest;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.xml.bind.DatatypeConverter;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IAtraccionDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.Ciudad;
import ar.com.trips.persistencia.modelo.ImagenAtraccion;
import ar.com.trips.presentacion.dto.AtraccionDTO;
import ar.com.trips.presentacion.validacion.AtraccionValidacion;
import ar.com.trips.presentacion.validacion.CiudadValidacion;

@RestController
public class AtraccionControladorRest {
	
	public static final String DATA = "data";
	public static final String EXISTE = "existe";
	
	@Autowired
	private IAtraccionDAO atraccionDao;
	
	@Autowired
	AtraccionValidacion atraccionValidacion;
	
	@RequestMapping("/atraccionesJson")
	public HashMap<String, List> listar() {
		HashMap<String, List> lista = new HashMap<String, List>();
		lista.put(DATA, atraccionDao.listar(Atraccion.class));
		return lista;
	}

	
	@RequestMapping(path="/atraccionesCiudadJson/{idCiudad}",method=RequestMethod.GET)
	public HashMap<String, List> listarAtraccionesCiudad(@PathVariable int idCiudad) {
		HashMap<String, List> lista = new HashMap<String, List>();
		List<Atraccion> list = atraccionDao.listarPorCiudad(idCiudad);
		for (Atraccion a : list) {
			if (a.getListaImagenes().size() > 0) {
				a.setImagen(a.getListaImagenes().get(0).getImagen());
			}
		}
		lista.put(DATA, list);
		return lista;
	}
	
	@RequestMapping(path="/atraccion/{idAtraccion}",method=RequestMethod.GET)
	public HashMap<String, AtraccionDTO> getAtraccion(@PathVariable int idAtraccion) {
		HashMap<String, AtraccionDTO> lista = new HashMap<String, AtraccionDTO>();
		Atraccion a = atraccionDao.get(Atraccion.class,idAtraccion);
		AtraccionDTO dto = new AtraccionDTO();
		dto.setNombre(a.getNombre());
		dto.setHorario(a.getHorario());
		dto.setDescripcion(a.getDescripcion());
		dto.setPrecio(a.getPrecio());
		dto.setLatitud(a.getLatitud());
		dto.setLongitud(a.getLongitud());
		dto.setRecorrible(a.getRecorrible());
		dto.setAudioEN(pathToString(a.getAudioEN()));
		dto.setAudioES(pathToString(a.getAudioES()));
		//dto.setVideo(pathToString(a.getVideo()));
		if (a.getPlano() != null) {
			dto.setPlano(DatatypeConverter.printBase64Binary(a.getPlano()));
		}
		List<String> imagenes = new ArrayList<>();
		for (ImagenAtraccion i : a.getListaImagenes()) {
			imagenes.add(DatatypeConverter.printBase64Binary(i.getImagen()));
		}
		dto.setListaImagenes(imagenes);
		lista.put(DATA, dto);
		return lista;
	}
	
	private String pathToString(String path) {
		if (path == null) {
			return null;
		}
		File f = new File(path);
		FileInputStream fis;
		try {
			fis = new FileInputStream(f);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return null;
		}
		try {
			return DatatypeConverter.printBase64Binary(IOUtils.toByteArray(fis));
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping(path="/validarAtraccion",method=RequestMethod.POST)
	public HashMap<String, Boolean> validarAtraccion(@RequestBody Atraccion atraccion) {
		HashMap<String, Boolean> lista = new HashMap<String, Boolean>();
		List<String> listaErrores = atraccionValidacion.validar(atraccion);
		if (listaErrores.size() != 0) {
			lista.put(EXISTE, true);
		} else {
			lista.put(EXISTE, false);
		}
		return lista;
	}
}
