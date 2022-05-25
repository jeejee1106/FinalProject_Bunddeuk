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
	MemberService memberService;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@GetMapping("/login/main")
	public String login(HttpSession session, Model model){
		String loginCheck = (String) session.getAttribute("loginok");
		return loginCheck == null ? "/login/loginForm" : "/";
	}
	
	//@RequestParam (required = false) 이렇게 해주면 null값도 받을수 있다
	@PostMapping("/login/login-process")
	public String loginProcess(@RequestParam (required = false) String rememberId, @RequestParam String id, @RequestParam String pass, HttpSession session) {
		MemberDTO memberDto = memberService.getMemberInfo(id);
		if(memberDto == null) {
			return "/login/passFail";
		} else {
//			//소셜 로그인
//			if(memberDto.getOauth() != null) {
//				return "/login/kakaoLoginFail";
//			}
			//일반 로그인
			int idPassCheck = memberService.idPassCheck(id, memberDto.getPass());
			String profileImage = memberDto.getPhoto();
			String nickName = memberDto.getName();
			if(idPassCheck == 1 && passwordEncoder.matches(pass, memberDto.getPass())) {
				session.setAttribute("profileImage", profileImage);
				session.setAttribute("nickName", nickName);
				session.setAttribute("id", id);
				session.setAttribute("checkid", id);
				session.setAttribute("loginok", "yes");
				String getUrl = memberService.getUrl(id);
				session.setAttribute("url",getUrl);
				session.setAttribute("rememberId", rememberId); //체크 안했을 경우 null, 체크 했을경우 on
				return "redirect:main";
			}else {
				return "/login/passFail";  
			}
		}
	}
	
	@GetMapping("/login/logoutprocess")
	public String logout(HttpSession session) {
		session.removeAttribute("id");
		session.removeAttribute("loginok");
		return "redirect:main";
	}
}
