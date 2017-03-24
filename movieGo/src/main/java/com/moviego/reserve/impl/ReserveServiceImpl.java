package com.moviego.reserve.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;
import com.moviego.reserve.Reserve;
import com.moviego.reserve.ReserveService;

@Service("reserve.reserveService")
public class ReserveServiceImpl implements ReserveService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Reserve> getNoneMovies(List<Integer> idxList) {
		// TODO Auto-generated method stub
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.getNoneMovies", idxList);
		} catch (Exception e) {}
		return list;
	}
	
	@Override
	public List<Reserve> getNoneCinemas(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.getNoneCinemas", map);
		} catch (Exception e) {}
		return list;
	}
	
	@Override
	public List<Reserve> getMovieList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.getMovieList", map);
		} catch (Exception e) {}
		return list;
	}

	@Override
	public List<Reserve> getCityList(Map<String, Object> map) {
		// 영화를 선택했을 경우.
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.getCityList", map);
		} catch (Exception e) {}
		return list;
	}

	@Override
	public List<Reserve> getCinemaList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.getCinemaList", map);
		} catch (Exception e) {}
		return list;
	}
	
	@Override
	public List<Reserve> getDateList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.getDateList", map);
		} catch (Exception e) {}
		return list;
	}
	
	@Override
	public List<Reserve> getScheduleList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.getScheduleList", map);
		} catch (Exception e) {}
		return list;
	}
	
	@Override
	public List<Reserve> reserveState(int scheduleIdx) {
		// TODO Auto-generated method stub
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.reserveState", scheduleIdx);
		} catch (Exception e) {}
		return list;
	}
	
	@Override
	public List<Reserve> getPrice(int scheduleIdx) {
		// TODO Auto-generated method stub
		List<Reserve> list = null;
		try {
			list = dao.getListData("reserve.getPrice", scheduleIdx);
		} catch (Exception e) {}
		return list;
	}

	@Override
	public Reserve getMovie(int movieIdx) {
		// TODO Auto-generated method stub
		Reserve dto = null;
		try {
			dto = dao.getReadData("reserve.getMovie", movieIdx);
		} catch (Exception e) {}
		return dto;
	}

	@Override
	public Reserve getCinema(int cinemaIdx) {
		// TODO Auto-generated method stub
		Reserve dto = null;
		try {
			dto = dao.getReadData("reserve.getCinema", cinemaIdx);
		} catch (Exception e) {}
		return dto;
	}

	@Override
	public Reserve getTimeInfo(int scheduleIdx) {
		// TODO Auto-generated method stub
		Reserve dto = null;
		try {
			dto = dao.getReadData("reserve.getTimeInfo", scheduleIdx);
		} catch (Exception e) {}
		return dto;
	}

	@Override
	public Reserve getSeat(int scheduleIdx) {
		// TODO Auto-generated method stub
		Reserve dto = null;
		try {
			dto = dao.getReadData("reserve.getSeat", scheduleIdx);
		} catch (Exception e) {}
		return dto;
	}
	
	@Override
	public Reserve getReserveInfo(int scheduleIdx) {
		// TODO Auto-generated method stub
		Reserve dto = null;
		try {
			dto = dao.getReadData("reserve.getReserveInfo", scheduleIdx);
		} catch (Exception e) {}
		return dto;
	}

	@Override
	public int getPoint(int memberIdx) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = dao.getIntValue("reserve.getPoint", memberIdx);
		} catch (Exception e) {}
		return res;
	}
	
	@Override
	public void insertReserve(Reserve dto) throws Exception{
		// TODO Auto-generated method stub
		try {
			dto.setReserveIdx(dao.getIntValue("reserve.getReserveSeq"));
			dto.setCount(dto.getAdult()+dto.getYouth());
			dao.insertData("reserve.insertReserveInfo", dto);
			for (String seat : dto.getSeats()) {
				dto.setSeatNum(seat);
				dao.insertData("reserve.insertSeat", dto);
			}
			if(dto.getAdult()!=0) {
				dto.setKind("일반");
				dto.setCount(dto.getAdult());
				dao.insertData("reserve.insertReserveKind", dto);
			}
			if(dto.getYouth()!=0) {
				dto.setKind("청소년");
				dto.setCount(dto.getYouth());
				dao.insertData("reserve.insertReserveKind", dto);
			}
			for (int i = 0; i < dto.getPayments().size(); i++) {
				dto.setPayment(dto.getPayments().get(i).split("/")[0]);
				dto.setPrice(Integer.parseInt(dto.getPayments().get(i).split("/")[1]));
				dao.insertData("reserve.insertPayment", dto);
				if(dto.getPayment().equals("적립금")) {
					dto.setKind("사용");
					dao.insertData("reserve.insertMileage", dto);
				}
			}
			dto.setKind("적립");
			dto.setPrice(Math.round(Integer.parseInt(dto.getPayments().get(0).split("/")[1])/100*5));
			dao.insertData("reserve.insertMileage", dto);
			
		} catch (Exception e) {throw e;}
	}











	

	
}
