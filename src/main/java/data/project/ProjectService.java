package data.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectService {

	@Autowired
	ProjectMapper mapper;
	
	public void insertCategory(ProjectDTO dto) {
		mapper.insertCategory(dto);
	}
	
	public int getMAxIdx() {
		return mapper.getMAxIdx();
	}
	
	public void storyUpdate(ProjectDTO dto) {
		mapper.storyUpdate(dto);
	}
	
	public void defaultUpdate(ProjectDTO dto) {
		mapper.defaultUpdate(dto);
	}
	
	public void fundingUpdate(ProjectDTO dto) {
		mapper.fundingUpdate(dto);
	}
	
	public void policyUpdate(ProjectDTO dto) {
		mapper.policyUpdate(dto);
	}
	
	public ProjectDTO getData(String idx) {
		return mapper.getData(idx);
	}
	
	public void insertPresent(PresentDTO pstdto) {
		mapper.insertPresent(pstdto);
	}
	
	public int getMaxNum() {
		return mapper.getMaxNum();
	}
	
	public void deletePresent(int num) {
		mapper.deletePresent(num);
	}
	
	public List<PresentDTO> getPresentData(int idx){
		return mapper.getPresentData(idx);
	}
	
	public void progressUpdata(ProjectDTO dto) {
		mapper.progressUpdata(dto);
	}
	
}
