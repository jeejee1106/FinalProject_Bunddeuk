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
	public void insertMessage(MessageDTO dto); // 답장 //민지 - 이게 답장이라고...? 보낸 메세지 전부를 말하는거 아닌가..?
	public void updateReadCount(String name, String num); //조회수 증가-0 안읽음 1이상 읽음 //민지 - 읽었으면 바로 1로 바꿔주면 되는거 아닌가? 계속 1씩 증가시키는 것이 아닌!
	

}
