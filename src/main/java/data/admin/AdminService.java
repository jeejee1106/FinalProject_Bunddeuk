package data.admin;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.member.MemberDTO;
import data.project.ProjectDTO;

@Service
public class AdminService {

	@Autowired
	AdminMapper mapper;
	
	public List<ProjectDTO> getProjectList(int start, int perpage){
		
		return mapper.getProjectList(start, perpage);
	}
	public int getTotalCount() {
		
		return mapper.getTotalCount();
	}
	public void updateAuditAprvl(ProjectDTO pdto) {
		
		mapper.updateAuditAprvl(pdto);
	}
	public void updateAuditRefusal(ProjectDTO pdto) {
		
		mapper.updateAuditRefusal(pdto);
	}
	public String getAuditCount() {
		
		return mapper.getAuditCount();
	}
	public int getTotalMemberCount() {
		
		return mapper.getTotalMemberCount();
	}
	public List<MemberDTO> getMemberList(int currentPage, int pageSize) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("offset", (currentPage-1) * pageSize);
		map.put("pageSize", pageSize);
		return mapper.getMemberList(map);
	}
	public void deleteMember(String num) {
		
		mapper.deleteMember(num);
	}
}
