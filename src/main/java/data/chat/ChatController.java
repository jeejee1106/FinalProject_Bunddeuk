package data.chat;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import data.member.MemberDTO;
import data.member.MemberMapper;


@Controller
public class ChatController {
	@Autowired
	ChatService chatService;
	@Autowired
	MemberMapper memberMapper;
	
	@PostMapping("/chat/personalChat")
	public String openPersonalChat(Model model, String id) {
		
		/* System.out.println(id); */
		MemberDTO dto = memberMapper.getAll(id);
		model.addAttribute("dto", dto);
		return "/chat/chat/personalChat";
	}
	
	
	@GetMapping("/chat/list")
	public String getChatList(Model model, HttpSession session) {
		List<ChatDTO> list = chatService.getChatList((String)session.getAttribute("id"));
		for(ChatDTO dto:list) {
			dto.setId((String)session.getAttribute("id"));
			dto.setPhoto(chatService.getOtherProfile(dto));
			dto.setUnread(chatService.countUnreadMessage(dto));
			/* System.out.println(dto.getPhoto()); */
		}
		
		
		model.addAttribute("list",list);
		
		System.out.println(list.size()+"리스트사이즈");
		return "/chat/chat/message";
	}

	@ResponseBody
	@PostMapping("/chat/chatList")
	public List<ChatDTO> list(String send_id, int room) {
		ChatDTO dto = new ChatDTO();
		dto.setId(send_id);
		dto.setSend_id(send_id);
		dto.setRoom(room);
		chatService.changeMessageReadTime(dto);
		chatService.changeMessageReadCheck(dto);
		List<ChatDTO> list = chatService.getRoomContentList(dto);
		return list;
	}
	@ResponseBody
	@PostMapping("/chat/read")
	public void readMessage(String send_id, int room) {
		System.out.println("읽음처리"+send_id+","+room);
		ChatDTO dto = new ChatDTO();
		
		dto.setId(send_id);
		dto.setRoom(room);
		chatService.changeMessageReadTime(dto);
		chatService.changeMessageReadCheck(dto);
	}
	
	@ResponseBody
	@PostMapping("/chat/getRoomNumber")
	public String getRoomNumber(String send_id, String recv_id) {
		ChatDTO dto = new ChatDTO();
		dto.setSend_id(send_id);
		dto.setRecv_id(recv_id);
		String room = chatService.getRoomNumber(dto);
		return room;
	}
	
	@ResponseBody
	@PostMapping("/chat/send")
	public int sendMessage(String send_id, String recv_id, String content, String room) {
		ChatDTO dto = new ChatDTO();
		int roomNumber = Integer.parseInt(room);
		dto.setRoom(roomNumber);
		dto.setSend_id(send_id);
		dto.setRecv_id(recv_id);
		dto.setContent(content);
		chatService.sendMessage(dto);
		return 1;
	}
	
	@ResponseBody
	@PostMapping("/chat/exit")
	public void exitRoom(String room, String exit_id) {
		int num = chatService.countExitId(room);
		if(num == 0) {
			chatService.updateExitId(room, exit_id);
		}else {
			chatService.deleteRoom(room);
		}
	}

}
