package data.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;

	public List<NoticeDTO> getNoticeList(int currentPage, int pageSize){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("offset", (currentPage-1) * pageSize);
		map.put("pageSize", pageSize);
		return noticeMapper.getNoticeList(map);
	}
	
	public int getTotalCount() {
		return noticeMapper.getTotalCount();
	}
	
	public void insertNotice(NoticeDTO dto) {
		noticeMapper.insertNotice(dto);
	}
	
	public NoticeDTO getNoticeData(String num) {
		return noticeMapper.getNoticeData(num);
	}
	
	public int getMaxNum() {
		return noticeMapper.getMaxNum();
	}
	
	public void updateNotice(NoticeDTO dto) {
		noticeMapper.updateNotice(dto);
	}
	
	public void deleteNotice(String num) {
		noticeMapper.deleteNotice(num);
	}
	
	public NoticeDTO getBeforeData(String num) {
		return noticeMapper.getBeforeData(num);
	}
	
	public NoticeDTO getAfterData(String num) {
		return noticeMapper.getAfterData(num);
	}
}
