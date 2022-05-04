package data.project;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ProjectListMapper {

	public int getTotalCount();
	public List<ProjectDTO> getAllProjects();
	public List<ProjectDTO> getPopularProjects();
	public List<ProjectDTO> getClosingProjects();
	public List<ProjectDTO> getNewProjects();
	public List<ProjectDTO> bookedProjects(); //어디서 누가 쓰는지 파악이 안돼서 메서드명 수정 못했음
	public List<ProjectDTO> getStateProjects(String category,String state,String percent,String search);
}