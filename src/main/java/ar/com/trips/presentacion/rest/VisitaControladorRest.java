package ar.com.trips.presentacion.rest;

import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
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
import ar.com.trips.presentacion.dto.UsuarioDTO;
import ar.com.trips.presentacion.dto.VisitaDTO;

@RestController
public class VisitaControladorRest {
	
	public static final String DATA = "data";
	
	@Autowired
	private IVisitaAtraccionDAO visitaAtraccionDao;
	
	@RequestMapping("/visitasJson")
	public HashMap<String, List<VisitaDTO>> listar() {
		HashMap<String, List<VisitaDTO>> lista = new HashMap<String, List<VisitaDTO>>();
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.YEAR, -1);
		int month = calendar.get(Calendar.MONTH) + 1;
		String fechaInicio = calendar.get(Calendar.YEAR) + "/" + month + "/" + calendar.get(Calendar.DAY_OF_MONTH);
		Set<VisitaAtraccion> listaVisitas = visitaAtraccionDao.getAll(fechaInicio);
		HashMap<Atraccion, Set<UsuarioDTO>> usuariosAtraccion = getUsuariosUnicos(listaVisitas);
		List<VisitaDTO> visitasDto = new LinkedList<>();
		for (Atraccion atraccion : usuariosAtraccion.keySet()) {
			VisitaDTO visitaDto = new VisitaDTO();
			visitaDto.setCantVisitas(usuariosAtraccion.get(atraccion).size());
			visitaDto.setNombre(atraccion.getNombre() + "," + atraccion.getCiudad().getNombre());
			visitasDto.add(visitaDto);
		}
		Collections.sort(visitasDto);
		lista.put(DATA, visitasDto.subList(0, 10));
		return lista;
	}
	
	private static HashMap<Atraccion, Set<UsuarioDTO>> getUsuariosUnicos(Collection<VisitaAtraccion> listaVisitas) {
		Set<VisitaAtraccion> visitas = new LinkedHashSet<>(listaVisitas);
		Set<VisitaAtraccion> visitasRetorno = new LinkedHashSet<>();
		HashMap<Atraccion,Set<UsuarioDTO>> usuariosUnicosPorAtraccion = new HashMap<>();
		for (VisitaAtraccion visita : visitas) {
			Set<UsuarioDTO> usuariosUnicos = usuariosUnicosPorAtraccion.get(visita.getAtraccion());
			if (usuariosUnicos == null) {
				usuariosUnicos = new LinkedHashSet<>();
				usuariosUnicosPorAtraccion.put(visita.getAtraccion(), usuariosUnicos);
			}
			if (visita.getIdRedSocial() != null && !contienePorRedSocial(usuariosUnicos,visita)) {
				UsuarioDTO u = new UsuarioDTO();
				u.setIdAndroid(visita.getIdAndroid());
				u.setIdRedSocial(visita.getIdRedSocial());
				usuariosUnicos.add(u);
				visitasRetorno.add(visita);
			}
		}
		for (VisitaAtraccion visita : visitas) {
			Set<UsuarioDTO> usuariosUnicos = usuariosUnicosPorAtraccion.get(visita.getAtraccion());
			if (usuariosUnicos == null) {
				usuariosUnicos = new LinkedHashSet<>();
				usuariosUnicosPorAtraccion.put(visita.getAtraccion(), usuariosUnicos);
			}
			if (!contienePorIdAndroid(usuariosUnicos,visita)) {
				UsuarioDTO u = new UsuarioDTO();
				u.setIdAndroid(visita.getIdAndroid());
				u.setIdRedSocial(visita.getIdRedSocial());
				usuariosUnicos.add(u);
				visitasRetorno.add(visita);
			}
			
		}
		return usuariosUnicosPorAtraccion;
	}

	private static boolean contienePorRedSocial(Set<UsuarioDTO> usuariosUnicos, VisitaAtraccion visita) {
		for (UsuarioDTO usuario : usuariosUnicos) {
			if (visita.getIdRedSocial().equals(usuario.getIdRedSocial())) {
				return true;
			}
		}
		return false;
	}
	
	private static boolean contienePorIdAndroid(Set<UsuarioDTO> usuariosUnicos, VisitaAtraccion visita) {
		for (UsuarioDTO usuario : usuariosUnicos) {
			if (visita.getIdRedSocial() != null) {
				if (visita.getIdAndroid().equals(usuario.getIdAndroid()) || visita.getIdRedSocial().equals(usuario.getIdRedSocial())) {
					return true;
				}				
			} else {
				if (visita.getIdAndroid().equals(usuario.getIdAndroid())) {
					return true;
				}
			}
		}
		return false;
	}

}
