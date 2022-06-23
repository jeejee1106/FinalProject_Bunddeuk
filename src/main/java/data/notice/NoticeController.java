package data.notice;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;



import data.member.MemberService;
import data.paging.PagingHandler;

@Controller
public class NoticeController implements ServletContextAware {
	
	@Autowired
	MemberService memberService;
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/notice")
	public String noticeList(HttpSession session, Model model,
			@RequestParam(defaultValue = "1") int currentPage, 
			@RequestParam(defaultValue = "10") int pageSize) {
		
//		String id = (String) session.getAttribute("sessionId");
//		String loginok = (String) session.getAttribute("loginok");
		
		int totalCount = noticeService.getTotalCount();
		PagingHandler pagingHandler = new PagingHandler(totalCount, currentPage, pageSize);
		List<NoticeDTO> noticeList = noticeService.getNoticeList(currentPage, pageSize);
		
		model.addAttribute("noticeList", noticeList);
//		model.addAttribute("totalPage", totalPage);
		model.addAttribute("ph", pagingHandler);
		model.addAttribute("currentPage", currentPage);
		
		return "/notice/noticeList";
	}
	
	private ServletContext servletContext;
	
	@GetMapping("/notice/wrtieform")
	public String writeForm() {
		return "/notice/noticeAddForm";
	}
	
	@PostMapping(value = "/notice/upload_ckeditor", produces = { MimeTypeUtils.APPLICATION_JSON_VALUE })
	public ResponseEntity<JSONFileUpload> UploadCKEditor(@RequestParam("upload") MultipartFile upload) {
		try {
			String fileName = UploadFileHelper.upload(servletContext, upload);
			return new ResponseEntity<JSONFileUpload>(new JSONFileUpload("/webapp/ckupload/" + fileName), HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<JSONFileUpload>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
	
	@PostMapping("/notice/insert")
	public String noticeInsert(@ModelAttribute NoticeDTO dto, HttpSession session) {
		
		String loginok = (String) session.getAttribute("loginok");
		if(loginok == null) {
			return "/notice/loginmsg";
		}
		
		String id = (String) session.getAttribute("sessionId");
		dto.setId(id);
		
		noticeService.insertNotice(dto);
		return "redirect:detail?num=" + noticeService.getMaxNum();
	}
	
	@GetMapping("/notice/detail")
	public String getData( @RequestParam String num,  HttpSession session, Model model,
								 @RequestParam (defaultValue = "1") int currentPage) {
		
//		String id = (String) session.getAttribute("sessionId");
		NoticeDTO ndto = noticeService.getNoticeData(num);
		
		model.addAttribute("ndto", ndto);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("before", noticeService.getBeforeData(num));
		model.addAttribute("after", noticeService.getAfterData(num));
		
		return "/notice/noticeDetail";
	}
	
	@GetMapping("/notice/updateform")
	public String updateForm(@RequestParam String num, HttpSession session, String currentPage, Model model) {
		
//		String id = (String) session.getAttribute("sessionId");
//		String login = (String) session.getAttribute("login");
		NoticeDTO ndto = noticeService.getNoticeData(num);
		
		model.addAttribute("ndto", ndto);
		model.addAttribute("currentPage", currentPage);
		return "/notice/noticeUpdateForm";
	}
	
	@PostMapping("/notice/update")
	public String noticeUpdate( @ModelAttribute NoticeDTO ndto, String currentPage, HttpSession session) {
		noticeService.updateNotice(ndto);
		return "redirect:detail?num=" + ndto.getNum() + "&currentPage=" + currentPage;
	}
	
	@GetMapping("/notice/delete")
	public String deleteNotice(@RequestParam String num, String currentPage, HttpSession session) {
		noticeService.deleteNotice(num);
		return "redirect:/notice?currentPage=" + currentPage;
	}
		
}


