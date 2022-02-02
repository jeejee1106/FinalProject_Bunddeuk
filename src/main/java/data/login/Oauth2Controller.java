package data.login;



import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import data.member.MemberDTO;
import data.member.MemberService;

@Controller
public class Oauth2Controller {
	
	@Autowired
	MemberService memberService;

    @GetMapping(value = "/login/kakao")
    public String kakaoOauthRedirect(String code,HttpSession session) {
    	
    	RestTemplate rt = new RestTemplate();
    	
    	HttpHeaders headers = new HttpHeaders();
    	headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
    	
    	
    	// HttpBody 오브젝트 생성
    	MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    		params.add("grant_type", "authorization_code");
    		params.add("client_id", "1439861063a7d822757160ad213d4a33");
    		params.add("redirect_uri", "http://localhost:9002/login/kakao");
    		params.add("code", code);

    	// HttpHeader와 HttpBody를 HttpEntity에 담기 (why? rt.exchange에서 HttpEntity객체를 받게 되어있다.)
    	HttpEntity<MultiValueMap<String, String>> kakaoRequest = new HttpEntity<>(params, headers);

    	// HTTP 요청 - POST방식 - response 응답 받기
    	ResponseEntity<String> response = rt.exchange(
    	    "https://kauth.kakao.com/oauth/token",
    	    HttpMethod.POST,
    	    kakaoRequest,
    	    String.class
    	);
    	
    	ObjectMapper objectMapper = new ObjectMapper();
    	
    	OAuthToken oauthToken = null;
    	
    	try {
    		oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
    	}catch(JsonMappingException e) {
    		e.printStackTrace();
    	}catch(JsonProcessingException e) {
    		e.printStackTrace();
    	}
    	
    //	System.out.println("카카오 엑세스 토큰 :"+oauthToken.getAccess_token());
    	
    	
    	
    	RestTemplate rt2 = new RestTemplate();
    	
    	HttpHeaders headers2 = new HttpHeaders();
    	headers2.add("Authorization", "Bearer "+oauthToken.getAccess_token());
    	headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
    	
    	
    	// HttpHeader와 HttpBody를 HttpEntity에 담기 (why? rt.exchange에서 HttpEntity객체를 받게 되어있다.)
    	HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers2);

    	// HTTP 요청 - POST방식 - response 응답 받기
    	ResponseEntity<String> response2 = rt2.exchange(
    	    "https://kapi.kakao.com/v2/user/me",
    	    HttpMethod.POST,
    	    kakaoProfileRequest,
    	    String.class
    	);
    	
    	
    	ObjectMapper objectMapper2 = new ObjectMapper();
    	KakaoProfile kakaoProfile = null;
    	
    	try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	
    	int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 15;
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();


    	
    	UUID garcagePassword = UUID.randomUUID();
    	
    	MemberDTO member = new MemberDTO();
    	String str = kakaoProfile.getKakao_account().getEmail();
    
    //	System.out.println(kakaoProfile.getId());
    	
    	
    	String kakaoId = str.substring(0,str.lastIndexOf("@"));
    	
    	member.setId("KKO-"+kakaoId);
    	member.setPass(garcagePassword.toString());
    	member.setEmail(kakaoProfile.getKakao_account().getEmail());
    	member.setName(kakaoProfile.getProperties().getNickname());
    	member.setOauth("kakao");
    	String url = generatedString;
		member.setUrl(url);
    	
    	int check = memberService.getIdCheck(member.getId());
    	if(check != 1) {
    		memberService.insertMember(member);
    	}
    	
    	
		MemberDTO dto = memberService.getAll(member.getId());
		String profileImage = dto.getPhoto();
			
		session.setAttribute("profileImage", profileImage);
		
		session.setAttribute("nickName", member.getName());
    	session.setAttribute("id", member.getId());
		session.setAttribute("loginok", "yes");
    	
        return "redirect:main";
    }
    
    
    
}