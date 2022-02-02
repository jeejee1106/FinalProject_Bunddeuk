package data.message;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessageMapper {
	
	
	public List<MessageDTO> getReceivedMessageList(HashMap<String, Object> map); //받는 사람에 대한 리스트
	public List<MessageDTO> getSentMessageList(HashMap<String, Object> map); //보낸 사람에 대한 리스트
	public int getReceivedTotalCount(String recv_name);
	public int getSentTotalCount(String send_name);
	
	public MessageDTO getMessage(String num); // num에 대한 메세지 반환
	public void reply(MessageDTO dto); // 답장
	
	public void updateReadCount(String name, String num); //조회수 증가-0 안읽음 1이상 읽음
	

}
