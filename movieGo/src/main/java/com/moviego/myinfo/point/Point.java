package com.moviego.myinfo.point;

public class Point {

	private int mileageIdx, memberIdx;
	private int savePoint;
	private String kind, regdate;
	private String cinemaName;
	
	public String getCinemaName() {
		return cinemaName;
	}
	public void setCinemaName(String cinemaName) {
		this.cinemaName = cinemaName;
	}
	public int getMileageIdx() {
		return mileageIdx;
	}
	public void setMileageIdx(int mileageIdx) {
		this.mileageIdx = mileageIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getSavePoint() {
		return savePoint;
	}
	public void setSavePoint(int savePoint) {
		this.savePoint = savePoint;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

}
