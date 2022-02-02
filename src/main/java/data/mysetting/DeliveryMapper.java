package data.mysetting;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface DeliveryMapper {
	
	public void insertDelivery(DeliveryDTO ddto);
	public List<DeliveryDTO> getAll(String id);
	public DeliveryDTO getAllDelivery(HashMap<String, String> map);
	public int getTotalCount(String id);
	public int getPin(HashMap<String, String> map);
	public int getPinNum(HashMap<String, String> map);
	public void updateDeliveryPin(int num);
	public List<DeliveryDTO> getPinList(String id);
	public void updateDelivery(DeliveryDTO ddto);
	public void deleteDelivery(HashMap<String, String> map);
}
