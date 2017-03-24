package com.moviego.movies.gpa;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;

@Service("gpa.gpaService")
public class GpaServiceImpl implements GpaService{

	@Autowired
	CommonDAO dao;
	
	@Override
	public void insertGpa(Gpa dto) throws Exception {
		try {
			dao.insertData("gpa.insertGpa", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	@Override
	public Gpa getReadGta(int scoreIdx) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Gpa> getMovieList() {
		List<Gpa> list=null;
		try {
			list=dao.getListData("gpa.getMovieList");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	
	@Override
	public Gpa getMyMovieList(Map<String, Object> map) {
		Gpa dto=null;
		try {
			dto= dao.getReadData("gpa.getMyMovieList",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public List<Gpa> getGpaList(Map<String, Object> map) {
		List<Gpa> list=null;
		try {
			list=dao.getListData("gpa.getGpaList",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int getDataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("gpa.dataCount", map);
		} catch (Exception e) {}
		return result;
	}
	
	@Override
	public int getMovieCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("gpa.getMovieCount",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}


	@Override
	public int deleteGpa(int scoreIdx) throws Exception {
		int result=0;
		try {
			result=dao.deleteData("gpa.deleteGpa",scoreIdx);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertGpaLike(Gpa dto) throws Exception {
		int result=0;
		try {
			result=dao.insertData("gpa.insertGpaLike", dto);
			System.out.println("--------성공");
		} catch (Exception e) {
			System.out.println("-------------실패");
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertGpaReport(Gpa dto) throws Exception {
		int result=0;
		try {
			result=dao.insertData("gpa.insertGpaReport", dto);
		} catch (Exception e) {

			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertMovieLike(Gpa dto) throws Exception {
		int result=0;
		try {
			result=dao.insertData("gpa.insertMovieLike", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateGpa(Gpa dto) throws Exception {
		int result=0;
		try {
			result=dao.updateData("gpa.updateGpa", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
















}
