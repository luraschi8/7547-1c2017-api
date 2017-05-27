package ar.com.trips.presentacion.rest;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ar.com.trips.persistencia.dao.IVisitaAtraccionDAO;
import ar.com.trips.persistencia.modelo.Atraccion;
import ar.com.trips.persistencia.modelo.VisitaAtraccion;
import ar.com.trips.presentacion.dto.VisitaDTO;

@RestController
public class VisitaControladorRest {
	
	public static final String DATA = "data";
	
	@Autowired
	private IVisitaAtraccionDAO visitaAtraccionDao;
	
	@RequestMapping("/visitasJson")
	public HashMap<String, List<VisitaDTO>> listar() {
		HashMap<String, List<VisitaDTO>> lista = new HashMap<String, List<VisitaDTO>>();
		Set<VisitaAtraccion> listaVisitas = visitaAtraccionDao.getAll();
		HashMap<Atraccion,Set<String>> usuariosAtraccion = new HashMap<Atraccion,Set<String>>();
		for (VisitaAtraccion visitaAtraccion : listaVisitas) {
			Set<String> usuariosUnicos = usuariosAtraccion.get(visitaAtraccion.getAtraccion());
			if (usuariosUnicos == null) {
				usuariosUnicos = new LinkedHashSet<>();
				usuariosAtraccion.put(visitaAtraccion.getAtraccion(), usuariosUnicos);
			}
			usuariosUnicos.add(visitaAtraccion.getIdAndroid());
		}
		List<VisitaDTO> visitasDto = new LinkedList<>();
		for (Atraccion atraccion : usuariosAtraccion.keySet()) {
			VisitaDTO visitaDto = new VisitaDTO();
			visitaDto.setCantVisitas(usuariosAtraccion.get(atraccion).size());
			visitaDto.setNombre(atraccion.getNombre() + "," + atraccion.getCiudad().getNombre());
			visitasDto.add(visitaDto);
		}
		lista.put(DATA, visitasDto);
		return lista;
	}

}
