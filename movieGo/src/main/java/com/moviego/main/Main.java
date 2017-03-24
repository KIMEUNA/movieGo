package com.moviego.main;

public class Main {
	private int movieIdx;				// 영화번호
	private String movieName;		// 영화이름
	private String gradeName;		// 장르
	private String regdate;			// 개봉일자
	private int listNum;					// 리스트넘
	private int noticeIdx;
	private String subject;
	
	public int getMovieIdx() {
		return movieIdx;
	}
	public void setMovieIdx(int movieIdx) {
		this.movieIdx = movieIdx;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getNoticeIdx() {
		return noticeIdx;
	}
	public void setNoticeIdx(int noticeIdx) {
		this.noticeIdx = noticeIdx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
}
