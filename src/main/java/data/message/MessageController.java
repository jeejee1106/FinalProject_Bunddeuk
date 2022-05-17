package data.message;

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
import org.springframework.web.servlet.ModelAndView;

import data.member.MemberDTO;
import data.member.MemberMapper;
import data.member.MemberService;


@Controller
public class MessageController {
	
	@Autowired
	MessageService messageService;
	@Autowired
	MemberMapper memberMapper;
	@Autowired
	MemberService memberService;
	
	// 받은 메세지 리스트
	@GetMapping("/message/receivedMessage")
	public String receivedList (HttpSession session, @RequestParam(defaultValue = "1") int currentPage, Model model) {
		String id = (String)session.getAttribute("id");
		String name = memberMapper.getName(id);
		
		int totalCount = messageService.getReceivedTotalCount(name);
		
		int perPage = 5; // 한페이지에 보여질 글의 갯수
		int totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1); // 총 페이지수
		int start = (currentPage - 1) * perPage; // 각페이지에서 불러올 db 의 시작번호 //민지 - 파라미터에 기본값 1넣어놓고 이거 왜 이렇게 하는거임...? 이러면 0나오잖아...
		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
		int startPage = (currentPage - 1) / perBlock * perBlock + 1; // 각 블럭에 표시할 시작페이지
		int endPage = startPage + perBlock - 1; // 각 블럭에 표시할 마지막페이지
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		System.out.println("currentPage : " + currentPage);
		System.out.println("한페이지에 보여질 글의 갯수 : " + perPage);
		System.out.println("총 페이지수 : " + totalPage);
		System.out.println("각페이지에서 불러올 db 의 시작번호 : " + start);
		System.out.println("몇개의 페이지번호씩 표현할것인가 : " + perBlock);
		System.out.println("각 블럭에 표시할 시작페이지 : " + startPage);
		System.out.println("각 블럭에 표시할 마지막페이지 : " + endPage);
		
		List<MessageDTO> recvList = messageService.getReceivedList(name, start, perPage);
		MemberDTO dto = memberService.getAll(id);
		
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
		model.addAttribute("totalCount", recvList.size());
		model.addAttribute("recvList", recvList);
		model.addAttribute("count", recvList.size()); //민지 - 얘 안쓰는 것 같은데, 차라리 totalCount를 없애고(그러면 sql도 따로 필요 없으니까) 얘를 쓰는 건 어떨까?
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", currentPage);
		
		return "/message/receivedMessageList";
	}
	
	// 보낸 메세지 리스트
	@GetMapping("/message/sentMessage")
	public String sentList (@RequestParam(defaultValue = "1") int currentPage, HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("id");
		String name = memberService.getName(id);
		MemberDTO dto = memberService.getAll(id);
		
		int totalCount = messageService.getSentTotalCount(name);
		
		int perPage = 5; // 한페이지에 보여질 글의 갯수
		int totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1); // 총 페이지수
		int start = (currentPage - 1) * perPage; // 각페이지에서 불러올 db 의 시작번호
		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
		int startPage = (currentPage - 1) / perBlock * perBlock + 1; // 각 블럭에 표시할 시작페이지
		int endPage = startPage + perBlock - 1; // 각 블럭에 표시할 마지막페이지
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		System.out.println("한페이지에 보여질 글의 갯수 : " + perPage);
		System.out.println("총 페이지수 : " + totalPage);
		System.out.println("각페이지에서 불러올 db 의 시작번호 : " + start);
		System.out.println("몇개의 페이지번호씩 표현할것인가 : " + perBlock);
		System.out.println("각 블럭에 표시할 시작페이지 : " + startPage);
		System.out.println("각 블럭에 표시할 마지막페이지 : " + endPage);
		
		List<MessageDTO> sendList = messageService.getSentMessageList(name, start, perPage);
		
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
		model.addAttribute("sendList", sendList);
		model.addAttribute("count", sendList.size());
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalCount", totalCount);
		
		return "/message/sentMessageList";
		
	}
	
	// 메세지 가져오기
	@GetMapping("/message/messagedata")
	@ResponseBody
	public MessageDTO data(String num, HttpSession session) {
		
		String id = (String) session.getAttribute("id");
		String name = memberService.getName(id);
		
		messageService.updateReadCount(name, num);
		return messageService.getMessage(num);
	}
	
	// 답장하기 insert
	@PostMapping("/message/messageReply")
	@ResponseBody
	public void reply(@ModelAttribute MessageDTO dto, HttpSession session) {
		String id = (String) session.getAttribute("id");
		String name = memberMapper.getName(id);
		
		dto.setId(id);
		dto.setSend_name(name);
		
		messageService.insertMessage(dto);	
		
	}
		
}
