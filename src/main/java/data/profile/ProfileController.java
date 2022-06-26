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
import data.paging.PagingHandler;
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
	
	//내 프로필 페이지로 이동
	@GetMapping("/profile")
	public String myProfile(HttpSession session) {
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
	
	//작가의 프로필 페이지로 이동
	@PostMapping("/creator-profile")
	public String creatorProfile(HttpSession session, String id) {
		System.out.println(id);
		session.removeAttribute("url");
		String url = memberService.getUrl(id);
		session.setAttribute("url",url);
		
		System.out.println(url);
			return "redirect:profile/"+url;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////
	/**
	 * 
	 * 매핑이 어디에 쓰이는 지 모르겠다.
	 * 실제로 쓰이고 있는 매핑인지 알 수 없고, 쓰이고 있다면 어디에 쓰이는지 모르겠다.
	 * 댓글쪽인 것 같기도 하고... 일단 주석 처리 후 계속 진행 후
	 * 어느 부분인지 찾았을 때 다시 사용하기
	 * 
	 */
//	@PostMapping("/comment/profile")
//	public String moveProfile(Model model, String id) {
//		MemberDTO movedto = memberService.getMemberInfo(id);
//		model.addAttribute("id",id); //원섭
//		model.addAttribute("movedto", movedto);
//		
//		return "/profile/introduction";
//	}
//	
//	@PostMapping("/comment/sponsored")
//	public String moveToS(Model model, String id) {
//		MemberDTO movedto = memberService.getMemberInfo(id);
//		model.addAttribute("id",id); //원섭
//		model.addAttribute("movedto", movedto);
//		
//		return "/profile/sponsoredProject";
//	}
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	
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
		
		String creatingProjectCnt = profileService.getCreativeAuditCount("0", id);
		String reviewingProjectCnt = profileService.getCreativeAuditCount("1", id);
		String companionProjectCnt = profileService.getCreativeAuditCount("2", id);
		String approvalProjectCnt = profileService.getCreativeAuditCount("3", id); //이걸 이렇게 따로따로 가져오는 방법밖에는 없나??? 더 연구하기
		
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
		model.addAttribute("creativeList", creativeList);
		model.addAttribute("myTotalProjectCnt", creativeList.size());
		model.addAttribute("creatingProjectCnt", creatingProjectCnt);
		model.addAttribute("reviewingProjectCnt", reviewingProjectCnt);
		model.addAttribute("companionProjectCnt", companionProjectCnt);
		model.addAttribute("approvalProjectCnt", approvalProjectCnt);
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
	
	//올린 프로젝트 - 관리 디테일 페이지
	@GetMapping("/profile/{url}/created_management")
	public String getProject (@RequestParam String idx, @PathVariable String url, Model model) {
		ProjectDTO pdto = projectService.getData(idx);
		model.addAttribute("pdto", pdto);
		return "/profile/uploadedProjectModify";
	}
	
	//후원자 리스트
	@GetMapping("/profile/{url}/created_sponsorlist")
	public String sponsorList(Model model, String idx,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "10") int pageSize,
			@PathVariable String url) {
		
		ProjectDTO pdto = projectService.getData(idx);
		
		String name = pdto.getName();
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>" + name);
		int totalCount = profileService.getTotalSponsorCount(idx, name);
		PagingHandler pagingHandler = new PagingHandler(totalCount, currentPage, pageSize);
		List<SupportDetailDTO> sponsorList = profileService.getSponsorList(idx, name, currentPage, pageSize);
		
		model.addAttribute("pdto", pdto);
		model.addAttribute("sponsorList", sponsorList);
		model.addAttribute("ph", pagingHandler);
		model.addAttribute("currentPage", currentPage);

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