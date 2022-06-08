package data.profile;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.member.MemberDTO;
import data.member.MemberMapper;
import data.member.MemberService;
import data.project.DetailService;
import data.project.ProjectDTO;
import data.project.ProjectMapper;
import data.project.ProjectService;
import data.support.SupportDTO;
import data.support.SupportService;

@Controller
public class ProfileController {
	
	@Autowired
	ProfileService profileService;
	@Autowired
	MemberService memberService;
	@Autowired
	ProjectService projectService;
	@Autowired
	DetailService detailService;
	
	@PostMapping("/comment/profile")
	public String moveProfile(Model model, String id) {
		MemberDTO movedto = memberService.getMemberInfo(id);
		model.addAttribute("id",id); //원섭
		model.addAttribute("movedto", movedto);
		
		return "/profile/introduction";
	}
	
	@GetMapping("/profile")
	public String moveProfile2(HttpSession session) {
		String id = (String)session.getAttribute("sessionId");
		String loginok = (String)session.getAttribute("loginok");
		session.removeAttribute("url");
		String url = memberService.getUrl(id);
		session.setAttribute("url",url);
		
		if(loginok == null) {
			return "redirect:/login/main";
		} else {
			return "redirect:profile/"+url;
		}
	}
	
	@PostMapping("/profile2")
	public String moveProfile3(HttpSession session, String id) {
		System.out.println(id);
		session.removeAttribute("url");
		String url = memberService.getUrl(id);
		session.setAttribute("url",url);
		
		System.out.println(url);
			return "redirect:profile/"+url;
	}
	
	
	@PostMapping("/comment/sponsored")
	public String moveToS(Model model, String id) {
		MemberDTO movedto = memberService.getMemberInfo(id);
		model.addAttribute("id",id); //원섭
		model.addAttribute("movedto", movedto);
		
		return "/profile/sponsoredProject";
	}
	
	//소개
	@GetMapping("/profile/{url}")
	public String introduction (Model model, @PathVariable String url) {
			String id = memberService.getIdUrl(url);
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("url", url);
			MemberDTO dto = memberService.getAllProfile(map);
			model.addAttribute("id",id);
			model.addAttribute("dto", dto);
			
			return "/profile/introduction";
	}

	//후원한 프로젝트
	@GetMapping("/profile/{url}/backed")
	public String sponsoredList (HttpSession session, Model model, @PathVariable String url) {
		
		String id = memberService.getIdUrl(url);
		String name = memberService.getName(id);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("url", url);
		MemberDTO dto = memberService.getAllProfile(map);
		
		List<SupportDetailDTO> supportLsit = profileService.getSupportProject(id);
		
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
		model.addAttribute("supportLsit", supportLsit);
		model.addAttribute("count", supportLsit.size());
		
		return "/profile/sponsoredProject";
	}
	//후원한 성공 디테일
	@GetMapping("/profile/{url}/support_success")
	public String sponsoredSuccessDetail (@RequestParam String num, @PathVariable String url, Model model) {
		String id = memberService.getIdUrl(url);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("url", url);
		MemberDTO dto = memberService.getAllProfile(map);
		model.addAttribute("dto", dto);
		
		SupportDetailDTO sdto = profileService.getSupportData(num);
		model.addAttribute("sdto", sdto);
		
		return "/profile/sponsoeredDetail";
	}
	
	//후원한 프로젝트 삭제
	@ResponseBody
	@GetMapping("/profile/{url}/support_cancel")
	public void supportCancel(@RequestParam String num, @PathVariable String url) {
		profileService.minusTotalAmountNumberPeople(num);
		profileService.deleteSupport(num);
	}
	
