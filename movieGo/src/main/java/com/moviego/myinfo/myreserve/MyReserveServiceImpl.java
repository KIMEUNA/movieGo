package com.moviego.myinfo.myreserve;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;

@Service("myreserveServiceImpl")
public class MyReserveServiceImpl implements MyReserveService{
	
	@Autowired
	private CommonDAO dao;

	@Override
	public List<MyReserve> getMyReserveList(Map<String, Object> memberIdx) {
		// TODO Auto-generated method stub
		List<MyReserve> list = null;
		try {
			list=dao.getListData("myreserve.getMyReserveList", memberIdx);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list;
	}

	@Override
	public List<MyReserve> getReserveCancelList(int memberIdx) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = dao.getIntValue("myreserve.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}
	

}
