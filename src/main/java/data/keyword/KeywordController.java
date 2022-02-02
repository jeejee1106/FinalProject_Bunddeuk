package data.keyword;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class KeywordController {
	@Autowired
	keywordService keywordService;
	@ResponseBody
	@GetMapping("/keyword/insert")
	public void insertKeyword(String keyword) {
		keywordService.insertKeyword(keyword);
	}
	@ResponseBody
	@GetMapping("/keyword/getKeyword")
	public List<KeywordDTO> getKeywordList(){
		return keywordService.getKeywordList();
	}
}
