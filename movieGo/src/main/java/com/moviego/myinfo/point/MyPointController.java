package com.moviego.myinfo.point;

import java.util.Calendar;
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

@Controller("point.mypointController")
public class MyPointController {
	
	@Autowired
	private PointService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/point/mypoint")
	public String myPointForm(HttpServletRequest req,
											String startdate, 
											String enddate,
											@RequestParam(defaultValue="1") int page,
											Model model, HttpSession session
			) throws Exception {	
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return ".myinfo.myinfo.mymain";
		}
		
		if(startdate==null || enddate==null) {
			Calendar cal1=Calendar.getInstance();
			Calendar cal2=Calendar.getInstance();			
			
			cal1.add(Calendar.MONTH, -1);
			
			startdate = String.format("%tF", cal1);
			enddate = String.format("%tF", cal2);			
		}
		
		Map<String, Object> map=new HashMap<>();
		int numPerPage = 10;
	
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		map.put("memberIdx", info.getMemberIdx());
		
		int dataCount = service.dataCount(map);
		int total_page = util.pageCount(numPerPage, dataCount);
		
		if(page > total_page)
			page = total_page;
		
		int start = (page - 1) * numPerPage+1;
		int end = page * numPerPage;
		map.put("start", start);
		map.put("end", end);

		List<Point> list = service.getReadPointList(map);
		Point dto = service.getReadPoint(info.getMemberIdx());
		
		String cp = req.getContextPath();
		String listUrl = cp+"/point/mypoint";
		if(enddate.length()!=0) 
			listUrl+="?startdate="+startdate+"&enddate="+enddate;
		
		String paging = util.paging(page, total_page, listUrl);
	    
		model.addAttribute("paging", paging);
	    model.addAttribute("list", list);
	    model.addAttribute("dto", dto);
	    model.addAttribute("startdate", startdate);
	    model.addAttribute("enddate", enddate);
		
		return ".myinfo.point.mypoint";
	}
}
