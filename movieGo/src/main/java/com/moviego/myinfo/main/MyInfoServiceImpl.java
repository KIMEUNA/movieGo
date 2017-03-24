package com.moviego.myinfo.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;

@Service("myinfo.myInfoService")
public class MyInfoServiceImpl implements MyInfoService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public MyInfo getMember(int memberIdx) {
		// TODO Auto-generated method stub
		MyInfo dto = null;
		try {
			dto = dao.getReadData("myInfo.getMember", memberIdx);
		} catch (Exception e) {}
		return dto;
	}

	@Override
	public List<MyInfo> getReserveMovies(int memberIdx) {
		// TODO Auto-generated method stub
		List<MyInfo> list = null;
		try {
			list = dao.getListData("myInfo.getReserveMovies", memberIdx);
		} catch (Exception e) {}
		return list;
	}

	@Override
	public List<MyInfo> getSeats(int reserveIdx) {
		// TODO Auto-generated method stub
		List<MyInfo> list = null;
		try {
			list = dao.getListData("myInfo.getSeats", reserveIdx);
		} catch (Exception e) {}
		return list;
	}

	@Override
	public List<MyInfo> getPayment(int reserveIdx) {
		// TODO Auto-generated method stub
		List<MyInfo> list = null;
		try {
			list = dao.getListData("myInfo.getPayment", reserveIdx);
		} catch (Exception e) {}
		return list;
	}

	@Override
	public boolean deleteReserve(MyInfo dto) throws Exception {
		// TODO Auto-generated method stub
		boolean chk = false;
		try {
			dto=dao.getReadData("myInfo.getPaymentCancel", dto.getReserveIdx());
			dao.insertData("myInfo.insertReserveCancel", dto);
			dao.deleteData("myInfo.deleteSeat", dto.getReserveIdx());
			dao.deleteData("myInfo.deleteMileage", dto.getReserveIdx());
			chk=true;
		} catch (Exception e) {
			throw e;
		}
		return chk;
	}


	
}
