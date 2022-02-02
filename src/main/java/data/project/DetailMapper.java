package data.project;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.member.MemberDTO;
import data.mysetting.DeliveryDTO;

@Mapper
public interface DetailMapper {
	public ProjectDTO getData(int idx);
	public String getPaymentDate(int idx);
	public String getCreatorImage(String id);
	public String getCreatorIntro(String id);
	public DeliveryDTO getAddr(String id);
	public void setHp(MemberDTO dto);
	public void setEmail(MemberDTO dto);
	public void insertDelivery(DeliveryDTO ddto);
	public int getLikeCheck(HashMap<String, Object> map);
	public void insertLikeProject(HashMap<String, Object> map);
	public void deleteLikeProject(HashMap<String, Object> map);
	public List<PresentDTO> getPresentData(int idx);
	public int getSupportCheck(HashMap<String, Object> map);
}
