package data.message;

import org.apache.ibatis.type.Alias;

@Alias("msgdto")
public class MessageDTO {
	
	private String num;
	private String id;
	private String send_name;
	private String recv_name;
	private String send_time;
	private String content;
	private String read_chk;
	private String inquiry_type;
	
	public String getInquiry_type() {
		return inquiry_type;
	}
	public void setInquiry_type(String inquiry_type) {
		this.inquiry_type = inquiry_type;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSend_name() {
		return send_name;
	}
	public void setSend_name(String send_name) {
		this.send_name = send_name;
	}
	public String getRecv_name() {
		return recv_name;
	}
	public void setRecv_name(String recv_name) {
		this.recv_name = recv_name;
	}
	public String getSend_time() {
		return send_time;
	}
	public void setSend_time(String send_time) {
		this.send_time = send_time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRead_chk() {
		return read_chk;
	}
	public void setRead_chk(String read_chk) {
		this.read_chk = read_chk;
	}
	
	public MessageDTO(String num, String id, String send_name, String recv_name, String send_time, String content,
			String read_chk, String inquiry_type) {
		super();
		this.num = num;
		this.id = id;
		this.send_name = send_name;
		this.recv_name = recv_name;
		this.send_time = send_time;
		this.content = content;
		this.read_chk = read_chk;
		this.inquiry_type = inquiry_type;
	}
}
