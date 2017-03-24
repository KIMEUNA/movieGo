package com.moviego.myinfo.myreserve;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moviego.common.MyUtil;
import com.moviego.member.SessionInfo;

@Controller("main.myreserveController")
public class MyReserveController {

	@Autowired
	private MyReserveService service;
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/myreserve/myreserve")
	public String myReserveForm(@RequestParam(defaultValue="1") int page, HttpServletRequest req, 
												Model model, HttpSession session
												) throws Exception {
		
		// 영화이름, 포스터, 등급, 상영시간, 종료시간, 극장, 관, 몇명, 평점작성유무
		
		
		Map<String, Object> map=new HashMap<>();
		int numPerPage = 5;
		
		int dataCount = service.dataCount(map);
		int total_page = util.pageCount(numPerPage, dataCount);
		
		if(page > total_page)
			page = total_page;
		
		int start = (page - 1) * numPerPage+1;
		int end = page * numPerPage;
		map.put("start", start);
		map.put("end", end);
		
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		int memberIdx=info.getMemberIdx();
		map.put("memberIdx", memberIdx);
		
		List<MyReserve> reserveList = service.getMyReserveList(map);
		
		String cp = req.getContextPath();
		String listUrl = cp+"/myreserve/myreserve";
		
		String paging = util.paging(page, total_page, listUrl);
	    
		model.addAttribute("paging", paging);
		model.addAttribute("list", reserveList);
		
		return ".myinfo.myreserve.myreserve";
	}
}
