package com.moviego.movies.gpa;

import java.util.HashMap;
import java.util.Iterator;
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

import com.moviego.common.MyUtil;
import com.moviego.member.SessionInfo;

@Controller("gpa.gpaController")
public class GpaController {
	
	@Autowired
	private GpaService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/gpa/gpa")
	public String gpaForm() throws Exception {		
		return ".movies.gpa";
	}
	
	// 무비리스트
	@RequestMapping(value="/gpa/movielist")
	public String movieList(
			@RequestParam(value="pageNo" , defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		
		int numPerPage=4;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		
		dataCount=service.getMovieCount(map);
		
		if(dataCount != 0)
			total_page=util.pageCount(numPerPage, dataCount);
		
		if(total_page<current_page)
			current_page=total_page;
		
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		
		List<Gpa> movieList = service.getMovieList();

		
		// 리스트의 번호
		int listNum,n=0;
		int movieIdx=-1;
		
		if(!movieList.isEmpty()) {
			movieIdx = movieList.get(0).getMovieIdx();
			
			Iterator<Gpa> it=movieList.iterator();
			while(it.hasNext()){
				Gpa dto=it.next();
				listNum=dataCount-(start+n-1);
				dto.setListNum(listNum);
				n++;
			}
		}
		
		String paging=util.pagingMethod(current_page, total_page, "movieList");
		
		model.addAttribute("pageNo",current_page);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);	
		model.addAttribute("movieList", movieList);
		model.addAttribute("movieIdx", movieIdx);
		
		return "movies/movieList";
	}
	
	// 평점리스트
	@RequestMapping(value="/gpa/list", method=RequestMethod.GET)
	public String list(
				@RequestParam int movieIdx,
				@RequestParam(defaultValue="-1") int memberIdx,
				@RequestParam(value="page",defaultValue="1") int current_page,
				Model model
			) throws Exception {		
		
		int numPerPage=6;
		int total_page=0;
		int dataCount=0;
		
		
		// 전체 페이지수 구하기
		Map<String, Object> map=new HashMap<String,Object>();		
		map.put("movieIdx", movieIdx);
		map.put("memberIdx", memberIdx);
		
		
		dataCount=service.getDataCount(map);
		if(dataCount != 0)
			total_page=util.pageCount(numPerPage, dataCount);
		
		// 중간에 삭제하여 변화된 경우를 위한
		if(total_page<current_page)
			current_page=total_page;
		
		// 리스트에 출력할 데이터 가져오기
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		
		// 글리스트
		List<Gpa> list=service.getGpaList(map);
		
		// 리스트의 번호
		int listNum,n=0;
		if(list !=null) {
			Iterator<Gpa> it=list.iterator();
			while(it.hasNext()){
				Gpa dto=it.next();
				listNum=dataCount-(start+n-1);
				dto.setListNum(listNum);
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
				n++;
			}
		}
		
		String paging=util.pagingMethod(current_page, total_page, "listGpaPage");
		
		model.addAttribute("list",list);
		model.addAttribute("page",current_page);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);
		
		return "movies/gpaList";
	}
	

	
	@RequestMapping(value="/gpa/writeGpa", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeGpa(
			Gpa dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		dto.setMemberIdx(info.getMemberIdx());
		service.insertGpa(dto);	
				
		// 결과를 json에 전송
		
		Map<String, Object> map=new HashMap<>();
		map.put("dto", dto);
		map.put("reserveIdx", dto.getReserveIdx());
		map.put("mIdx", dto.getMemberIdx());
		map.put("content", dto.getContent());
				
		return map;
	}
	
	@RequestMapping(value="/gpa/myMovie")
	@ResponseBody
	public Map<String, Object> myMovie (
			Gpa dto,
			HttpSession session
			) throws Exception {
		// 본영화 
		Map<String, Object> map=new HashMap<>();
			
		
		map.put("memberIdx", dto.getMemberIdx());
		map.put("movieIdx", dto.getMovieIdx());
//		map.put("reserveIdx", dto.getReserveIdx());
//		map.put("cinemaIdx",dto.getCinemaIdx());
//		map.put("starttime", dto.getStarttime());
//		map.put("multiplex", dto.getMultiplex());
//		map.put("movieName", dto.getMovieName());
		
		//int result = service.getMyMovieList(map);
		dto=service.getMyMovieList(map);
			
		map.put("dto", dto);
		
		String state = "true";
				
		if (dto == null) {
			state = "false";
		} else if(dto.getScoreIdx()!=-1) {
			state="only";
		}
					
		map.put("state", state);
				
		return map;
	}

	
	@RequestMapping(value="/gpa/updateGpa",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateGpa(
			Gpa dto,
			HttpSession session
			)throws Exception {		
		
//		SessionInfo info=(SessionInfo)session.getAttribute("member");
		int result=service.updateGpa(dto);
		Map<String, Object> map = new HashMap<>();
		
		String state="true";
		/*if(dto.getMemberIdx()!=info.getMemberIdx())
			state="false";*/
		if(result==0){
			state="false";
		}
		
		map.put("dto", dto);
		map.put("state", state);
		map.put("content", dto.getContent());
		map.put("scoreIdx", dto.getScoreIdx());
		
		return map;		
	}
	
	@RequestMapping(value="/gpa/deleteGpa", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteGpa(
			@RequestParam int scoreIdx,
			HttpSession session
			)throws Exception{
		
		Map<String, Object> model = new HashMap<>();
		int res = service.deleteGpa(scoreIdx);
		String state="false";
		if(res!=0)
			state="true";
		model.put("state", state);
		return model;		
	}
	
	
	
	@RequestMapping(value="/gpa/gpaLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> gpaLike(
			Gpa dto,
			HttpSession session
			)throws Exception {
		
		int result=service.insertGpaLike(dto);
		
		String state="true";
		if(result==0){
			state="only";
		}
		
		Map<String, Object> map = new HashMap<>();				
	
		map.put("dto", dto);
		map.put("memberIdx", dto.getMemberIdx());
		map.put("scoreIdx", dto.getScoreIdx());
		map.put("state", state);
		
		return map;		
	}
	
	@RequestMapping(value="/gpa/gpaReport",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> gpaReport(
			Gpa dto,
			HttpSession session
			)throws Exception {
		
		int result=service.insertGpaReport(dto);
		
		String state="true";
		if(result==0) {
			state="only";
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("dto", dto);
		map.put("state", state);
		map.put("memberIdx", dto.getMemberIdx());
		map.put("scoreIdx", dto.getScoreIdx());
		map.put("content", dto.getContent());
		
		return map;	
	}
	
	@RequestMapping(value="/gpa/movieLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> movieLike(
			Gpa dto,
			HttpSession session
			) throws Exception {
		
		int result=service.insertMovieLike(dto);
		
		String state="true";
		if(result==0) {
			state="only";
		}
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("dto", dto);
		map.put("state", state);
		map.put("movieIdx", dto.getMovieIdx());
		map.put("memberIdx", dto.getMemberIdx());
		
		return map;		
	}
	
	
	
	
}
