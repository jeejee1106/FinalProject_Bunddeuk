package data.support;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.project.ProjectDTO;
import data.project.ProjectListMapper;

@Service
public class SupportService {

	@Autowired
	SupportMapper mapper;
	@Autowired
	ProjectListMapper listMapper;
	
	//support 테이블에 후원 정보 insert
	public List<ProjectDTO> insertSupportData(SupportDTO dto) {
		mapper.insertSupportData(dto);
		
		List<ProjectDTO> allProjectsList=listMapper.getAllProjects();
		if(allProjectsList.size()>4) {
			List<ProjectDTO> recommendList = new ArrayList<ProjectDTO>();
			int [] randomNumber = new int[4];
			for(int i=0; i<4; i++) {
				randomNumber[i] = (int)(Math.random()*(allProjectsList.size()-1));
				for(int j=0; j<i; j++) {
					if(randomNumber[j] == randomNumber[i]) {
						i--;
						continue;
					}
				}
				recommendList.add(allProjectsList.get(randomNumber[i]));
			}
			return recommendList;
		}else {
			return allProjectsList;
		}
	}
	
	//project테이블에 후원자수 업데이트
	public void addSupporter(int idx) {
		mapper.addSupporter(idx);
	}
	
	//project테이블에 모인 금액 업데이트
	public void addTotalAmount(int pstP, int idx){
		mapper.addTotalAmount(pstP, idx);
	}
	
	//세션아이디를 통해 email값 가져오기
	public String getEmail(String id) {
		return mapper.getEmail(id);
	}
	
	//세션아이디를 통해 hp값 가져오기
	public String getHp(String id) {
		return mapper.getHp(id);
	}
	
	//세션 아이디를 통해 addr값 가져오기
	public String getAddr(String id) {
		return mapper.getAddr(id);
	}
}
