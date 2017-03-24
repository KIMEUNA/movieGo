package com.moviego.movies.gpa;

public class Gpa {
	
	// 평점
	private int scoreIdx;					// 글번호
	private int memberIdx;				// 회원번호
	private String userId;					// 회원 아이디
	private int reserveIdx;					// 예매번호
	private int cinemaIdx;					// 극장
	private String cinemaName;			// 극장 이름
	private int multiplex;					// 상영관
	private String multiplexName;		// 상영관 명
	private String starttime;				// 상영시간
	private String movieName;			// 영화이름
	private int movieIdx;					// 영화 코드
	private String poster;					// 영화 포스터
	private int cnt;							// 영화 관람객 수
	private double reservePer;			// 예매율 	 
	private String grade, m_Regdate;// 영화 개봉일 
	private String content;			   	// 내용
	private int score;						// 점수
	private String regdate;				// 등록일
	private int listNum;						// 리스트
	private int likeCount;					// 평점 좋아요
	private int movieLike;					// 영화 좋아요
	
	public int getScoreIdx() {
		return scoreIdx;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getM_Regdate() {
		return m_Regdate;
	}
	public void setM_Regdate(String m_Regdate) {
		this.m_Regdate = m_Regdate;
	}
	public void setScoreIdx(int scoreIdx) {
		this.scoreIdx = scoreIdx;
	}
	public int getMovieIdx() {
		return movieIdx;
	}
	public void setMovieIdx(int movieIdx) {
		this.movieIdx = movieIdx;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public double getReservePer() {
		return reservePer;
	}
	public void setReservePer(double reservePer) {
		this.reservePer = reservePer;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getReserveIdx() {
		return reserveIdx;
	}
	public void setReserveIdx(int reserveIdx) {
		this.reserveIdx = reserveIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getCinemaIdx() {
		return cinemaIdx;
	}
	public void setCinemaIdx(int cinemaIdx) {
		this.cinemaIdx = cinemaIdx;
	}
	public int getMultiplex() {
		return multiplex;
	}
	public void setMultiplex(int multiplex) {
		this.multiplex = multiplex;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	
	@Override
	public String toString() {
		return "Gpa [scoreIdx=" + scoreIdx + ", memberIdx=" + memberIdx + ", reserveIdx=" + reserveIdx + ", movieName="
				+ movieName + ", content=" + content + ", score=" + score + ", regdate=" + regdate + ", listNum="
				+ listNum + "]";
	}
	public String getCinemaName() {
		return cinemaName;
	}
	public void setCinemaName(String cinemaName) {
		this.cinemaName = cinemaName;
	}
	public String getMultiplexName() {
		return multiplexName;
	}
	public void setMultiplexName(String multiplexName) {
		this.multiplexName = multiplexName;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public int getMovieLike() {
		return movieLike;
	}
	public void setMovieLike(int movieLike) {
		this.movieLike = movieLike;
	}

	

	
	
}
