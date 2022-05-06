package data.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class ProjectListService {

	@Autowired
	ProjectListMapper mapper;
	
	public List<ProjectDTO> getAllProjects(){
		return mapper.getAllProjects();
	}
	
	public List<ProjectDTO> getPopularProjects(){
		return mapper.getPopularProjects();
	}

	public List<ProjectDTO> getClosingProjects(){
		return mapper.getClosingProjects();
	}
	
	public List<ProjectDTO> getNewProjects(){
		return mapper.getNewProjects();
	}
	
	public List<ProjectDTO> getStateProjects (String category,String state,String percent,String search) {
		return mapper.getStateProjects(category,state,percent,search);
	}
}
