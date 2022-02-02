package data.profile;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.project.ProjectDTO;

@Mapper
public interface ProfileMapper {
	
	public List<ProjectDTO> getCreativeProject(String id); // 내가 만든 프로젝트 리스트
	public ProjectDTO getProject(String idx);
	public void deleteCreativeProject(String idx); //창작한 프로젝트 삭제
	
	public List<SupportDetailDTO> getSupportProject(String id); // 후원한 프로젝트 리스트
	public SupportDetailDTO getSupportData(String num);
	public void deleteSupport(String num);
	
	public List<LikedDTO> getLikedProject(String id); // 찜한 프로젝트 리스트
	public void deleteLikedProject(String idx);
	
	public String getCreativeAuditCount(String audit, String id);
	
	public List<SupportDetailDTO> getSponsorList(HashMap<String, Object> map); // 후원자 리스트
	public int getTotalSponsorCount(HashMap<String, Object> map);
	public SupportDetailDTO getSponsorMemberData(String num); // 후원자 정보 가져오기
	public void minusTotalAmountNumberPeople(String num); //후원 취소 시 project db에서 금액, 후원자수 마이너스
}
