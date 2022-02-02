package data.keyword;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class keywordService {
	@Autowired
	keywordMapper keywordMapper;
	
	public List<KeywordDTO> getKeywordList(){
		return keywordMapper.getKeywordList();
	}
	public void insertKeyword(String keyword) {
		keywordMapper.insertKeyword(keyword);
	}
}
