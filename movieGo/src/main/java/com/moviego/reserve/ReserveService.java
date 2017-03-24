package com.moviego.reserve;

import java.util.List;
import java.util.Map;

public interface ReserveService {
	
	public List<Reserve> getMovieList(Map<String, Object> map);
	public List<Reserve> getCityList(Map<String, Object> map);
	public List<Reserve> getCinemaList(Map<String, Object> map);
	public List<Reserve> getDateList(Map<String, Object> map);
	public List<Reserve> getScheduleList(Map<String, Object> map);
	public List<Reserve> getNoneMovies(List<Integer> idxList);
	public List<Reserve> getNoneCinemas(Map<String, Object> map);
	public List<Reserve> reserveState(int scheduleIdx);
	public List<Reserve> getPrice(int scheduleIdx);
	public Reserve getMovie(int movieIdx);
	public Reserve getCinema(int cinemaIdx);
	public Reserve getTimeInfo(int scheduleIdx);
	public Reserve getSeat(int scheduleIdx);
	public Reserve getReserveInfo(int scheduleIdx);
	public int getPoint(int memberIdx);
	
	public void insertReserve(Reserve dto) throws Exception;
}
