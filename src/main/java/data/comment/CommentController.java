package data.comment;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import data.member.MemberService;


@Controller
public class CommentController {
	@Autowired
	CommentService commentService;
	@Autowired
	MemberService memberService;
	
	@ResponseBody
	@PostMapping("/comment/insert")
	public void insert(CommentDTO commentDTO) {
		commentDTO.setGrp(commentService.getMaxNum()+1);
		commentService.insertComment(commentDTO);
	}
	
	@ResponseBody
	@PostMapping("/comment/reply")
	public void reply(CommentDTO commentDTO) {
		int fixCheck = commentService.checkFix(commentDTO.getGrp());
		/*
		 * System.out.println("fixchekc"+fixCheck);
		 * System.out.println("grph넘버"+commentDTO.getGrph());
		 */
		if (commentDTO.getGrph() == 0) {
			commentDTO.setParent("no");
		}
		int maxGrph = commentService.changeHierarchy(commentDTO.getGrp());
		commentDTO.setGrph(maxGrph+1);
		if (commentDTO.getGrps() == 0) {
			commentDTO.setGrps(commentDTO.getGrps()+1);
		}
		if (fixCheck > 0) {
			commentDTO.setFix(1);
		}
		commentService.insertComment(commentDTO);
		int num = commentService.getMaxNum();
		commentService.updateParent(commentDTO.getParent(), String.valueOf(num));
		commentService.updateParentNum(commentDTO.getParent_num(), num);
	}
	
	@ResponseBody
	@GetMapping("/comment/list")
	public List<CommentDTO> getCommentList(int pnum, int order) {
		List<CommentDTO> list = commentService.getCommentList(pnum, order);
		return list;
	}
	@ResponseBody
	@PostMapping("/comment/delete")
	public void delete(int num, int grp, int grph, int tempdel, HttpSession session) {
		/* System.out.println("num"+num+"grp"+grp+"grph"+grph+"tempDel"+tempdel); */
		int grpCount = commentService.countGrp(grp);
		if(grph == 0) {
			if(grpCount == 1){
				commentService.deleteBranchComment(grp);
			}
			if(tempdel == 0) {
				commentService.deleteTemp(num);
			}
		}else {
			commentService.deleteComment(num);
			grpCount = commentService.countGrp(grp);
			tempdel = commentService.countTempdel(grp);
			/* System.out.println(tempdel+"tempdel값"); */
			if(grpCount == 1 && tempdel == 1){
				commentService.deleteBranchComment(grp);
			}
		}
	}
	@ResponseBody
	@PostMapping("/comment/update")
	public void delete(String num, String comment) {
		commentService.updateComment(comment, num);
	}
	
	@ResponseBody
	@PostMapping("/comment/fix")
	public void fix(int grp) {
		commentService.resetFix();
		commentService.fixComment(grp);
	}
	@ResponseBody
	@PostMapping("/comment/cancelFix")
	public void cancelFix(int grp) {
		commentService.cancelFix(grp);
	}
	@ResponseBody
	@PostMapping("/comment/getComment")
	public String getComment(int num) {
		return commentService.getParentContent(num);
	}
	@ResponseBody
	@PostMapping("/comment/countComment")
	public int countComment(int pnum) {
		return commentService.countComment(pnum);
	}
	
}
