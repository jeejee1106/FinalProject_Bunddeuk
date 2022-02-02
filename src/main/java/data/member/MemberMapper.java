 package data.member;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;



@Mapper
public interface MemberMapper {
	public void insertMember(MemberDTO dto);
	
	public int getIdCheck(String id);
	public int getNameCheck(String name);
	public int getCheckPass(HashMap<String, String> map);
	public int getUrlCheck(String url);
	public MemberDTO getMember(Integer num);
	public void updateMemberName(MemberDTO dto);
	public void updateMemberPhoto(MemberDTO dto);
	public void updateMemberUrl(MemberDTO dto);
	public void updateMemberIntroduce(MemberDTO dto);
	public void updateMemberPrivacy(MemberDTO dto);
	public void updateMemberPass(MemberDTO dto);
	public void updateMemberHp(MemberDTO dto);
	public void deleteMember(String num);
	public MemberDTO getAllProfile(HashMap<String, String> map);
	public String getName(String id);
	public MemberDTO getAll(String id);
	public int login(HashMap<String, String> map);
	public String getIdUrl(String id);
	public int getEmailCheck(String email);
	public void updateMemberAuthkey(MemberDTO dto);
	public void updateMemberStatus(MemberDTO dto);
	public void updateEmailPass(MemberDTO dto);
	public MemberDTO memberByEmail(String email);
	
	public String getUrl(String id);
	public String getPhoto(String id);
	public String getIntroduce(String id);

}
