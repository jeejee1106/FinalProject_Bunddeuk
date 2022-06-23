package data.admin;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.member.MemberDTO;
import data.member.MemberService;
import data.paging.PagingHandler;
import data.profile.ProfileService;
import data.project.ProjectDTO;


@Controller
public class AdminController {

	@Autowired
	AdminService adminService;
	@Autowired
	MemberService memberSerivce;
	@Autowired
	ProfileService profileSerivce;
	
	@GetMapping("/admin/project_management")
	public String projectList(HttpSession session, Model model,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "10") int pageSize) {
		
		String id = (String) session.getAttribute("sessionId");
		MemberDTO dto = memberSerivce.getMemberInfo(id);
		
		int totalCount = adminService.getTotalCount();
		
		List<ProjectDTO> list = adminService.getProjectList(currentPage, pageSize);
		PagingHandler pagingHandler = new PagingHandler(totalCount, currentPage, pageSize);
		String waitingProject = adminService.getAuditCount();
		
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		model.addAttribute("waitingProject", waitingProject);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("ph", pagingHandler);
		
		return "/admin/auditManagement";
	}
	
	@GetMapping("/admin/project_aprvl")
	@ResponseBody
	public void updateAprvl(@ModelAttribute ProjectDTO pdto) {
		adminService.updateAuditAprvl(pdto);
	}
	
	@GetMapping("/admin/project_refusal")
	@ResponseBody
	public void updateRefusal(@ModelAttribute ProjectDTO pdto) {
		adminService.updateAuditRefusal(pdto);
	}
	
	@GetMapping("/admin/audit_detail")
	@ResponseBody
	public String auditDetail (
			@RequestParam String idx,
			@RequestParam (defaultValue = "1") int currentPage, Model model) {
		
		ProjectDTO pdto = profileSerivce.getProject(idx);
		
		model.addAttribute("pdto", pdto);
		model.addAttribute("currentPage", currentPage);
		
		return "/admin/auditDetail";
	}
	
	@GetMapping("/admin/member_management")
	public String memberList(HttpSession session, Model model,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "10") int pageSize) {
		
		String id = (String) session.getAttribute("sessionId");
		MemberDTO dto = memberSerivce.getMemberInfo(id);
		
		int totalCount = adminService.getTotalMemberCount();
		PagingHandler pagingHandler = new PagingHandler(totalCount, currentPage, pageSize);
		List<MemberDTO> mlist = adminService.getMemberList(currentPage, pageSize);
		
		model.addAttribute("id", id);
		model.addAttribute("dto", dto);
		model.addAttribute("mlist", mlist);
		model.addAttribute("ph", pagingHandler);
		model.addAttribute("currentPage", currentPage);
		return "/admin/memberList";
	}
	
	@GetMapping("/admin/member_info")
	public String memberInfo(
			@RequestParam String id,
			@RequestParam (defaultValue = "1") int currentPage, Model model) {
		
		MemberDTO mdto = memberSerivce.getMemberInfo(id);
		model.addAttribute("mdto", mdto);
		model.addAttribute("currentPage", currentPage);
		return "/admin/memberInfoDetail";
	}
	
	@GetMapping("/admin/member_info_delete")
	public String deleteMember(String num) {
		adminService.deleteMember(num);
		return "/admin/memberList";
	}
}
