package data.support;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("sptdto")
public class SupportDTO {

	private int num;
	private int idx;
	private String id;
	private String email;
	private String addr;
	private String hp;
	private String present_name;
	private String present_option;
	private String price;
	private Date support_date;
	private Date end_date;
	private int payment_status;
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
	public Date getSupport_date() {
		return support_date;
	}
	public void setSupport_date(Date support_date) {
		this.support_date = support_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public int getPayment_status() {
		return payment_status;
	}
	public void setPayment_status(int payment_status) {
		this.payment_status = payment_status;
	}
	
}
