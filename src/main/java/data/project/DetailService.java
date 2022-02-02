package data.project;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.member.MemberDTO;
import data.mysetting.DeliveryDTO;

@Service
public class DetailService {
	
	@Autowired
	DetailMapper mapper;

	public ProjectDTO getData(int idx) {
		return mapper.getData(idx);
	}
	public String getPaymentDate(int idx) {
		return mapper.getPaymentDate(idx);
	}
	
	//작가의 프로필 이미지 가져오기
	public String getCreatorImage(String id) {
		return mapper.getCreatorImage(id);
	}
	
	//작가 소개 가져오기
	public String getCreatorIntro(String id) {
		return mapper.getCreatorIntro(id);
	}
	
	//세션아이디를 통해 addr값 가져오기
	public DeliveryDTO getAddr(String id) {
		return mapper.getAddr(id);
	}
	
	//핸드폰 번호가 null인 멤버들 핸드폰 번호 넣어주기
	public void setHp(MemberDTO dto) {
		mapper.setHp(dto);
	}
	
	//email일 null인 멤버들 email주소 넣어주기
	public void setEmail(MemberDTO dto) {
		mapper.setEmail(dto);
	}
	
	//주소 데이터가 없는 멤버들 주소 데이터 insert하기
	public void insertDelivery(DeliveryDTO ddto) {
		mapper.insertDelivery(ddto);
	}
	
	//좋아요 되어있는지 체크하기 (되어있으면 1, 안되어있으면 0 반환)
	public int getLikeCheck(int idx, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("id", id);
		return mapper.getLikeCheck(map);
	}
	
	// 좋아요 테이블에 추가
	public void insertLikeProject(int idx, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("id", id);
		mapper.insertLikeProject(map);
	}
	
	//좋아요 해제 시 삭제
	public void deleteLikeProject(int idx, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("id", id);
		mapper.deleteLikeProject(map);
	}
	
	//선물 정보 가져오기
	public List<PresentDTO> getPresentData(int idx) {
		return mapper.getPresentData(idx);
	}
	
	//이미 후원한 프로젝트인지 체크하기
	public int getSupportCheck(int idx, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("id", id);
		return mapper.getSupportCheck(map);
	}
	
}
