package data.keyword;

import org.apache.ibatis.type.Alias;

@Alias("KDTO")
public class KeywordDTO {
	private int num;
	private String keyword;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}
