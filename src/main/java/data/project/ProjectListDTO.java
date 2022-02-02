package data.project;


import org.apache.ibatis.type.Alias;

@Alias("PLDTO")
public class ProjectListDTO {
	private String search = "no";
	private String state = "no";
	private String category = "no";
	private String percent = "no";
	
	
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPercent() {
		return percent;
	}
	public void setPercent(String percent) {
		this.percent = percent;
	}
	
}
