package data.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	MemberService memberService;

	@GetMapping("/home")
	public String home() {
		return "/";
	}
	
	@GetMapping("/main")
	public String join() {
		return "/member/join";
	}

	@GetMapping("/findpass")
	public String findpass() {
		return "/login/findPass";
	}
	
	@GetMapping("/join")
	public String memberform() {
		return "/member/memberForm";
	}
	
	@GetMapping("joinsuccess")
	public String joinsuccess() {
		return "/member/joinSuccess";
	}

	@PostMapping("/insert")
	public String memberInsert(@ModelAttribute MemberDTO dto) {
		memberService.insertMember(dto);
		return "/member/joinSuccess";
	}
	
	/*
	 * >>>>>>>>>>>>>>>>>>>>>>>>>이거 쓰는데도 없는데 대체 왜 있는거야 진짜 하<<<<<<<<<<<<<<<<<<<<<<<< 
	 * */
//	@GetMapping("/idcheck")
//	@ResponseBody
//	public Map<String, Integer> idCheckProcess(@RequestParam String id) {
//		//id 체크
//		int check = memberService.idDuplicateCheck(id);
//		
//		Map<String, Integer> map = new HashMap<String, Integer>();
//		map.put("check", check);//0 or 1
//		return map;
//	}
	
	
	/*
	 * TODO : 
	 * get~check 메서드 하나로 합칠 수 없는지 공부해보기.
	 * 메서드 이름도 싹 바꾸기
	 */
	@GetMapping("/emailcheck")
	@ResponseBody
	public Map<String, Integer> hasEmailCheck(@ModelAttribute MemberDTO dto) {
		//이메일이 있는지 없는지 체크. 있으면 1 반환
		int emailCnt = memberService.hasEmailCheck(dto.getEmail());
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("emailCnt", emailCnt);//0 or 1
		return map;
	}
	
	@GetMapping("/urlcheck")
	@ResponseBody
	public Map<String, Integer> urlCheckProcess(@RequestParam String url) {
		int urlCnt = memberService.hasUrlCheck(url);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("urlCnt", urlCnt);//0 or 1
		return map;
	}
	
	@GetMapping("/namecheck")
	@ResponseBody
	public Map<String, Integer> nameCheckProcess(@RequestParam String name) {
		int check = memberService.getNameCheck(name);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("check", check);//0 or 1
		return map;
	}
	
	@GetMapping("/passcheck")
	@ResponseBody
	public Map<String, Integer> passCheckProcess(@RequestParam int num,@RequestParam String pass) {
		
		MemberDTO dto = memberService.getMember(num);
		int check = 0;
		if(passwordEncoder.matches(pass, dto.getPass())) {
			//db로부터 비번이 맞는지 체크
			HashMap<String, String> map = new HashMap<String, String>();
			String num1 = Integer.toString(num);
			map.put("num", num1);
			map.put("pass", dto.getPass());
			//pass 체크
			check = memberService.getCheckPass(map);
		}
		Map<String, Integer> map2 = new HashMap<String, Integer>();
		map2.put("check", check);//0 or 1
		return map2;
	}
	
	@PostMapping("/memberdelete")
	public String delete(@RequestParam String num, @RequestParam String pass,HttpSession session){
		MemberDTO dto = memberService.getMember(Integer.parseInt(num));
		
		if(passwordEncoder.matches(pass, dto.getPass())) {
			//db로부터 비번이 맞는지 체크
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("num", num);
			map.put("pass", dto.getPass());
			int check = memberService.getCheckPass(map);
			if(check == 1) {
				//비번이 맞을경우 삭제
			memberService.deleteMember(num);
			session.removeAttribute("loginok");
			}
		}
		return "redirect:home";
	}

	@PostMapping("/kakaodelete")
	public String kakaoDelete(@RequestParam String num,HttpSession session) {
		memberService.deleteMember(num);
		session.removeAttribute("loginok");
		return "redirect:home";
	}
	
}
