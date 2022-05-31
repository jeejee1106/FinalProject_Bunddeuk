package data.mysetting;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import data.member.MemberDTO;
import data.member.MemberService;

@Controller
public class SettingController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	DeliveryService deliveryService;
	
	@GetMapping("/setting/main")
	public ModelAndView home(HttpSession session, Model model) {
		
		ModelAndView mview = new ModelAndView();
		String id = (String) session.getAttribute("sessionId");
		MemberDTO dto = memberService.getMemberInfo(id);
		List<DeliveryDTO> list = deliveryService.getPinList(id);
		int totalCount = deliveryService.getTotalCount(id);
		
		mview.addObject("dto", dto);
		mview.addObject("list", list);
		mview.addObject("totalCount", totalCount);
		mview.setViewName("/mysetting/settingForm");
		return mview;
	}
	
	@GetMapping("/setting/delivery")
	public ModelAndView delivery(HttpSession session, Model model) {
		
		ModelAndView mview = new ModelAndView();
		String id = (String) session.getAttribute("sessionId");
		MemberDTO dto = memberService.getMemberInfo(id);
		List<DeliveryDTO> list = deliveryService.getPinList(id);
		int totalCount = deliveryService.getTotalCount(id);
		
		mview.addObject("dto", dto);
		mview.addObject("list", list);
		mview.addObject("totalCount", totalCount);
		mview.setViewName("/mysetting/delivery");
		return mview;
	}
	
	@ResponseBody
	@GetMapping("/setting/alist")
	public List<DeliveryDTO> alist(HttpSession session){
		String id = (String) session.getAttribute("sessionId");
		List<DeliveryDTO> list = deliveryService.getPinList(id);
		
		return list;
	}
	
	@ResponseBody
	@GetMapping("/setting/deliveryupdate")
	public HashMap<String, String> home2(HttpSession session, @RequestParam String num) {
		String id = (String) session.getAttribute("sessionId");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("num", num);
		
		DeliveryDTO ddto = deliveryService.getAllDelivery(map);
		
		String name = ddto.getName();
		String addr = ddto.getAddr();
		String addr2 = ddto.getAddr2();
		String hp = ddto.getHp();
		String pin = String.valueOf(ddto.getPin());
		
		HashMap<String, String> rmap = new HashMap<String, String>();
		rmap.put("num", num);
		rmap.put("name", name);
		rmap.put("addr", addr);
		rmap.put("addr2", addr2);
		rmap.put("hp", hp);
		rmap.put("pin", pin);
		return rmap;
	} 
	
	@PostMapping("/setting/updatephoto")
	public String updatePhoto(@RequestParam MultipartFile file,@ModelAttribute MemberDTO dto, HttpSession session) {
		//업로드할 폴더 지정
		String path = session.getServletContext().getRealPath("/profile_image");
		//업로드할 파일명
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		//업로드 안한경우
		if(file.getOriginalFilename().equals("")) {
			dto.setPhoto(null);
		}else {//업로드한 경우
			
			//업로드된 파일명
			String uploadfileName = memberService.getMember(dto.getNum()).getPhoto();
			//File 객체 생성
			File file2 = new File(path + "/" + uploadfileName);
			//파일 삭제
			file2.delete();
			
			String uploadfile = "f" + sdf.format(new Date()) + file.getOriginalFilename();
			dto.setPhoto(uploadfile);
			
			session.setAttribute("profileImage", uploadfile);
			
			//실제 업로드
			try {
				file.transferTo(new File(path + "/" + uploadfile));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		//수정
		memberService.updateMemberPhoto(dto);
		return "redirect:main";
	}
	
	@PostMapping("/setting/updatename")
	public String updateName(@ModelAttribute MemberDTO dto) {
		memberService.updateMemberName(dto);
		return "redirect:main";
	}
	
	@PostMapping("/setting/updateurl")
	public String updateUrl(HttpSession session,@ModelAttribute MemberDTO dto) {
		session.removeAttribute("url");
		session.setAttribute("url",dto.getUrl());
		memberService.updateMemberUrl(dto);
		return "redirect:main";
	}
	
	@PostMapping("/setting/privacyupdate")
	public String privacyupdate(@ModelAttribute MemberDTO dto) {
		if(dto.getPrivacy()==null) {
			dto.setPrivacy("0");
		}else {
			dto.setPrivacy("1");
		}
		memberService.updateMemberPrivacy(dto);
		return "redirect:main";
	}
	
	@PostMapping("/setting/updateintroduce")
	public String updateIntroduce(@ModelAttribute MemberDTO dto) {
		String content = dto.getIntroduce().replaceAll("\r\n","<br>");
		dto.setIntroduce(content);
		memberService.updateMemberIntroduce(dto);
		return "redirect:main";
	}
	
	@PostMapping("/setting/updatepass")
	public String updatePass(@ModelAttribute MemberDTO dto) {
	//	System.out.println("패스워드 업데이트성공");
		memberService.updateMemberPass(dto);
		return "redirect:main";
	}
	
	@PostMapping("/setting/updatehp")
	public String updateHp(@ModelAttribute MemberDTO dto) {
		memberService.updateMemberHp(dto);
		return "redirect:main";
	}
	
	@GetMapping("/setting/leave")
	public ModelAndView leave(HttpSession session, Model model) {
		ModelAndView mview = new ModelAndView();
		
		String id = (String) session.getAttribute("sessionId");
		MemberDTO dto = memberService.getMemberInfo(id);
		
		mview.addObject("dto", dto);
		mview.setViewName("/mysetting/leave");
		return mview;
	}
	
	@GetMapping("/setting/validation")
	public ModelAndView validation(HttpSession session, Model model) {
		ModelAndView mview = new ModelAndView();
		
		String id = (String) session.getAttribute("sessionId");
		MemberDTO dto = memberService.getMemberInfo(id);
		
		mview.addObject("dto", dto);
		mview.setViewName("/mysetting/validation");
		return mview;
	}
	
	@GetMapping("/setting/deliveryinsert")
	public @ResponseBody String deliveryInsert(@ModelAttribute DeliveryDTO ddto,HttpSession session) {
		
		String id = (String)session.getAttribute("sessionId");
		String pin = String.valueOf(ddto.getPin());
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pin", pin);
		
		int check = deliveryService.getPin(map);
		
		if(check==1) {
			int num = deliveryService.getPinNum(map);
			deliveryService.updateDeliveryPin(num);
		}
		deliveryService.insertDelivery(ddto);
		
		return "redirect:home";
	}
	
	@GetMapping("/setting/updatedelivery")
	public @ResponseBody void updateDelivery(@ModelAttribute DeliveryDTO ddto,HttpSession session) {
		String id = (String)session.getAttribute("sessionId");
		String pin = String.valueOf(ddto.getPin());
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pin", pin);
		
		int check = deliveryService.getPin(map);
	//	System.out.println("check : "+check);
		if(check==1) {
			int num = deliveryService.getPinNum(map);
			deliveryService.updateDeliveryPin(num);
		}
		deliveryService.updateDelivery(ddto);
	}
	
	@GetMapping("/setting/deliverydelete")
	public @ResponseBody String deliverydelete(@RequestParam String num,HttpSession session){
		String id = (String)session.getAttribute("sessionId");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("num", num);
		map.put("id", id);
		
		deliveryService.deleteDelivery(map);
		
		return "redirect:home";
	}
}
