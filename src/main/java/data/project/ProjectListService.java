package data.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class ProjectListService {

	@Autowired
	ProjectListMapper mapper;
	
	public int getTotalCount() {
		return mapper.getTotalCount();
	}
	public List<ProjectDTO> getAllProjects (String category,String state,String percent,String search) {
		return mapper.getAllProjects(category,state,percent,search);
	}
	public List<ProjectDTO> allProjects(){
		return mapper.allProjects();
	};
	public List<ProjectDTO> endProjects(){
		return mapper.endProjects();
	};
	public List<ProjectDTO> newProjects(){
		return mapper.newProjects();
	};
	public List<ProjectDTO> popProjects(){
		return mapper.popProjects();
	};
	public List<ProjectDTO> bookedProjects(){
		return mapper.bookedProjects();
	}
}
