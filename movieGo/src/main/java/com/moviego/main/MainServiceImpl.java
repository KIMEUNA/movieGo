package com.moviego.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;

@Service("mainService")
public class MainServiceImpl implements MainService{

	@Autowired
	CommonDAO dao;
	
	@Override
	public List<Main> getMovieList() {
		List<Main> list=null;
		try {
			list=dao.getListData("main.getMovieList");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int getMovieCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("main.getMovieCount",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Main getNotice() {
		// TODO Auto-generated method stub
		Main dto=null;
		try {
			dto=dao.getReadData("main.getNotice");
		} catch (Exception e) {}
		return dto;
	}

}
