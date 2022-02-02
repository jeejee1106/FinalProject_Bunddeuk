package data.support;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SupportService {

	@Autowired
	SupportMapper mapper;
	
	//support 테이블에 후원 정보 insert
	public void insertSupportData(SupportDTO dto) {
		mapper.insertSupportData(dto);
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
