package com.moviego.member.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;
import com.moviego.member.Member;
import com.moviego.member.MemberService;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private CommonDAO dao;

	@Override
	public Member readMember1(int memberIdx) {
		Member dto=null;
		try {
			dto=dao.getReadData("member.readMember1", memberIdx);
			
		} catch (Exception e) {
		}
		return dto;
	}


	@Override
	public Member readMember2(String id) {
		// TODO Auto-generated method stub
		Member dto = null;
		try {
			dto = dao.getReadData("member.readMember2", id);
		} catch (Exception e) {}
		
		return dto;
	}
	
	@Override
	public String getFindId(Member dto) {
		// TODO Auto-generated method stub
		String id=null;
		try {
			id=dao.getReadData("member.getFindId", dto);
		} catch (Exception e) {}
		return id;
	}
	
	@Override
	public Member getFindPwd(Member dto) {
		// TODO Auto-generated method stub
		try {
			dto = dao.getReadData("member.getFindPwd", dto);
		} catch (Exception e) {}
		
		return dto;
	}
	
	@Override
	public int telCheck(String tel) {
		int result=0;
		try {
			result=dao.getReadData("member.telCheck", tel);

		} catch (Exception e) {
		}
		return result;
	}
	
	@Override
	public int emailCheck(String email) {
		int result=0;
		try {
			result=dao.getReadData("member.emailCheck", email);

		} catch (Exception e) {
		}
		return result;
	}



	@Override
	public int insertMember(Member dto) throws Exception {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			
			dto.setMemberIdx(dao.getIntValue("member.getMemberSeq"));
			dto.setIsMember(1);
			if(dto.getId()==null)
				dto.setIsMember(0);
			
			dao.insertData("member.insertMember1", dto);
			dao.insertData("member.insertMember2", dto);
			
			dto.setAuthority("ROLE_5");
			dao.insertData("member.insertAuthority", dto);
			
			res = 1;
		} catch (Exception e) {
			throw e;
		}
		return res;
	}

	@Override
	public void updateMember2(Member dto) throws Exception {
		try {
			dao.updateData("member.updateMember2", dto);
		} catch (Exception e) {throw e;}
	}

	@Override
	public void updateLastLogin(String id) throws Exception {
		// TODO Auto-generated method stub
		try {
			dao.updateData("member.updateLastLogin", id);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteMember2(Map<String, Object> map) throws Exception {
		try {
			int memberIdx=(Integer)map.get("mIdx");
			dao.updateData("member.updateMember1", memberIdx);
			
			String id=(String)map.get("id");
			dao.deleteData("member.deleteMember2", id);
		} catch (Exception e) {
			throw e;
		}
	}



	
}
