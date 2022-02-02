package data.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {
	@Autowired
	CommentMapper commentMapper;
	
	public void insertComment(CommentDTO commentDTO) {
		commentMapper.insertComment(commentDTO);
	}
	public int getMaxNum() {
		return commentMapper.getMaxNum();
	};
	public int changeHierarchy(int grp) {
		return commentMapper.changeHierarchy(grp);
	};
	
	public List<CommentDTO> getCommentList(int pnum, int order){
		List<CommentDTO> list = commentMapper.getCommentList(pnum, order);
		return list;
	}
	public void updateParent(String parent, String num) {
		commentMapper.updateParent(parent, num);
	}
	public void updateParentNum(int parent_num, int num) {
		commentMapper.updateParentNum(parent_num, num);
	}
	public void updateComment(String content, String num) {
		commentMapper.updateComment(content, num);
	}
	public String getParentContent(int num) {
		return commentMapper.getParentContent(num);
	}
	//글삭제
	public void deleteComment(int num) {
		commentMapper.deleteComment(num);
	}
	public void deleteBranchComment(int idx) {
		commentMapper.deleteBranchComment(idx);
	}
	public void deleteTemp(int num) {
		commentMapper.deleteTemp(num);
	}
	public int countGrp(int grp) {
		return commentMapper.countGrp(grp);
	}
	public int countTempdel(int grp) {
		return commentMapper.countTempdel(grp);
	}
	public void resetFix() {
		commentMapper.resetFix();
	}
	public void fixComment(int grp) {
		commentMapper.fixComment(grp);
	}
	public void cancelFix(int grp) {
		commentMapper.cancelFix(grp);
	}
	public int checkFix(int grp) {
		return commentMapper.checkFix(grp);
	}
	public int countComment(int pnum) {
		return commentMapper.countComment(pnum);
	}
}
