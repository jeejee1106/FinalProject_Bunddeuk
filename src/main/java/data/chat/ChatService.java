package data.chat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatService {
	@Autowired
	ChatMapper chatMapper;
	
	public void sendMessage(ChatDTO dto) {
		chatMapper.sendMessage(dto);
	}
	public List<ChatDTO>  getRoomContentList(ChatDTO dto){
		List<ChatDTO> list = chatMapper.getRoomContentList(dto);
		return list;
	}
	public int getMaxRoom() {
		return chatMapper.getMaxRoom();
	}
	public String getRoomNumber(ChatDTO dto) {
		
		String room = chatMapper.getRoomNumber(dto);
		System.out.println("서비스 방"+room);
		
		//new room
		if(room==null) {
			int temp = chatMapper.getMaxRoom()+1;
			room = String.valueOf(temp);
		}
		
		System.out.println("서비스 방2"+room);
		return room;
	}
	
	public List<ChatDTO> getChatList(String id){
		List<ChatDTO> list = chatMapper.getChatList(id);
		return list;
	}
	public int countUnreadMessage(ChatDTO dto) {
		int unread = chatMapper.countUnreadMessage(dto);
		return unread;
	}
	
	public void changeMessageReadCheck(ChatDTO dto) {
		chatMapper.changeMessageReadCheck(dto);
	}
	
	public void changeMessageReadTime(ChatDTO dto) {
		chatMapper.changeMessageReadTime(dto);
	}
	
	public String getOtherProfile(ChatDTO dto) {
		return chatMapper.getOtherProfile(dto);
	}
	
	public int countExitId(String room) {
		return chatMapper.countExitId(room);
	}
	
	public String getExitId(String room) {
		return chatMapper.getExitId(room);
	}
	
	public void updateExitId(String room, String exit_id) {
		chatMapper.updateExitId(room, exit_id);
	}
	
	public void deleteRoom(String room) {
		chatMapper.deleteRoom(room);
	}
}
