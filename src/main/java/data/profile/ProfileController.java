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
//@RequestMapping("/profile")
public class ProfileController {
	
	@Autowired
	ProfileService profileService;
	@Autowired
	MemberService memberService;
	@Autowired
	ProjectService projectService;
	@Autowired
	DetailService detailService;
	/*
	 * @Value("${file.upload.image}") String path;
	 */
	
	String profile_url = "";
	
	@PostMapping("/comment/profile")
	public String moveProfile(Model model, String id) {
		
		MemberDTO movedto = memberService.getAll(id);
		model.addAttribute("id",id); //원섭
		model.addAttribute("movedto", movedto);
		
		return "/profile/introduction";
	}
	
	@GetMapping("/profile")
	public String moveProfile2(HttpSession session,Model model) {
		String id = (String)session.getAttribute("id");
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
	public String moveProfile3(HttpSession session,Model model, String id) {
		System.out.println(id);
		//MemberDTO movedto = memberService.getAll(id);
		session.removeAttribute("url");
		String url = memberService.getUrl(id);
		session.setAttribute("url",url);
		
		System.out.println(url);
			return "redirect:profile/"+url;
	}
	
	
	@PostMapping("/comment/sponsored")
	public String moveToS(Model model, String id) {
		
		MemberDTO movedto = memberService.getAll(id);
		model.addAttribute("id",id); //원섭
		model.addAttribute("movedto", movedto);
		
		return "/profile/sponsoredProject";
	}
	
	
	
//	소개
	@GetMapping("/profile/{url}")
	public String introduction (Model model,@PathVariable String url) {
			
			String id = memberService.getIdUrl(url);
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("url", url);
			MemberDTO dto = memberService.getAllProfile(map);
			model.addAttribute("dto", dto);
			
			//String url = memberService.getUrl(id);
			
			return "/profile/introduction";
	}

	
//	후원한 프로젝트
	@GetMapping("/profile/{url}/backed")
	public String sponsoredList (HttpSession session, Model model,@PathVariable String url) {
		
		String id = memberService.getIdUrl(url);
		String name = memberService.getName(id);
		//System.out.println(name);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("url", url);
		MemberDTO dto = memberService.getAllProfile(map);
		
		List<SupportDetailDTO> supportLsit = profileService.getSupportProject(id);
		
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
		model.addAttribute("supportLsit", supportLsit);
		model.addAttribute("count", supportLsit.size());
		//System.out.println("후원한리스트"+supportLsit);
		
		return "/profile/sponsoredProject";
	}
//	후원한 성공 디테일
	@GetMapping("/profile/{url}/support_success")
	public ModelAndView sponsoredSuccessDetail (@RequestParam String num, @PathVariable String url) {
		
		ModelAndView mview = new ModelAndView();
		String id = memberService.getIdUrl(url);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("url", url);
		MemberDTO dto = memberService.getAllProfile(map);
		mview.addObject("dto", dto);
		
		SupportDetailDTO sdto = profileService.getSupportData(num);
		mview.addObject("sdto", sdto);
		mview.setViewName("/profile/sponsoeredDetail");
		
		return mview;
		
	}
	
//	후원한 프로젝트 삭제
	@ResponseBody
	@GetMapping("/profile/{url}/support_cancel")
	public void supportCancel(@RequestParam String num, @PathVariable String url) {
		
		profileService.minusTotalAmountNumberPeople(num);
		profileService.deleteSupport(num);
	}
	
//	내가 올린 프로젝트
	@GetMapping("/profile/{url}/created")
	public ModelAndView uploadeList (HttpSession session, @RequestParam HashMap<String, String> map,@PathVariable String url) {
		
		String id = memberService.getIdUrl(url);
		System.out.println("아이디 "+id);
		HashMap<String, String> map1 = new HashMap<String, String>();
		map1.put("id", id);
		map1.put("url", url);
		MemberDTO dto = memberService.getAllProfile(map1);
		
		ModelAndView mview = new ModelAndView();
		String name = memberService.getName(id);
		
		List<ProjectDTO> creativeList = profileService.getCreativeProject(id);
		System.out.println("창작한 리스트: "+creativeList);
		//System.out.println("창작한 갯수: "+creativeList.size());
		
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
		
		mview.addObject("dto", dto);
		mview.addObject("name", name);
		mview.addObject("creativeList", creativeList);
		mview.addObject("creativeCont", creativeList.size());
		mview.addObject("write_count", write_count);
		mview.addObject("audit_count", audit_count);
		mview.addObject("companion_count", companion_count);
		mview.addObject("approval_count", approval_count);
		mview.setViewName("/profile/uploadedProject");
		return mview;
	}
	
	
//	내가 올린 프로젝트 삭제 -사진삭제 추가하기
	@GetMapping("/profile/{url}/created_delete")
	@ResponseBody
	public void delete(@RequestParam String idx, HttpSession session,@PathVariable String url) {
		
		// 실제 업로드 폴더의 경로
		String path = session.getServletContext().getRealPath("/thumbnail_image");
		//System.out.println(path);
		//String path = "/home/ec2-user/backup/thumbnail_image";
		// 업로드된 파일명
		ProjectDTO pdto = projectService.getData(idx);
		String thumbnail = pdto.getThumbnail();
		//System.out.println(thumbnail);
		// file 객체 생성
		File file = new File(path +"/"+ thumbnail);
		// 파일 삭제
		file.delete();
		
		
		profileService.deleteCreativeProject(idx);
		
	}
	
//	올린 프로젝트 관리 디테일 페이지
	@GetMapping("/profile/{url}/created_management")
	public ModelAndView getProject (@RequestParam String idx, @PathVariable String url) {
		
		ModelAndView mview = new ModelAndView();
		//ProjectDTO dto = profileService.getProject(idx);
		ProjectDTO pdto = projectService.getData(idx);
		//System.out.println("idx: "+idx);
		//System.out.println(pdto.getThumbnail());
		
		mview.addObject("pdto", pdto);
		mview.setViewName("/profile/uploadedProjectModify");
		
		
		return mview;
	}
	
//
//	후원자 리스트
	@GetMapping("/profile/{url}/created_sponsorlist")
	public ModelAndView sponsorList(
			@RequestParam(defaultValue = "1") int currentPage,
			String idx,
			@PathVariable String url
			) {
		
		ModelAndView mview = new ModelAndView();
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
		
		mview.addObject("pdto", pdto);
		mview.addObject("sponsorList", sponsorList);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		mview.addObject("currentPage", currentPage);
		mview.addObject("totalCount", totalCount);
		mview.setViewName("/profile/sponsorMemberList");
		
		return mview;
	}
	
//	후원자 디테일
	@GetMapping("/profile/created_sponsorDetail")
	public ModelAndView sponsorDetail(
			@RequestParam (defaultValue = "1") int currentPage,
			String num
			) {
		
		ModelAndView mview = new ModelAndView();
		SupportDetailDTO dto = profileService.getSponsorMemberData(num);
		
		mview.addObject("dto", dto);
		mview.addObject("currentPage", currentPage);
		mview.setViewName("/profile/sponsorMemberDetail");
		
		return mview;
	}
//	
	
//	관심있는 프로젝트
	@GetMapping("/profile/{url}/liked")
	public String interestList (HttpSession session, Model model, String idx,@PathVariable String url) {
		
		String id = memberService.getIdUrl(url);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("url", url);
		MemberDTO dto = memberService.getAllProfile(map);
		
		String name = memberService.getName(id);
		//System.out.println(name);
		
		
		List<LikedDTO> likeList = profileService.getLikedProject(id);
		ProjectDTO pdto = projectService.getData(idx);
		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		Date today = Date.valueOf(sdf.format(new java.util.Date()));
//		float totalAmount = pdto.getTotal_amount();
//		float targetAmount = pdto.getTarget_amount();
//		int percentageAchieved = (int)Math.round((totalAmount / targetAmount * 100));
		
		model.addAttribute("likeList", likeList);
		model.addAttribute("likecount", likeList.size());
		model.addAttribute("dto", dto);
		model.addAttribute("name", name);
//		model.addAttribute("today", today);
//		model.addAttribute("percentageAchieved", percentageAchieved);
//		System.out.println(percentageAchieved);
		
		return "/profile/projectInterest";
	}
	
//	관심 프로젝트 삭제
	@GetMapping("/profile/{url}/liked_delete")
	@ResponseBody
	public void deleteLiked (@RequestParam String num, @PathVariable String url) {
		
		profileService.deleteLikedProject(num);
	}
	
}