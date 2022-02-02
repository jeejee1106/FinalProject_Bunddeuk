package data.profile;

import org.apache.ibatis.type.Alias;

@Alias("sdetaildto")
public class SupportDetailDTO {
	
	private int num; // 후원번호
	private int idx; // 프로젝트 시퀀스
	private String id; // 나의 아이디
	private String email;
	private String addr;
	private String hp;
	private String present_name; // 선물이름
	private String present_option; // 선물옵션
	private String price; 
	private String support_date; // 후원한 날짜
	
	
	private String end_date; // 펀딩 마감일
	private String payment_method; // 결제방법
	private String payment_status; // 결제상태
	
//	프로젝트 조인시 
	private String name; // 창작자명
	private String category;
	private String title;
	private String thumbnail;
	private String total_amount;
	
	
	public String getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(String total_amount) {
		this.total_amount = total_amount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getPresent_name() {
		return present_name;
	}
	public void setPresent_name(String present_name) {
		this.present_name = present_name;
	}
	public String getPresent_option() {
		return present_option;
	}
	public void setPresent_option(String present_option) {
		this.present_option = present_option;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getSupport_date() {
		return support_date;
	}
	public void setSupport_date(String support_date) {
		this.support_date = support_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
	public String getPayment_status() {
		return payment_status;
	}
	public void setPayment_status(String payment_status) {
		this.payment_status = payment_status;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	
}
