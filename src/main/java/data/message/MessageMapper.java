package data.message;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessageMapper {
	public List<MessageDTO> getReceivedMessageList(HashMap<String, Object> map); //받은 메세지 리스트
	public List<MessageDTO> getSentMessageList(HashMap<String, Object> map); //보낸 메세지 리스트
	public int getReceivedTotalCount(String recv_name);
	public int getSentTotalCount(String send_name);
	public MessageDTO getMessage(String num); // num에 대한 메세지 반환
	public void insertMessage(MessageDTO dto);
	public void updateReadCount(String name, String num);
}
