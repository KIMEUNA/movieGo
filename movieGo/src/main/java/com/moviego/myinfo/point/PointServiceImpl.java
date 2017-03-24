package com.moviego.myinfo.point;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;

@Service("point.pointServiceImpl")
public class PointServiceImpl implements PointService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Point> getReadPointList(Map<String, Object> map) {
		List<Point> list=null;
		try {
			list=dao.getListData("point.getReadPointList", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public Point getReadPoint(int memberIdx) {
		Point dto=null;
		try {
			dto=dao.getReadData("point.getReadPoint", memberIdx);
		} catch (Exception e) {
		}		
		return dto;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = dao.getIntValue("point.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return res;
	}

}
