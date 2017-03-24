package com.moviego.movies.gpa;

import java.util.List;
import java.util.Map;

public interface GpaService {
	public void insertGpa(Gpa dto) throws Exception;					// 평점	내용
	public Gpa getReadGta(int scoreIdx);										// 평점내용 보이기

	public List<Gpa> getMovieList();												// 상영중인 영화 리스트
	public Gpa getMyMovieList(Map<String, Object> map);				// 영화 관람 유무가리기
	public List<Gpa> getGpaList(Map<String, Object> map);				// 평점 리스트
	public int getDataCount(Map<String, Object> map);					// 해당 영화에 대한 평점 개수 구하기
	
	public int getMovieCount(Map<String, Object> map);					// 상영중인 영화 카운트 ( 영화 페이징을 위한 )
	
	public int updateGpa(Gpa dto) throws Exception;						// 평점 내용 수정
	public int deleteGpa(int scoreIdx) throws Exception;					// 평점 내용 삭제
//	public int deleteGpa(Map<String, Object> map) throws Exception;	
	
	public int insertGpaLike(Gpa dto) throws Exception;					// 평점 좋아요
	public int insertMovieLike(Gpa dto) throws Exception;				// 영화 좋아요
	
	public int insertGpaReport(Gpa dto) throws Exception;				// 신고내용  ( 수정 , 삭제 불가)

}
