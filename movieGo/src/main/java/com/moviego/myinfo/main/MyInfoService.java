package com.moviego.myinfo.main;

import java.util.List;

public interface MyInfoService {

	public MyInfo getMember(int memberIdx);
	public List<MyInfo> getReserveMovies(int memberIdx);
	public List<MyInfo> getSeats(int reserveIdx);
	public List<MyInfo> getPayment(int reserveIdx);
	
	
	public boolean deleteReserve(MyInfo dto) throws Exception;
	
	
}
