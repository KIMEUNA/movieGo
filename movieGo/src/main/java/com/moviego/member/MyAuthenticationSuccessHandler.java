package com.moviego.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

// 로그인 성공후 세션 및 쿠키등의 처리를 할 수 있다.
// 로그인 전 정보를 Cache : 로그인 되지 않은 상태에서 로그인 상태에서만 사용할 수 있는 페이지로 이동할 경우 로그인 페이지로 이동하고 로그인 후 로그인 전 페이지로 이동
public class MyAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	@Autowired
	private MemberService Service;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest req,
			HttpServletResponse resp, Authentication authentication)
			throws ServletException, IOException {
		HttpSession session=req.getSession();
		
		System.out.println(authentication.getName()); // 로그인 아이디
		
		// 로그인 날짜 변경
		try {
			Service.updateLastLogin(authentication.getName());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Member member=Service.readMember2(authentication.getName());
		
		System.out.println("생년월일 : "+member.getBirth());
		
		
		
		SessionInfo info=new SessionInfo();
		info.setMemberIdx(member.getMemberIdx());
		info.setId(member.getId());
		info.setName(member.getName());
		info.setBirth(member.getBirth());
		
		session.setAttribute("member", info);	

		super.onAuthenticationSuccess(req, resp, authentication);
	}
}
