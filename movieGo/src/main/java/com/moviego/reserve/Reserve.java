package com.moviego.reserve;

import java.util.Date;
import java.util.List;

public class Reserve {

	// movie
	private int movieIdx, memberIdx;
	private String movieName, genreName, gradeName;
	private String poster;
	
	// effect
	private String effect;
	
	// city
	private int cityIdx;
	private String cityName;
	
	// cinema
	private int cinemaIdx, multiplexIdx;		// multiplex : 해당 영화관의 상영관 수
	private String cinemaName, cinemaCount;	// cinemaCount : 해당 지역의 영화관 수
	
	// multiplex
	private int seat;
	private String multiplexName, multiplexGrade, seatMap;
	
	// schedule
	private int scheduleIdx;
	private Date dates;
	private String startTime, endTime, runTime;
	private char day;
	private int inning;
	
	// seat
	private String seatNum;
	
	// price
	private int price;
	private int totPrice;
	private String kind;
	private String payment;
	private List<String> payments;
	
	// reserve_Info
	private int reserveIdx;
	private int count;
	private List<String> seats;
	private int adult;
	private int youth;
	
	
	
	public int getMovieIdx() {
		return movieIdx;
	}
	public void setMovieIdx(int movieIdx) {
		this.movieIdx = movieIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getGenreName() {
		return genreName;
	}
	public void setGenreName(String genreName) {
		this.genreName = genreName;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getEffect() {
		return effect;
	}
	public void setEffect(String effect) {
		this.effect = effect;
	}
	public int getCityIdx() {
		return cityIdx;
	}
	public void setCityIdx(int cityIdx) {
		this.cityIdx = cityIdx;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public int getCinemaIdx() {
		return cinemaIdx;
	}
	public void setCinemaIdx(int cinemaIdx) {
		this.cinemaIdx = cinemaIdx;
	}
	public int getMultiplexIdx() {
		return multiplexIdx;
	}
	public void setMultiplexIdx(int multiplexIdx) {
		this.multiplexIdx = multiplexIdx;
	}
	public String getCinemaName() {
		return cinemaName;
	}
	public void setCinemaName(String cinemaName) {
		this.cinemaName = cinemaName;
	}
	public String getCinemaCount() {
		return cinemaCount;
	}
	public void setCinemaCount(String cinemaCount) {
		this.cinemaCount = cinemaCount;
	}
	public int getSeat() {
		return seat;
	}
	public void setSeat(int seat) {
		this.seat = seat;
	}
	public String getMultiplexName() {
		return multiplexName;
	}
	public void setMultiplexName(String multiplexName) {
		this.multiplexName = multiplexName;
	}
	public String getMultiplexGrade() {
		return multiplexGrade;
	}
	public void setMultiplexGrade(String multiplexGrade) {
		this.multiplexGrade = multiplexGrade;
	}
	public String getSeatMap() {
		return seatMap;
	}
	public void setSeatMap(String seatMap) {
		this.seatMap = seatMap;
	}
	public int getScheduleIdx() {
		return scheduleIdx;
	}
	public void setScheduleIdx(int scheduleIdx) {
		this.scheduleIdx = scheduleIdx;
	}
	public Date getDates() {
		return dates;
	}
	public void setDates(Date dates) {
		this.dates = dates;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getRunTime() {
		return runTime;
	}
	public void setRunTime(String runTime) {
		this.runTime = runTime;
	}
	public char getDay() {
		return day;
	}
	public void setDay(char day) {
		this.day = day;
	}
	public int getInning() {
		return inning;
	}
	public void setInning(int inning) {
		this.inning = inning;
	}
	public String getSeatNum() {
		return seatNum;
	}
	public void setSeatNum(String seatNum) {
		this.seatNum = seatNum;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getTotPrice() {
		return totPrice;
	}
	public void setTotPrice(int totPrice) {
		this.totPrice = totPrice;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getReserveIdx() {
		return reserveIdx;
	}
	public void setReserveIdx(int reserveIdx) {
		this.reserveIdx = reserveIdx;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List<String> getSeats() {
		return seats;
	}
	public void setSeats(List<String> seats) {
		this.seats = seats;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public List<String> getPayments() {
		return payments;
	}
	public void setPayments(List<String> payments) {
		this.payments = payments;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getYouth() {
		return youth;
	}
	public void setYouth(int youth) {
		this.youth = youth;
	}
	
		
}
