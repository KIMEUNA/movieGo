package com.moviego.myinfo.myreserve;

import java.util.List;
import java.util.Map;

public interface MyReserveService {
	
	public List<MyReserve> getMyReserveList(Map<String, Object> memberIdx);
	public List<MyReserve> getReserveCancelList(int memberIdx);
	public int dataCount(Map<String, Object> map);
	
}
