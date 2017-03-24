package com.moviego.main;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moviego.common.MyUtil;

@Controller("mainController")
public class MainController {
	
	@Autowired
	private MainService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/main")
	public String movieList(
			@RequestParam(value="page" ,defaultValue="1") int current_page,
			Model model 
			)throws Exception {				
		
		int numPerPage=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<>();
		
		dataCount=service.getMovieCount(map);
		
		if(dataCount != 0)
			total_page=util.pageCount(numPerPage, dataCount);
		
		if(total_page<current_page)
			current_page=total_page;
		
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		
		List<Main> movieList=service.getMovieList();
		
		int listNum,n=0;
		int movieIdx=-1;
		
		if(!movieList.isEmpty()) {
			movieIdx = movieList.get(0).getMovieIdx();
			
			Iterator<Main> it=movieList.iterator();
			while(it.hasNext()){
				Main dto=it.next();
				listNum=dataCount-(start+n-1);
				dto.setListNum(listNum);
				n++;
			}
		}
		
		String paging=util.pagingMethod(current_page, total_page, "movieList");
		
		Main notice=service.getNotice();
		
		System.out.println("notice.getNoticeIdx() : "+notice.getNoticeIdx());
		
		model.addAttribute("page",current_page);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);	
		model.addAttribute("movieList", movieList);
		model.addAttribute("movieIdx", movieIdx);
		model.addAttribute("notice", notice);
		
		return ".mainLayout";		
	}
	
}
