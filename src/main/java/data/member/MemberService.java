package data.member;

import java.util.HashMap;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	@Autowired
	MemberMapper mapper;
	
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
		mapper.insertMember(dto);
	}
	
	public int idDuplicateCheck(String id) {
		return mapper.idDuplicateCheck(id);
	}
	
	public int getNameCheck(String name) {
		return mapper.getNameCheck(name);
	}
	
	public int hasUrlCheck(String url) {
		return mapper.hasUrlCheck(url);
	}
	
	public int getCheckPass(HashMap<String, String> map) {
		return mapper.getCheckPass(map);
	}
	
	public int hasEmailCheck(String email) {
		return mapper.hasEmailCheck(email);
	}
	
	public MemberDTO getAllProfile(HashMap<String, String> map) {
		return mapper.getAllProfile(map);
	}
	
	public MemberDTO getMember(Integer num) {
		return mapper.getMember(num);
	}
	
	public void updateMemberPhoto(MemberDTO dto) {
		mapper.updateMemberPhoto(dto);
	}
	
	public void updateMemberUrl(MemberDTO dto) {
		mapper.updateMemberUrl(dto);
	}
	
	public void updateMemberIntroduce(MemberDTO dto) {
		mapper.updateMemberIntroduce(dto);
	}
	
	public void updateMemberName(MemberDTO dto) {
		mapper.updateMemberName(dto);
	}
	
	public void updateMemberPrivacy(MemberDTO dto) {
		mapper.updateMemberPrivacy(dto);
	}
	
	public void updateMemberPass(MemberDTO dto) {
		String encodedPassword = passwordEncoder.encode(dto.getPass());
		dto.setPass(encodedPassword);
		mapper.updateMemberPass(dto);
	}
	
	public void updateEmailPass(MemberDTO dto) {
		String encodedPassword = passwordEncoder.encode(dto.getPass());
		dto.setPass(encodedPassword);
		mapper.updateEmailPass(dto);
	}
	
	public void updateMemberHp(MemberDTO dto) {
		mapper.updateMemberHp(dto);
	}
	
	public String getUrl(String id) {
		return mapper.getUrl(id);
	}
	
	public String getPhoto(String id) {
		return mapper.getPhoto(id);
	}
	
	public String getIntroduce(String id) {
		return mapper.getIntroduce(id);
	}
	
	public void deleteMember(String num) {
		mapper.deleteMember(num);
	}
	
	public String getName(String id) {
		return mapper.getName(id);
	}
	
	public String getIdUrl(String url) {
		return mapper.getIdUrl(url);
	}
	
	public int idPassCheck(String id, String pass) {
		return mapper.idPassCheck(id, pass);
	}
	
	public MemberDTO getMemberInfo(String id) {
		return mapper.getMemberInfo(id);
	}
	
	public MemberDTO memberByEmail(String email) {
		return mapper.memberByEmail(email);
	}
	
	public void updateMemberAuthkey(MemberDTO dto) {
		mapper.updateMemberAuthkey(dto);
	}
	
	public void updateMemberStatus(MemberDTO dto) {
		mapper.updateMemberStatus(dto);
	}
}
