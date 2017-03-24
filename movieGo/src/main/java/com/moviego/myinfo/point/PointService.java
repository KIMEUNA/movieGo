package com.moviego.myinfo.point;

import java.util.List;
import java.util.Map;

public interface PointService {
	
	public List<Point> getReadPointList(Map<String, Object> map);
	public Point getReadPoint(int memberIdx);
	public int dataCount(Map<String, Object> map);
}
