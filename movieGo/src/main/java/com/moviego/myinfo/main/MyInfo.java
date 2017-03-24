package com.moviego.myinfo.main;

import java.util.List;

public class MyInfo {

	private int memberIdx;
	private String id, name;
	private int point;
	
	// 예매번호, 날짜, 관람극장, 관람일시, 영화이름, 영화 포스터, 좌석, 결제방법, 결제 금액
	private int reserveIdx;
	
	private String movieName, cinemaName, multiplexName;
	private String poster;
	
	private String payment_type;
	private int payment_price;
	private String seatNum;
	
	private List<MyInfo> seats;
	private List<MyInfo> payments;
	
	private String reserveDate;
	private String startTime;
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getReserveIdx() {
		return reserveIdx;
	}
	public void setReserveIdx(int reserveIdx) {
		this.reserveIdx = reserveIdx;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
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
	public String getPayment_type() {
		return payment_type;
	}
	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}
	public int getPayment_price() {
		return payment_price;
	}
	public void setPayment_price(int payment_price) {
		this.payment_price = payment_price;
	}
	public String getSeatNum() {
		return seatNum;
	}
	public void setSeatNum(String seatNum) {
		this.seatNum = seatNum;
	}
	public List<MyInfo> getSeats() {
		return seats;
	}
	public void setSeats(List<MyInfo> seats) {
		this.seats = seats;
	}
	public List<MyInfo> getPayments() {
		return payments;
	}
	public void setPayments(List<MyInfo> payments) {
		this.payments = payments;
	}
	public String getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	
	
	
	
}
