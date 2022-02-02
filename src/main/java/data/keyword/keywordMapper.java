package data.keyword;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface keywordMapper {
	public List<KeywordDTO> getKeywordList();
	public void insertKeyword(String keyword);
}
