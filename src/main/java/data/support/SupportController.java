package data.support;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import data.project.ProjectDTO;
import data.project.ProjectListMapper;

@Controller
public class SupportController {

	@Autowired
	SupportService service;
	@Autowired
	ProjectListMapper listMapper;
	
	@PostMapping("/project_support/success")
	public ModelAndView supportSuccess(SupportDTO dto, HttpSession session, int idx, int supportNum, int pstP) {
		ModelAndView mview = new ModelAndView();
		String sessionId = (String)session.getAttribute("id");
		
		dto.setHp(service.getHp(sessionId));
		dto.setEmail(service.getEmail(sessionId));
		dto.setAddr(service.getAddr(sessionId));
		service.insertSupportData(dto);
		service.addSupporter(idx);
		//System.out.println(pstP);
		service.addTotalAmount(pstP, idx);
		
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
			}
			for(int i=0; i<4; i++) {
				recommendList.add(alist.get(randomNumber[i]));
			}
			mview.addObject("recommendList",recommendList);
		}else {
			mview.addObject("recommendList",alist);
		}
	      
		mview.addObject("supportNum", supportNum+1);
		
		mview.setViewName("/project_detail/supportSuccess");
		
		return mview;
	}
}
