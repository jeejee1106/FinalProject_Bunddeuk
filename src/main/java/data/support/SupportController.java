package data.support;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import data.project.ProjectDTO;
import data.project.ProjectListMapper;

@Controller
public class SupportController {

	@Autowired
	SupportService supportService;
	
	@PostMapping("/project_support/success")
	public String supportSuccess(SupportDTO dto, HttpSession session, int idx, int supportNum, int pstP, Model model) {
		String sessionId = (String)session.getAttribute("id");
		
		dto.setHp(supportService.getHp(sessionId));
		dto.setEmail(supportService.getEmail(sessionId));
		dto.setAddr(supportService.getAddr(sessionId));
		List<ProjectDTO> recommendList = supportService.insertSupportData(dto);
		supportService.addSupporter(idx);
		supportService.addTotalAmount(pstP, idx);
		
		model.addAttribute("recommendList", recommendList);
		model.addAttribute("supportNum", supportNum+1);
		
		return "/project_detail/supportSuccess";
	}
}
