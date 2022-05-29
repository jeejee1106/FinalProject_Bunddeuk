package data.project;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.member.MemberDTO;
import data.member.MemberService;
import data.message.MessageService;
import data.mysetting.DeliveryDTO;

@Controller
public class DetailController {

	DetailService detailService;
	MessageService messageService;
	MemberService memberService;
	
	//생성자가 하나면 자동으로 Autowired가 붙는 효과가 있다. 기본생성자를 생성해?말어?
	public DetailController(DetailService detailService, MessageService messageService, MemberService memberService) {
		this.detailService = detailService;
		this.messageService = messageService;
		this.memberService = memberService;
	}
	
	//공개된 프로젝트의 디테일 페이지
	@GetMapping("/project/detail")
	public String getDetailData(int idx, String key, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sessionId");
		String name = memberService.getName(id);
		int likeCheck = detailService.getLikeCheck(idx, id);
		int supportCheck = detailService.getSupportCheck(idx, id);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date today = java.sql.Date.valueOf(sdf.format(new Date())); //현재 날짜(오늘) 구하기
		
		ProjectDTO projectDto = detailService.getData(idx);
		List<PresentDTO> presentList = detailService.getPresentData(idx);
		MemberDTO memberDto = detailService.getCreatorInfo(projectDto.getId());
		
		String pymDate1 = detailService.getPaymentDate(idx).substring(0,4);
		String pymDate2 = detailService.getPaymentDate(idx).substring(5,7);
		String pymDate3 = detailService.getPaymentDate(idx).substring(8,10);
		
		float totalAmount = projectDto.getTotal_amount();
		float targetAmount = projectDto.getTarget_amount();
		int percentageAchieved = (int)Math.round((totalAmount / targetAmount * 100));
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("pymDate", pymDate1 + "년 " + pymDate2 + "월 " + pymDate3 + "일");
		model.addAttribute("projectDto", projectDto);
		model.addAttribute("presentList", presentList);
		model.addAttribute("today", today);
		model.addAttribute("name", name);
		model.addAttribute("percentageAchieved", percentageAchieved);
		model.addAttribute("likeCheck", likeCheck);
		model.addAttribute("supportCheck", supportCheck);
		
		return "/project_detail/projectDetail";
	}
	
	//공개예정 프로젝트 디테일 페이지
	@GetMapping("/project/bookdetail")
	public String getBookDetailData(int idx, Model model) {
		ProjectDTO projectDto = detailService.getData(idx);
		MemberDTO memberDto = detailService.getCreatorInfo(projectDto.getId());
		
		model.addAttribute("projectDto", projectDto);
		model.addAttribute("memberDto", memberDto);
		return "/project_detail/projectBookDetail";
	}
	
	@PostMapping("/project/payment")
	public String getPaymentData(int idx, String key, HttpSession session, String pstN, String pstO, String pstP, Model model) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.sql.Date today = java.sql.Date.valueOf(sdf.format(new Date()));
		
		String id = (String)session.getAttribute("sessionId");
		
		ProjectDTO dto = detailService.getData(idx);
		MemberDTO mdto = memberService.getMemberInfo(id);
		DeliveryDTO ddto = detailService.getAddr(id);
		
		String pymDate1 = detailService.getPaymentDate(idx).substring(0,4);
		String pymDate2 = detailService.getPaymentDate(idx).substring(5,7);
		String pymDate3 = detailService.getPaymentDate(idx).substring(8,10);
		float totalAmount = dto.getTotal_amount();
		float targetAmount = dto.getTarget_amount();
		int percentageAchieved = (int)Math.round((totalAmount / targetAmount * 100));
		String addr = ddto.getAddr();
		String addr2 = ddto.getAddr2();
		
		if(pstN == null && pstO == null && pstP == null) {
			pstN = "선물 없이 후원하기";
			pstO = "없음";
			pstP = "1000";
		}
		if(pstO == null) {
			pstO = "없음";
		}
		
		model.addAttribute("pymDate", pymDate1 + "년 " + pymDate2 + "월 " + pymDate3 + "일");
		model.addAttribute("dto", dto);
		model.addAttribute("today", today);
		model.addAttribute("percentageAchieved", percentageAchieved);
		model.addAttribute("mdto", mdto);
		model.addAttribute("addr", addr+ " " + addr2);
		model.addAttribute("pstN", pstN);
		model.addAttribute("pstO", pstO);
		model.addAttribute("pstP", pstP);
		
		return "/project_detail/payment";
	}
	
	@ResponseBody
	@PostMapping("/payment/hpUpdate")
	public String setHp(MemberDTO dto) {
		detailService.setHp(dto);
		return dto.getHp();
	}
	
	@ResponseBody
	@PostMapping("/payment/emailUpdate")
	public String setEmail(MemberDTO dto) {
		detailService.setEmail(dto);
		return dto.getEmail();
	}
	
	@ResponseBody
	@GetMapping("/payment/deliveryInsert")
	public String deliveryInsert(DeliveryDTO ddto,HttpSession session) {
		
		String id = (String)session.getAttribute("sessionId");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		
		detailService.insertDelivery(ddto);
		
		return ddto.getAddr() + " " + ddto.getAddr2();
	}
	
	@ResponseBody
	@PostMapping("/liked/check")
	public int likedCheck(int idx, String id) {
		int check = detailService.getLikeCheck(idx, id);
		
		if(check == 0) {
			detailService.insertLikeProject(idx, id);
		}else {
			detailService.deleteLikeProject(idx, id);
		}
		return check;
	}
	
}
