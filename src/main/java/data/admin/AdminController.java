package data.admin;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.member.MemberDTO;
import data.member.MemberService;
import data.profile.ProfileService;
import data.project.ProjectDTO;


@Controller
public class AdminController {

	@Autowired
	AdminService service;
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
		String id = (String) session.getAttribute("id");
		MemberDTO dto = memberSerivce.getAll(id);
		
		int totalCount = service.getTotalCount();
		
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
		
		List<ProjectDTO> list = service.getProjectList(start, perPage);
		//System.out.println(list);
		String count = service.getAuditCount();
		
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
		
		service.updateAuditAprvl(pdto);
	}
	
	@GetMapping("/admin/project_refusal")
	@ResponseBody
	public void updateRefusal(@ModelAttribute ProjectDTO pdto) {
		
		service.updateAuditRefusal(pdto);
	}
	
	@GetMapping("/admin/audit_detail")
	@ResponseBody
	public ModelAndView auditDetail (
			@RequestParam String idx,
			@RequestParam (defaultValue = "1") int currentPage) {
		
		ModelAndView mview = new ModelAndView();
		ProjectDTO pdto = profileSerivce.getProject(idx);
		
		mview.addObject("pdto", pdto);
		mview.addObject("currentPage", currentPage);
		mview.setViewName("/admin/auditDetail");
		
		return mview;
	}
	
	@GetMapping("/admin/member_management")
	public ModelAndView memberList(
			@RequestParam(defaultValue = "1") int currentPage,
			HttpSession session
			) {
		
		String id = (String) session.getAttribute("id");
		MemberDTO dto = memberSerivce.getAll(id);
		
		int totalCount = service.getTotalMemberCount();
		
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
		
		ModelAndView mview = new ModelAndView();
		List<MemberDTO> mlist = service.getMemberList(start, perPage);
		
		mview.addObject("id", id);
		mview.addObject("dto", dto);
		mview.addObject("totalCount", totalCount);
		mview.addObject("mlist", mlist);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		mview.addObject("currentPage", currentPage);
		mview.setViewName("/admin/memberList");
		return mview;
	}
	
	@GetMapping("/admin/member_info")
	public ModelAndView memberInfo(
			@RequestParam String id,
			@RequestParam (defaultValue = "1") int currentPage
			) {
		
		ModelAndView mview = new ModelAndView();
		MemberDTO mdto = memberSerivce.getAll(id);
		System.out.println(id);
		mview.addObject("mdto", mdto);
		mview.addObject("currentPage", currentPage);
		mview.setViewName("/admin/memberInfoDetail");
		return mview;
	}
	
	@GetMapping("/admin/member_info_delete")
	public String deleteMember(String num) {
		
		service.deleteMember(num);
		
		return "/admin/memberList";
	}
	
	
}
