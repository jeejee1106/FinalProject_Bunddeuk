package data.mysetting;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class DeliveryService {
	@Autowired
	DeliveryMapper deliveryMapper;

	public List<DeliveryDTO> getAll(String id) {
		return deliveryMapper.getAll(id);
	}
	public DeliveryDTO getAllDelivery(HashMap<String, Object> map) {
		return deliveryMapper.getAllDelivery(map);
	}
	public void insertDelivery(DeliveryDTO ddto) {
		deliveryMapper.insertDelivery(ddto);
	}
	
	public int getAddrCount(String id) {
		return deliveryMapper.getAddrCount(id);
	}
	
	public int getPin(HashMap<String, String> map) {
		return deliveryMapper.getPin(map);
	}
	
	public int getPinNum(HashMap<String, String> map) {
		return deliveryMapper.getPinNum(map);
	}
	public void updateDeliveryPin(int num) {
		deliveryMapper.updateDeliveryPin(num);
		System.out.println("service"+num);
	}
	public List<DeliveryDTO> addrListOfPinDesc(String id) {
		return deliveryMapper.addrListOfPinDesc(id);
	}
	public void updateDelivery(DeliveryDTO ddto) {
		deliveryMapper.updateDelivery(ddto);
	}
	
	public void deleteDelivery(HashMap<String, String> map) {
		deliveryMapper.deleteDelivery(map);
	}
}
