package data.admin;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.member.MemberDTO;
import data.project.ProjectDTO;

@Mapper
public interface AdminMapper {
	
	public List<MemberDTO> getMemberList(HashMap<String, Object> map);
	public List<ProjectDTO> getProjectList(HashMap<String, Object> map);
	public int getTotalCount();
	public void updateAuditAprvl(ProjectDTO pdto);
	public void updateAuditRefusal(ProjectDTO pdto);
	public String getAuditCount();
	public int getTotalMemberCount();
	public void deleteMember(String num);
	

}