	//내가 올린 프로젝트
	@GetMapping("/profile/{url}/created")
	public String uploadeList (HttpSession session, @RequestParam HashMap<String, String> map, @PathVariable String url, Model model) {
		
		String id = memberService.getIdUrl(url);
		System.out.println("아이디 "+id);
		HashMap<String, String> map1 = new HashMap<String, String>();
		map1.put("id", id);
		map1.put("url", url);
		MemberDTO dto = memberService.getAllProfile(map1);
		
		String name = memberService.getName(id);
		
		List<ProjectDTO> creativeList = profileService.getCreativeProject(id);
		System.out.println("창작한 리스트: "+creativeList);
		
		map.put("write", "0");
		map.put("audit", "1");
		map.put("companion", "2");
		map.put("approval", "3");
		
		String write = (String) map.get("write");
		String audit = (String) map.get("audit");
		String companion = (String) map.get("companion");
		String approval = (String) map.get("approval");
		String write_count = profileService.getCreativeAuditCount(write, id);
		String audit_count = profileService.getCreativeAuditCount(audit, id);
		String companion_count = profileService.getCreativeAuditCount(companion, id);
		String approval_count = profileService.getCreativeAuditCount(approval, id);
		
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
		model.addAttribute("creativeList", creativeList);
		model.addAttribute("creativeCont", creativeList.size());
		model.addAttribute("write_count", write_count);
		model.addAttribute("audit_count", audit_count);
		model.addAttribute("companion_count", companion_count);
		model.addAttribute("approval_count", approval_count);
		return "/profile/uploadedProject";
	}
	
	
	//내가 올린 프로젝트 삭제 -사진삭제 추가하기
	@GetMapping("/profile/{url}/created_delete")
	@ResponseBody
	public void delete(@RequestParam String idx, HttpSession session,@PathVariable String url) {
		// 실제 업로드 폴더의 경로
		String path = session.getServletContext().getRealPath("/thumbnail_image");

		// 업로드된 파일명
		ProjectDTO pdto = projectService.getData(idx);
		String thumbnail = pdto.getThumbnail();

		// file 객체 생성
		File file = new File(path +"/"+ thumbnail);
		
		// 파일 삭제
		file.delete();
		
		profileService.deleteCreativeProject(idx);
	}
	
	//올린 프로젝트 관리 디테일 페이지
	@GetMapping("/profile/{url}/created_management")
	public String getProject (@RequestParam String idx, @PathVariable String url, Model model) {
		ProjectDTO pdto = projectService.getData(idx);
		model.addAttribute("pdto", pdto);
		return "/profile/uploadedProjectModify";
	}
	
	//후원자 리스트
	@GetMapping("/profile/{url}/created_sponsorlist")
	public String sponsorList(
			@RequestParam(defaultValue = "1") int currentPage, String idx,
			@PathVariable String url, Model model) {
		
		ProjectDTO pdto = projectService.getData(idx);
		
		String name = pdto.getName();
		int totalCount = profileService.getTotalSponsorCount(idx, name);
		
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
		
		List<SupportDetailDTO> sponsorList = profileService.getSponsorList(idx, name, start, perPage);
		
		model.addAttribute("pdto", pdto);
		model.addAttribute("sponsorList", sponsorList);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalCount", totalCount);

		return "/profile/sponsorMemberList";
	}
	
	//후원자 디테일
	@GetMapping("/profile/created_sponsorDetail")
	public String sponsorDetail(
			@RequestParam (defaultValue = "1") int currentPage,
			String num, Model model) {
		
		SupportDetailDTO dto = profileService.getSponsorMemberData(num);
		
		model.addAttribute("dto", dto);
		model.addAttribute("currentPage", currentPage);
		
		return "/profile/sponsorMemberDetail";
	}

	//관심있는 프로젝트
	@GetMapping("/profile/{url}/liked")
	public String interestList (HttpSession session, Model model, String idx,@PathVariable String url) {
		
		String id = memberService.getIdUrl(url);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("url", url);
		MemberDTO dto = memberService.getAllProfile(map);
		
		String name = memberService.getName(id);
		
		List<LikedDTO> likeList = profileService.getLikedProject(id);
		ProjectDTO pdto = projectService.getData(idx);
		
		model.addAttribute("likeList", likeList);
		model.addAttribute("likecount", likeList.size());
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);

		return "/profile/projectInterest";
	}
	
	//관심 프로젝트 삭제
	@GetMapping("/profile/{url}/liked_delete")
	@ResponseBody
	public void deleteLiked (@RequestParam String num, @PathVariable String url) {
		profileService.deleteLikedProject(num);
	}
	
}