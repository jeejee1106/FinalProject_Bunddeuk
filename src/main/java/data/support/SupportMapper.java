package data.support;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SupportMapper {

	public void insertSupportData(SupportDTO dto);
	public void addSupporter(int idx);
	public void addTotalAmount(int pstP, int idx);
	public String getEmail(String id);
	public String getHp(String id);
	public String getAddr(String id);
}
