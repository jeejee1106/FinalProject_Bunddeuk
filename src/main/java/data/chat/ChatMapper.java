package data.chat;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ChatMapper {
	List<ChatDTO> getChatList(String id);
	List<ChatDTO> getRoomContentList(ChatDTO dto);
	void sendMessage(ChatDTO dto);
	String getRoomNumber(ChatDTO dto);
	int getMaxRoom();
	int countUnreadMessage(ChatDTO dto);
	void changeMessageReadCheck(ChatDTO dto);
	void changeMessageReadTime(ChatDTO dto);
	String getOtherProfile(ChatDTO dto);

	//exit chat room
	int countExitId(String room);
	void updateExitId(String room, String exit_id);
	void deleteRoom(String room);
	String getExitId(String room);
}
