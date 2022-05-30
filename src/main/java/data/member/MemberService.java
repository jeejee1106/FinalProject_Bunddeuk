package data.member;

import java.util.HashMap;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public void insertMember(MemberDTO dto) {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 15;
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();

		String url = generatedString;
		String encodedPassword = passwordEncoder.encode(dto.getPass());

		dto.setUrl(url);
		dto.setPass(encodedPassword);
		memberMapper.insertMember(dto);
	}
	
	public int idDuplicateCheck(String id) {
		return memberMapper.idDuplicateCheck(id);
	}
	
	public int getNameCheck(String name) {
		return memberMapper.getNameCheck(name);
	}
	
	public int hasUrlCheck(String url) {
		return memberMapper.hasUrlCheck(url);
	}
	
	public int passCheck(HashMap<String, Object> map) {
		return memberMapper.passCheck(map);
	}
	
	public int hasEmailCheck(String email) {
		return memberMapper.hasEmailCheck(email);
	}
	
	public MemberDTO getAllProfile(HashMap<String, String> map) {
		return memberMapper.getAllProfile(map);
	}
	
	public MemberDTO getMember(Integer num) {
		return memberMapper.getMember(num);
	}
	
	public void updateMemberPhoto(MemberDTO dto) {
		memberMapper.updateMemberPhoto(dto);
	}
	
	public void updateMemberUrl(MemberDTO dto) {
		memberMapper.updateMemberUrl(dto);
	}
	
	public void updateMemberIntroduce(MemberDTO dto) {
		memberMapper.updateMemberIntroduce(dto);
	}
	
	public void updateMemberName(MemberDTO dto) {
		memberMapper.updateMemberName(dto);
	}
	
	public void updateMemberPrivacy(MemberDTO dto) {
		memberMapper.updateMemberPrivacy(dto);
	}
	
	public void updateMemberPass(MemberDTO dto) {
		String encodedPassword = passwordEncoder.encode(dto.getPass());
		dto.setPass(encodedPassword);
		memberMapper.updateMemberPass(dto);
	}
	
	public void updateEmailPass(MemberDTO dto) {
		String encodedPassword = passwordEncoder.encode(dto.getPass());
		dto.setPass(encodedPassword);
		memberMapper.updateEmailPass(dto);
	}
	
	public void updateMemberHp(MemberDTO dto) {
		memberMapper.updateMemberHp(dto);
	}
	
	public String getUrl(String id) {
		return memberMapper.getUrl(id);
	}
	
	public String getPhoto(String id) {
		return memberMapper.getPhoto(id);
	}
	
	public String getIntroduce(String id) {
		return memberMapper.getIntroduce(id);
	}
	
	public void deleteMember(int num) {
		memberMapper.deleteMember(num);
	}
	
	public String getName(String id) {
		return memberMapper.getName(id);
	}
	
	public String getIdUrl(String url) {
		return memberMapper.getIdUrl(url);
	}
	
	public int idPassCheck(String id, String pass) {
		return memberMapper.idPassCheck(id, pass);
	}
	
	public MemberDTO getMemberInfo(String id) {
		return memberMapper.getMemberInfo(id);
	}
	
	public MemberDTO memberByEmail(String email) {
		return memberMapper.memberByEmail(email);
	}
	
	public void updateMemberAuthkey(MemberDTO dto) {
		memberMapper.updateMemberAuthkey(dto);
	}
	
	public void updateMemberStatus(MemberDTO dto) {
		memberMapper.updateMemberStatus(dto);
	}
}
