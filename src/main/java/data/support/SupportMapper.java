package data.support;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import data.project.ProjectDTO;

@Mapper
public interface SupportMapper {

	public ArrayList<ProjectDTO> insertSupportData(SupportDTO dto);
	public void addSupporter(int idx);
	public void addTotalAmount(int pstP, int idx);
	public String getEmail(String id);
	public String getHp(String id);
	public String getAddr(String id);
}
