package data.message;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.paging.PagingHandler;

@Service
public class MessageService {
	
	@Autowired
	MessageMapper mapper;
	
	public int getReceivedTotalCount(String recv_name) {
		return mapper.getReceivedTotalCount(recv_name);
	}
	
	public int getSentTotalCount(String send_name) {
		return mapper.getSentTotalCount(send_name);
	}
	
	public List<MessageDTO> getReceivedList(String recv_name, int start, int perpage) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("recv_name", recv_name);
		map.put("start", start);
		map.put("perpage", perpage);
		return mapper.getReceivedMessageList(map);
	}
	
	public List<MessageDTO> getSentMessageList(HashMap<String, Object> map) {
		return mapper.getSentMessageList(map);
	}
	
	public MessageDTO getMessage(String num) {
		return mapper.getMessage(num);
	}
	
	public void insertMessage(MessageDTO dto) {
		mapper.insertMessage(dto);
	}
	
	public void updateReadCount(String name, String num) {
		mapper.updateReadCount(name, num);
	}
	
	
	
	
}