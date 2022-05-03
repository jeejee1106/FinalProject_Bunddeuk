package data.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class ProjectListController {
	
	@Autowired
	ProjectListService projectListService;
	
	@GetMapping("/")
	public String mainList(Model model) {
		List<ProjectDTO> allProjectList = projectListService.getAllProjects();
		List<ProjectDTO> popularProjectList = projectListService.getPopularProjects();
		List<ProjectDTO> closingProjectList = projectListService.getClosingProjects();
		List<ProjectDTO> newProjectList = projectListService.getNewProjects();
		model.addAttribute("allProjectList",allProjectList);
		model.addAttribute("popularProjectList",popularProjectList);
		model.addAttribute("closingProjectList",closingProjectList);
		model.addAttribute("newProjectList",newProjectList);
		return "/layout/main";
	}
	
	@GetMapping("/listchul/listChul")
	public String projectList (Model model, String category,String state,String percent,String search) {
		System.out.println("카테고리:" + category + ", 상태:" + state + ", 퍼센트:" + percent +", 검색:" + search + "  listChul태스트용");
		if(search == null) {
			search = "no";
		}
		int totalCount=projectListService.getTotalCount();
		List<ProjectDTO> list= projectListService.getConditionProjects(category,state,percent,search);
		model.addAttribute("list",list);
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("category",category);
		model.addAttribute("state",state);
		model.addAttribute("search",search);
		return "/listchul/listChul";
	}
	
	@GetMapping("/layout/teamProfile")
	public String teamProfile() {
		return "/layout/teamProfile";
	}
	
	@ResponseBody
	@GetMapping("/listchul/listAll")
	public List<ProjectDTO> alist(String category,String state,String percent, String search)
	{
		if(search.equals("")) {
			search = "no";
		}
		//System.out.println("카테고리:" + category + ", 상태:" + state + ", 퍼센트:" + percent +", 검색:" + search + "  listAll태스트용");
		return projectListService.getConditionProjects(category,state,percent,search);
	}

}
