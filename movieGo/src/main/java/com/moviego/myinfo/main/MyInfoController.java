package com.moviego.myinfo.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviego.member.SessionInfo;

@Controller("main.myInfoController")
public class MyInfoController {

	
	@Autowired
	private MyInfoService service;
	
	@RequestMapping(value="/myinfo/mymain")
	public String myInfoForm(Model model, HttpSession session) throws Exception {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		int memberIdx=info.getMemberIdx();
	    MyInfo dto = service.getMember(memberIdx);
	    model.addAttribute("dto", dto);
		return ".myinfo.mymain";
	}
	
	@RequestMapping(value="/myinfo/myReserveList", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> myReserveList(@RequestParam int memberIdx) throws Exception {
		
		// 예매번호, 날짜, 관람극장, 관람일시, 영화이름, 영화 포스터, 좌석, 결제방법, 결제 금액
		List<MyInfo> myMovieList = service.getReserveMovies(memberIdx);
	    for (MyInfo myInfo : myMovieList) {
	    	myInfo.setSeats(service.getSeats(myInfo.getReserveIdx()));
	    	myInfo.setPayments(service.getPayment(myInfo.getReserveIdx()));
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("list", myMovieList);
		
		return model;
	}
	
	@RequestMapping(value="/myinfo/cancel", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reserveCancel(@RequestParam int reserveIdx) throws Exception {
		
		// 취소하면 좌석테이블에서 좌석을 지우고 취소테이블에 예매번호를 추가한다.
		// 마일리지 테이블도 지운다.
		
		String state = "false";
		MyInfo dto = new MyInfo();
		dto.setReserveIdx(reserveIdx);
		if(service.deleteReserve(dto)) 
			state="true";
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	
	
	
	
	
	
	
	
	
	
}
