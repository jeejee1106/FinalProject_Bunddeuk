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
		int start = (currentPage - 1) * perPage; // 각페이지에서 불러올 db 의 시작번호
		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
		int startPage = (currentPage - 1) / perBlock * perBlock + 1; // 각 블럭에 표시할 시작페이지
		int endPage = startPage + perBlock - 1; // 각 블럭에 표시할 마지막페이지
		
//		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
//		start = (currentPage - 1) * perPage;
//		startPage = (currentPage - 1) / perBlock * perBlock + 1;
//		endPage = startPage + perBlock - 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		List<MessageDTO> recvList = messageService.getReceivedList(name, start, perPage);
		MemberDTO dto = memberService.getAll(id);
		
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("recvList", recvList);
		model.addAttribute("count", recvList.size()); //얘 안쓰는 것 같은데, 차라리 totalCount를 없애고(그러면 sql도 따로 필요 없으니까) 얘를 쓰는 건 어떨까?
		
		return "/message/receivedMessageList";
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
		
		int totalCount = messageService.getSentTotalCount(name);
		
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
		
		List<MessageDTO> sendList = messageService.getSentMessageList(name, start, perPage);
		
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
