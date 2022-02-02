package data.profile;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.project.ProjectDTO;

@Service
public class ProfileService {
	
	@Autowired
	ProfileMapper mapper;
	
	public List<ProjectDTO> getCreativeProject (String id) {
		
		return mapper.getCreativeProject(id);
	}
	
	public ProjectDTO getProject (String idx) {
		
		return mapper.getProject(idx);
	}
	
	public void deleteCreativeProject (String idx) {
		
		mapper.deleteCreativeProject(idx);
	}
	
	public String getCreativeAuditCount (String audit, String id) {
		
		return mapper.getCreativeAuditCount(audit, id);
	}
	
	public List<SupportDetailDTO> getSupportProject (String id) {
		
		return mapper.getSupportProject(id);
	}
	
	public SupportDetailDTO getSupportData (String num) {
		
		return mapper.getSupportData(num);
	}
	
	public void deleteSupport (String num) {
		
		mapper.deleteSupport(num);
	}
	
	public List<LikedDTO> getLikedProject (String id) {
		
		return mapper.getLikedProject(id);
	}
	
	public void deleteLikedProject (String num) {
		
		mapper.deleteLikedProject(num);
	}
	
	public List<SupportDetailDTO> getSponsorList (String idx, String name, int start, int perpage) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("name", name);
		map.put("start", start);
		map.put("perpage", perpage);
		
		return mapper.getSponsorList(map);
	}
	
	public int getTotalSponsorCount (String idx, String name) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("name", name);
		
		return mapper.getTotalSponsorCount(map);
	}
	
	public SupportDetailDTO getSponsorMemberData (String num) {
		
		return mapper.getSponsorMemberData(num);
	}
	
	public void minusTotalAmountNumberPeople(String num) {
		
		mapper.minusTotalAmountNumberPeople(num);
	}

}