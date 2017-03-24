package com.moviego.member;

import java.util.Map;

public interface MemberService {
	public Member readMember1(int memberIdx);
	public Member readMember2(String id);
	public String getFindId(Member dto);
	public Member getFindPwd(Member dto);
	
	public int telCheck(String tel);
	public int emailCheck(String email);
	
	// 회원 성공 여부를 알리기 위해 return type이 int 
	public int insertMember(Member dto) throws Exception;
	
	public void updateMember2(Member dto) throws Exception;
	public void updateLastLogin(String id) throws Exception;
	
	public void deleteMember2(Map<String, Object> map) throws Exception;
}