package com.moviego.main;

import java.util.List;
import java.util.Map;

public interface MainService {
	public List<Main> getMovieList();										// 상영중인 영화 리스트
	public int getMovieCount(Map<String, Object> map);			// 상영중인 영화 수
	public Main getNotice();
}
