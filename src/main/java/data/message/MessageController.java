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

import data.member.MemberDTO;
import data.member.MemberService;
import data.paging.PagingHandler;

@Controller
public class MessageController {
	
	@Autowired
	MessageService messageService;
	@Autowired
	MemberService memberService;
	
	// 받은 메세지 리스트
	@GetMapping("/message/receivedMessage")
	public String receivedList (HttpSession session, @RequestParam(defaultValue = "1") int currentPage, @RequestParam(defaultValue = "5") int pageSize, Model model) {
		String id = (String)session.getAttribute("id");
		String name = memberService.getName(id);
		
		MemberDTO memberDto = memberService.getMemberInfo(id);
		int totalCount = messageService.getReceivedTotalCount(name);
		List<MessageDTO> recvList = messageService.getReceivedList(name, currentPage, pageSize);
		PagingHandler pagingHandler = new PagingHandler(totalCount, currentPage, pageSize);
		
		model.addAttribute("dto", memberDto);
		model.addAttribute("name", name);
		model.addAttribute("recvList", recvList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("ph", pagingHandler);
		
		return "/message/receivedMessageList";
	}
	
	// 보낸 메세지 리스트
	@GetMapping("/message/sentMessage")
	public String sentList (@RequestParam(defaultValue = "1") int currentPage, @RequestParam(defaultValue = "5") int pageSize, HttpSession session, Model model) {
		String id = (String)session.getAttribute("id");
		String name = memberService.getName(id);
		
		MemberDTO dto = memberService.getMemberInfo(id);
		int totalCount = messageService.getSentTotalCount(name);
		List<MessageDTO> sendList = messageService.getSentMessageList(name, currentPage, pageSize);
		PagingHandler pagingHandler = new PagingHandler(totalCount, currentPage, pageSize);
		
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
		model.addAttribute("sendList", sendList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("ph", pagingHandler);
		
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
		String id = (String) session.getAttribute("sessionId");
		String name = memberService.getName(id);
		
		dto.setId(id);
		dto.setSend_name(name);
		messageService.insertMessage(dto);	
	}
		
}
