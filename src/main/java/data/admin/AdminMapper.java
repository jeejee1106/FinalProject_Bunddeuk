package data.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.member.MemberDTO;
import data.project.ProjectDTO;

@Mapper
public interface AdminMapper {
	
	public List<ProjectDTO> getProjectList(int start, int perpage);
	public int getTotalCount();
	public void updateAuditAprvl(ProjectDTO pdto);
	public void updateAuditRefusal(ProjectDTO pdto);
	public String getAuditCount();
	
	public int getTotalMemberCount();
	public List<MemberDTO> getMemberList(int start, int perpage);
	public void deleteMember(String num);
	

}
