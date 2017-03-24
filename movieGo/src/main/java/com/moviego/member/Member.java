package com.moviego.member;

public class Member {
	
	// 회원 정보
	private int memberIdx, isMember;
	private String id, name, pass;
	private int enabled;
	private String birth;
	private String email;
	private String tel;
	private String m_regdate, modify_date, last_login;
	// 마일리지
	private int mileageIdx;
	private int savePoint;
	private String kind;
	private String p_regdate;
	// 자주찾는 영화관
	private int bmCinemaIdx;
	
	//권한
	private int num;
	private String authority;

	// 겟셋
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getIsMember() {
		return isMember;
	}
	public void setIsMember(int isMember) {
		this.isMember = isMember;
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
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getM_regdate() {
		return m_regdate;
	}
	public void setM_regdate(String m_regdate) {
		this.m_regdate = m_regdate;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public String getLast_login() {
		return last_login;
	}
	public void setLast_login(String last_login) {
		this.last_login = last_login;
	}
	public int getMileageIdx() {
		return mileageIdx;
	}
	public void setMileageIdx(int mileageIdx) {
		this.mileageIdx = mileageIdx;
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
	public String getP_regdate() {
		return p_regdate;
	}
	public void setP_regdate(String p_regdate) {
		this.p_regdate = p_regdate;
	}
	public int getBmCinemaIdx() {
		return bmCinemaIdx;
	}
	public void setBmCinemaIdx(int bmCinemaIdx) {
		this.bmCinemaIdx = bmCinemaIdx;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
}
