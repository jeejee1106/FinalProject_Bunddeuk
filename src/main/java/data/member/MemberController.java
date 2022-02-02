package data.member;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class MemberController {

	String url = "";
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	MemberService service;
	
	@GetMapping("/member/home")
	public String home() {
		return "/";
	}
	
	@GetMapping("/member/main")
	public String join() {

		return "/member/join";
	}

	@GetMapping("/member/findpass")
	public String findpass() {
		return "/login/findPass";
	}
	
	
	
	@GetMapping("/member/join")
	public String memberform() {

		return "/member/memberForm";
	}
	
	@GetMapping("/member/joinsuccess")
	public String joinsuccess() {

		return "/member/joinSuccess";
	}

	@PostMapping("/member/insert")
	public String memberInsert(@ModelAttribute MemberDTO dto) {

		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 15;
		Random random = new Random();

		String generatedString = random.ints(leftLimit, rightLimit + 1)
				.filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();


		url = generatedString;
		dto.setUrl(url);
		service.insertMember(dto);
		return "/member/joinSuccess";
	}
	
	@GetMapping("/member/idcheck") //@responsebody 를 넣어주면 rest컨트롤러처럼 변경
	public @ResponseBody Map<String, Integer> idCheckProcess(@RequestParam String id) 
	{
		//id 체크
		int check = service.getIdCheck(id);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("check", check);//0 or 1
		return map;
	}
	
	
	@GetMapping("/member/emailcheck") //@responsebody 를 넣어주면 rest컨트롤러처럼 변경
	public @ResponseBody Map<String, Integer> emailcheck(@ModelAttribute MemberDTO dto) 
	{
		
		int check = service.getEmailCheck(dto.getEmail());
		
		Map<String, Integer> map2 = new HashMap<String, Integer>();
		map2.put("check", check);//0 or 1
		return map2;
	}
	
	
	
	@GetMapping("/member/urlcheck") //@responsebody 를 넣어주면 rest컨트롤러처럼 변경
	public @ResponseBody Map<String, Integer> urlCheckProcess(@RequestParam String url) 
	{
		//id 체크
		int check = service.getUrlCheck(url);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("check", check);//0 or 1
		return map;
	}
	
	@GetMapping("/member/namecheck") //@responsebody 를 넣어주면 rest컨트롤러처럼 변경
	public @ResponseBody Map<String, Integer> nameCheckProcess(@RequestParam String name) 
	{
		//id 체크
		int check = service.getNameCheck(name);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("check", check);//0 or 1
		return map;
	}
	
	@GetMapping("/member/passcheck") //@responsebody 를 넣어주면 rest컨트롤러처럼 변경
	public @ResponseBody Map<String, Integer> passCheckProcess(@RequestParam int num,@RequestParam String pass) 
	{
		
		MemberDTO dto = service.getMember(num);
		int check = 0;
		if(passwordEncoder.matches(pass, dto.getPass())) {
			//db로부터 비번이 맞는지 체크
			HashMap<String, String> map = new HashMap<String, String>();
			String num1 = Integer.toString(num);
			map.put("num", num1);
			map.put("pass", dto.getPass());
			//pass 체크
			check = service.getCheckPass(map);
			
		}
		
		Map<String, Integer> map2 = new HashMap<String, Integer>();
		map2.put("check", check);//0 or 1
		return map2;
		
	}
	
	@PostMapping("/member/memberdelete")
	public String delete(@RequestParam String num, @RequestParam String pass,HttpSession session){
		MemberDTO dto = service.getMember(Integer.parseInt(num));
		if(passwordEncoder.matches(pass, dto.getPass())) {
			//db로부터 비번이 맞는지 체크
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("num", num);
			map.put("pass", dto.getPass());
			int check = service.getCheckPass(map);
			if(check == 1) {
				//비번이 맞을경우 삭제
			service.deleteMember(num);
			session.removeAttribute("loginok");
			}
		}
		return "redirect:home";
	}
	

	@PostMapping("/member/kakaodelete")
	public String kakaoDelete(@RequestParam String num,HttpSession session){
		service.deleteMember(num);
		session.removeAttribute("loginok");
		return "redirect:home";
	}

	
	


}
