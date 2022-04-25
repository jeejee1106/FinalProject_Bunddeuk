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
	@Autowired
	ProjectListMapper listMapper;
	
	@PostMapping("/project_support/success")
	public String supportSuccess(SupportDTO dto, HttpSession session, int idx, int supportNum, int pstP, Model model) {
		String sessionId = (String)session.getAttribute("id");
		
		dto.setHp(supportService.getHp(sessionId));
		dto.setEmail(supportService.getEmail(sessionId));
		dto.setAddr(supportService.getAddr(sessionId));
		supportService.insertSupportData(dto);
		supportService.addSupporter(idx);
		supportService.addTotalAmount(pstP, idx);
		
		//랜덤으로 리스트 뽑아서 추천 프로젝트 출력
		List<ProjectDTO> alist=listMapper.allProjects();
		if(alist.size()>4) {
			List<ProjectDTO> recommendList = new ArrayList<ProjectDTO>();
			int [] randomNumber = new int[4];
			for(int i=0; i<4; i++) {
				randomNumber[i] = (int)(Math.random()*(alist.size()-1));
				for(int j=0; j<i; j++) {
					if(randomNumber[j] == randomNumber[i]) {
						i--;
						continue;
					}
				}
				recommendList.add(alist.get(randomNumber[i]));
			}
//			for(int i=0; i<4; i++) {
//				recommendList.add(alist.get(randomNumber[i]));
//			}
			model.addAttribute("recommendList",recommendList);
		}else {
			model.addAttribute("recommendList",alist);
		}
	      
		model.addAttribute("supportNum", supportNum+1);
		
		return "/project_detail/supportSuccess";
	}
}
