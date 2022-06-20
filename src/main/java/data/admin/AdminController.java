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
	public ModelAndView projectList(
			@RequestParam(defaultValue = "1") int currentPage,
			HttpSession session
			) {
		
		ModelAndView mview = new ModelAndView();
		String id = (String) session.getAttribute("sessionId");
		MemberDTO dto = memberSerivce.getMemberInfo(id);
		
		int totalCount = adminService.getTotalCount();
		
		int perPage = 10; // 한페이지에 보여질 글의 갯수
		int totalPage; // 총 페이지수
		int start; // 각페이지에서 불러올 db 의 시작번호
		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
		int startPage; // 각 블럭에 표시할 시작페이지
		int endPage; // 각 블럭에 표시할 마지막페이지
		
		// 총 페이지 갯수 구하기
		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
		// 각 블럭의 시작페이지
		startPage = (currentPage - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		// 각 페이지에서 불러올 시작번호
		start = (currentPage - 1) * perPage;
		
		List<ProjectDTO> list = adminService.getProjectList(start, perPage);
		//System.out.println(list);
		String count = adminService.getAuditCount();
		
		mview.addObject("dto", dto);
		mview.addObject("list", list);
		mview.addObject("count", count);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		mview.addObject("currentPage", currentPage);
		mview.addObject("totalCount", totalCount);
		mview.setViewName("/admin/auditManagement");
		
		return mview;
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
//		int perPage = 10; // 한페이지에 보여질 글의 갯수
//		int totalPage; // 총 페이지수
//		int start; // 각페이지에서 불러올 db 의 시작번호
//		int perBlock = 5; // 몇개의 페이지번호씩 표현할것인가
//		int startPage; // 각 블럭에 표시할 시작페이지
//		int endPage; // 각 블럭에 표시할 마지막페이지
//		
//		// 총 페이지 갯수 구하기
//		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
//		// 각 블럭의 시작페이지
//		startPage = (currentPage - 1) / perBlock * perBlock + 1;
//		endPage = startPage + perBlock - 1;
//		if (endPage > totalPage)
//			endPage = totalPage;
//		// 각 페이지에서 불러올 시작번호
//		start = (currentPage - 1) * perPage;
		
		List<MemberDTO> mlist = adminService.getMemberList(currentPage, pageSize);
		
		model.addAttribute("id", id);
		model.addAttribute("dto", dto);
		model.addAttribute("mlist", mlist);
		model.addAttribute("ph", pagingHandler);
//		model.addAttribute("startPage", startPage);
//		model.addAttribute("endPage", endPage);
//		model.addAttribute("totalPage", totalPage);
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
