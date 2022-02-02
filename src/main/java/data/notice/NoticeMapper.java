package data.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper {

	public List<NoticeDTO> getNoticeList(int start, int perpage);
	public int getTotalCount();
	public void insertNotice(NoticeDTO dto);
	
	public NoticeDTO getNoticeData(String num);
	public int getMaxNum();
	public void updateNotice(NoticeDTO dto);
	public void deleteNotice(String num);
	public NoticeDTO getBeforeData(String num);
	public NoticeDTO getAfterData(String num);
}
