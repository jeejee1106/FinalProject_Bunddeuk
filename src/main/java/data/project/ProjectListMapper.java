package data.project;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ProjectListMapper {
	public List<ProjectDTO> getAllProjects();
	public List<ProjectDTO> getPopularProjects();
	public List<ProjectDTO> getClosingProjects();
	public List<ProjectDTO> getNewProjects();
	public List<ProjectDTO> getStateProjects(String category,String state,String percent,String search);
}