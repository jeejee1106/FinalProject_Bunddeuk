package data.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper {
	public void insertComment(CommentDTO CMDTO);
	public int getMaxNum();
	public List<CommentDTO> getCommentList(int pnum, int order);
	public int changeHierarchy(int grp);
	public void updateComment(String content, String num);
	public void updateParent(String parent, String num);
	public void updateParentNum(int parent_num, int num);
	public String getParentContent(int num);
	//댓글삭제
	public void deleteComment(int num);
	public void deleteBranchComment(int num);
	public void deleteTemp(int num);
	public int countGrp(int grp);
	public int countTempdel(int grp);
	
	//고정
	public void resetFix();
	public void fixComment(int grp);
	public void cancelFix(int grp);
	public int checkFix(int grp);
	
	//갯수
	public int countComment(int pnum);
}
