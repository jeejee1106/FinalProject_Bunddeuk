package data.message;

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
import org.springframework.web.servlet.ModelAndView;

import data.member.MemberDTO;
import data.member.MemberMapper;
import data.member.MemberService;


@Controller
public class MessageController {
	
	@Autowired
	MessageService service;
	@Autowired
	MemberMapper memMapper;
	@Autowired
	MemberService memberService;
	
	// 받은 메세지 리스트
	@GetMapping("/message/receivedMessage")
	public ModelAndView receivedList (
			HttpSession session,
			@RequestParam(defaultValue = "1") int currentPage
			) {
		
		ModelAndView mview = new ModelAndView();
		
		String id = (String)session.getAttribute("id");
		String name = memMapper.getName(id);
		//System.out.println("나의 아이디 "+id);
		//System.out.println("나의 name "+my_name);
		
		int totalCount = service.getReceivedTotalCount(name);
		
		int perPage = 5; // 한페이지에 보여질 글의 갯수
		int totalPage; // 총 페이지수
		int start; // 각페이지에서 불러올 db 의 시작번호
		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
		int startPage; // 각 블럭에 표시할 시작페이지
		int endPage; // 각 블럭에 표시할 마지막페이지
		
		// 총 페이지 갯수 구하기
		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
		// 각 블럭의 시작페이지
		startPage = (currentPage - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		// 각 페이지에서 불러올 시작번호
		start = (currentPage - 1) * perPage;
		
		List<MessageDTO> recvList = service.getReceivedList(name, start, perPage);
		//System.out.println(recvList);
		
		MemberDTO dto = memberService.getAll(id);
		//System.out.println("받은"+totalCount);
		mview.addObject("dto", dto);
		
		mview.addObject("name", name);
		mview.addObject("totalCount", totalCount);
		mview.addObject("recvList", recvList);
		mview.addObject("count", recvList.size());
		mview.setViewName("/message/receivedMessageList");
		
		//System.out.println(receivedList);
		return mview;
		
	}
	
	// 보낸 메세지 리스트
	@GetMapping("/message/sentMessage")
	public ModelAndView sentList (
			@RequestParam(defaultValue = "1") int currentPage,
			HttpSession session
			) {
		
		ModelAndView mview = new ModelAndView();
		String id = (String)session.getAttribute("id");
		String name = memberService.getName(id);
		//System.out.println("상대방이름"+otherParty_name);
		//System.out.println("리스트"+sendList);
		MemberDTO dto = memberService.getAll(id);
		
		int totalCount = service.getSentTotalCount(name);
		
		int perPage = 5; // 한페이지에 보여질 글의 갯수
		int totalPage; // 총 페이지수
		int start; // 각페이지에서 불러올 db 의 시작번호
		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
		int startPage; // 각 블럭에 표시할 시작페이지
		int endPage; // 각 블럭에 표시할 마지막페이지
		
		// 총 페이지 갯수 구하기
		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
		// 각 블럭의 시작페이지
		startPage = (currentPage - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		// 각 페이지에서 불러올 시작번호
		start = (currentPage - 1) * perPage;
		
		List<MessageDTO> sendList = service.getSentMessageList(name, start, perPage);
		
		//System.out.println("보낸"+totalCount);
		
		mview.addObject("dto", dto);
		mview.addObject("name", name);
		mview.addObject("sendList", sendList);
		mview.addObject("count", sendList.size());
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		mview.addObject("currentPage", currentPage);
		mview.addObject("totalCount", totalCount);
		mview.setViewName("/message/sentMessageList");
		
		//service.updateReadCount(name, num);
		//System.out.println(receivedList);
		return mview;
		
	}
	
	// 메세지 가져오기
	@GetMapping("/message/messagedata")
	@ResponseBody
	public MessageDTO data(String num, HttpSession session) {
		
		String id = (String) session.getAttribute("id");
		String name = memberService.getName(id);
		
		service.updateReadCount(name, num);
		return service.getMessage(num);
	}
	
	// 답장하기 insert
	@PostMapping("/message/messageReply")
	@ResponseBody
	public void reply(@ModelAttribute MessageDTO dto, HttpSession session) {
		
		String id = (String) session.getAttribute("id");
		String name = memMapper.getName(id);
		
		//System.out.println("name: "+name+", id: "+id);
		
		dto.setId(id);
		dto.setSend_name(name);
		
		service.reply(dto);	
		
	}
		
}
