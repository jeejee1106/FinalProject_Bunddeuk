package data.chat;

import org.apache.ibatis.type.Alias;


@Alias("CDTO")
public class ChatDTO {
	private String num;
	// 방번호
	private int room;
	// 발송자
	private String send_id;
	// 수신자
	private String recv_id;
	// 보낸시간
	private String send_time;
	// 읽은시간
	private String read_time;
	// 내용
	private String content;
	// 읽었는지 확인
	private String read_check;
	// 현재 사용자의 메세지 상대 id저장
	private String other_id;
	// 현재 사용자의 메세지 상대 profile저장
	private String photo;	
	// 현재 사용자 id
	private String id;	
	// 안읽은 메세지 갯수 
	private int unread;
	// 방을 나간 회원 아이디
	private String exit_id;
	// 방을 나간 회원수
	private int exit_count;
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	public String getRecv_id() {
		return recv_id;
	}
	public void setRecv_id(String recv_id) {
		this.recv_id = recv_id;
	}
	public String getSend_time() {
		return send_time;
	}
	public void setSend_time(String send_time) {
		this.send_time = send_time;
	}
	public String getRead_time() {
		return read_time;
	}
	public void setRead_time(String read_time) {
		this.read_time = read_time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRead_check() {
		return read_check;
	}
	public void setRead_check(String read_check) {
		this.read_check = read_check;
	}
	public String getOther_id() {
		return other_id;
	}
	public void setOther_id(String other_id) {
		this.other_id = other_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getUnread() {
		return unread;
	}
	public void setUnread(int unread) {
		this.unread = unread;
	}
	public String getExit_id() {
		return exit_id;
	}
	public void setExit_id(String exit_id) {
		this.exit_id = exit_id;
	}
	public int getExit_count() {
		return exit_count;
	}
	public void setExit_count(int exit_count) {
		this.exit_count = exit_count;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
}
