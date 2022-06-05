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
	public String home(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("sessionId");
		MemberDTO memberDto = memberService.getMemberInfo(id);
//		List<DeliveryDTO> addrList = deliveryService.addrListOfPinDesc(id); ///쓰는 곳 없다고 판단되어 일단 주석 처리함
//		int addrCount = deliveryService.getAddrCount(id); //쓰는 곳 없다고 판단되어 일단 주석 처리함
		
		model.addAttribute("memberDto", memberDto);
//		model.addAttribute("addrList", addrList); //원래 변수명 : list
//		model.addAttribute("addrCount", addrCount); //원래 변수명 : totalCount
		return "/mysetting/settingForm";
	}
	
	@GetMapping("/setting/delivery")
	public String delivery(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("sessionId");
		MemberDTO memberDto = memberService.getMemberInfo(id);
		List<DeliveryDTO> addrList = deliveryService.addrListOfPinDesc(id);
		int addrCount = deliveryService.getAddrCount(id);
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("addrList", addrList);
		model.addAttribute("addrCount", addrCount);
		return "/mysetting/delivery";
	}
	
	/**
	 * 이건 또 어디에 쓰이는 메서드일꼬...
	 */
//	@ResponseBody
//	@GetMapping("/setting/alist")
//	public List<DeliveryDTO> alist(HttpSession session){
//		String id = (String) session.getAttribute("sessionId");
//		List<DeliveryDTO> list = deliveryService.addrListOfPinDesc(id);
//		return list;
//	}
	
	@ResponseBody
	@GetMapping("/setting/update-address")
	public HashMap<String, Object> updateAddress(HttpSession session, @RequestParam int num) {
		String id = (String) session.getAttribute("sessionId");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("num", num);
		DeliveryDTO deliveryDto = deliveryService.getAllDelivery(map);
		
		HashMap<String, Object> rmap = new HashMap<String, Object>();
		rmap.put("num", num);
		rmap.put("name", deliveryDto.getName());
		rmap.put("addr", deliveryDto.getAddr());
		rmap.put("addr2", deliveryDto.getAddr2());
		rmap.put("hp", deliveryDto.getHp());
		rmap.put("pin", deliveryDto.getPin());
		return rmap;
	} 
	
	@PostMapping("/setting/update-image")
	public String updateImage(@RequestParam MultipartFile file, @ModelAttribute MemberDTO dto, HttpSession session) {
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
	
	@PostMapping("/setting/update-name")
	public String updateName(HttpSession session, String name) {
		String id = (String) session.getAttribute("sessionId");
		memberService.updateName(name , id);
		return "redirect:main";
	}
	
	@PostMapping("/setting/update-url")
	public String updateUrl(HttpSession session, String url) {
		String id = (String) session.getAttribute("sessionId");
		session.removeAttribute("url");
		session.setAttribute("url", url);
		memberService.updateUrl(url, id);
		return "redirect:main";
	}
	
	@PostMapping("/setting/update-introduce")
	public String updateIntroduce(HttpSession session, String introduce, @ModelAttribute MemberDTO memberDto) {
		String id = (String) session.getAttribute("sessionId");
		introduce = memberDto.getIntroduce().replaceAll("\r\n","<br>"); //이렇게 안바꿔주면 프론트 단에서 js가 안먹힘.
		memberDto.setIntroduce(introduce);
		
		memberService.updateIntroduce(introduce, id);
		return "redirect:main";
	}
	
	@PostMapping("/setting/update-privacy")
	public String privacyupdate(@ModelAttribute MemberDTO dto, HttpSession session) {
		String id = (String) session.getAttribute("sessionId");
		dto.setId(id);
		if(dto.getPrivacy()==null) {
			dto.setPrivacy("0");
		}else {
			dto.setPrivacy("1");
		}
		memberService.updatePrivacyCheck(dto);
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
