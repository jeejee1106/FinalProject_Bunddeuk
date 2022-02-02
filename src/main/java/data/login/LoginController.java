package data.login;


import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import data.member.MemberDTO;
import data.member.MemberService;



@Controller
public class LoginController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/login/main")
	public String login(HttpSession session, Model model){
		
		String id = (String) session.getAttribute("id");
		String loginok = (String) session.getAttribute("loginok");
		
		if(loginok == null) {
			return "/login/loginForm";
		}else {
			//로그인중일경우 request에 로그인한 이름 저장하기
			String name = service.getName(id);
			model.addAttribute("name", name);
			return "/";
		}
		
	}
	
	
	//@RequestParam (required = false) 이렇게 해주면 null값도 받을수 있다
	@PostMapping("/login/loginprocess")
	public String loginprocess(@RequestParam (required = false) String cbsave, @RequestParam String id, @RequestParam String pass,
			HttpSession session) {
		
		int idcheck = service.getIdCheck(id);
		 if(idcheck==0) {
			 return "/login/passFail";  
		 }
		
		 MemberDTO dto = service.getAll(id);
		 
		 String oauthNullCheck = dto.getOauth();
		 if(oauthNullCheck != null) {
			 return "/login/kakaoLoginFail";
		 }
	//		 if(dto.getOauth().equals("kakao")) {
		//		 return "/login/kakaoLoginFail";  
		//	 }
		String profileImage = dto.getPhoto();
		String nickName = dto.getName();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pass", dto.getPass());
		int check = service.login(map);
		if(check == 1 &&passwordEncoder.matches(pass, dto.getPass())) {
			session.setAttribute("profileImage", profileImage);
			session.setAttribute("nickName", nickName);
			session.setAttribute("id", id);
			session.setAttribute("checkid", id);
			session.setAttribute("loginok", "yes");
			String getUrl = service.getUrl(id);
			session.setAttribute("url",getUrl);
			session.setAttribute("saveok", cbsave); //체크 안했을 경우 null, 체크 했을경우 on
			return "redirect:main";
		}else {
			return "/login/passFail";  
		}
	}
	
	@GetMapping("/login/logoutprocess")
	public String logout(HttpSession session) {
		session.removeAttribute("id");
		session.removeAttribute("loginok");
		return "redirect:main";
	}
	
	
	
	
	
	
	
	
	
	
	

}
