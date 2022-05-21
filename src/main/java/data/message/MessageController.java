package data.message;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import data.paging.PagingHandler;


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
		String name = memberService.getName(id);
		MemberDTO memberDto = memberService.getAll(id);
		
		int totalCount = messageService.getReceivedTotalCount(name);
		int perPage = 5; // 한페이지에 보여질 글의 갯수
		int totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1); // 총 페이지수
		int start = (currentPage - 1) * perPage; // 각페이지에서 불러올 db 의 시작번호
		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
		int startPage = (currentPage - 1) / perBlock * perBlock + 1; // 각 블럭에 표시할 시작페이지
		int endPage = startPage + perBlock - 1; // 각 블럭에 표시할 마지막페이지
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		List<MessageDTO> recvList = messageService.getReceivedList(name, start, perPage);
		
		model.addAttribute("dto", memberDto);
		model.addAttribute("name", name);
		model.addAttribute("totalCount", recvList.size());
		model.addAttribute("recvList", recvList);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", currentPage);
		
		return "/message/receivedMessageList";
	}
	
//	// 보낸 메세지 리스트
//	@GetMapping("/message/sentMessage")
//	public String sentList (@RequestParam(defaultValue = "1") int currentPage, HttpSession session, Model model) {
//		
//		String id = (String)session.getAttribute("id");
//		String name = memberService.getName(id);
//		MemberDTO dto = memberService.getAll(id);
//		
//		int totalCount = messageService.getSentTotalCount(name);
//		int perPage = 5; // 한페이지에 보여질 글의 갯수
//		int totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1); // 총 페이지수
//		int start = (currentPage - 1) * perPage; // 각페이지에서 불러올 db 의 시작번호
//		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
//		int startPage = (currentPage - 1) / perBlock * perBlock + 1; // 각 블럭에 표시할 시작페이지
//		int endPage = startPage + perBlock - 1; // 각 블럭에 표시할 마지막페이지
//		
//		if (endPage > totalPage) {
//			endPage = totalPage;
//		}
//		
//		List<MessageDTO> sendList = messageService.getSentMessageList(name, start, perPage);
//		
//		model.addAttribute("dto", dto);
//		model.addAttribute("name", name);
//		model.addAttribute("sendList", sendList);
//		model.addAttribute("count", sendList.size());
//		model.addAttribute("startPage", startPage);
//		model.addAttribute("endPage", endPage);
//		model.addAttribute("totalPage", totalPage);
//		model.addAttribute("currentPage", currentPage);
//		model.addAttribute("totalCount", totalCount);
//		
//		return "/message/sentMessageList";
//		
//	}
	
	// 보낸 메세지 리스트
		@GetMapping("/message/sentMessage")
		public String sentList (@RequestParam(defaultValue = "1") Integer currentPage, Integer pageSize, HttpSession session, Model model) {
			
			String id = (String)session.getAttribute("id");
			String name = memberService.getName(id);
			MemberDTO dto = memberService.getAll(id);
			int totalCount = messageService.getSentTotalCount(name);
			
			if(currentPage == null) currentPage = 1;
			if(pageSize == null) pageSize = 5;
			
			PagingHandler pagingHandler = new PagingHandler(totalCount, currentPage, pageSize);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("name", name);
			map.put("offset", (currentPage-1) * pageSize);
			map.put("pageSize", pageSize);
			
			List<MessageDTO> sendList = messageService.getSentMessageList(map);
			
			model.addAttribute("dto", dto);
			model.addAttribute("name", name);
			model.addAttribute("sendList", sendList);
			model.addAttribute("count", sendList.size());
			model.addAttribute("currentPage", currentPage);
//			model.addAttribute("totalCount", totalCount);
			model.addAttribute("ph", pagingHandler);
			System.out.println("pageSize : " + pageSize);
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
