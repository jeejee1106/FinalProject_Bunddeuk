package data.paging;

public class PagingDTO {
	
	private int totalCount;
	private int perPage; // 한페이지에 보여질 글의 갯수
	private int totalPage; // 총 페이지수
	private int start; // 각페이지에서 불러올 db 의 시작번호
	private int perBlock; // 몇개의 페이지번호씩 표현할것인가
	private int startPag; // 각 블럭에 표시할 시작페이지
	private int endPage; // 각 블럭에 표시할 마지막페이지
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getPerBlock() {
		return perBlock;
	}
	public void setPerBlock(int perBlock) {
		this.perBlock = perBlock;
	}
	public int getStartPag() {
		return startPag;
	}
	public void setStartPag(int startPag) {
		this.startPag = startPag;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
}
