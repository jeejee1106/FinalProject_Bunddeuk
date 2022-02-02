package data.project;

import org.apache.ibatis.type.Alias;

@Alias("pstdto")
public class PresentDTO {
	
	private int num;
	private int idx;
	private String present_name;
	private String present_option;
	private String price;
	
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
}
