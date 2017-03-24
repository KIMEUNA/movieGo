package com.moviego.reserve;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviego.member.SessionInfo;

@Controller("reserveController")
public class ReserveController {
	
	@Autowired
	private ReserveService service;
	
	@RequestMapping(value="/reserve", method=RequestMethod.GET)
	public String reserveForm(Model model, 
											String login_error, HttpSession session
											) throws Exception {
		boolean loginError = login_error != null;
		String errorMsg = "none";
		if (loginError) {
			AuthenticationException ex = (AuthenticationException) session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
			errorMsg = ex != null ? ex.getMessage() : "none";
		}
		String msg = "";
		if (loginError) {
			if ("Bad credentials".equals(errorMsg)) {
				msg = "아이디 또는 패스워드를 잘못 입력 하셨습니다.";
			} else {
				msg = "로그인 에러 : " + errorMsg;
			}
		}
		model.addAttribute("message", msg);
		model.addAttribute("title", "예매");
		
		return ".reserve.reservation";
	}
	
	@RequestMapping(value="/reserveStep1", method=RequestMethod.POST)
	public String reserveStep1(
					Reserve dto,
					@RequestParam(defaultValue="-1") int dateIdx,
					@RequestParam(defaultValue="") String date,
					@RequestParam(defaultValue="rank") String serachKey,
					Model model
			) {
		// 클라이언트의 요청을 AJAX로 처리.
		Map<String, Object> map = new HashMap<>();
		
		if(!date.equals("")) {
			String[] buf = date.split("\\.");
			
			buf[1] = (buf[1].length() < 2 ? "0" : "") + buf[1];
			buf[2] = (buf[2].length() < 6 ? "0" : "") + buf[2];
			date = buf[0]+"."+buf[1]+"."+buf[2].substring(0, 2);
			map.put("date", date);
		}
		
		if(dto.getCinemaIdx() != 0) 
			map.put("cinemaIdx", dto.getCinemaIdx());
		List<Reserve> movieList = service.getMovieList(map);
		
		if(dto.getMovieIdx() != 0)
			map.put("movieIdx", dto.getMovieIdx());
		
		List<Reserve> cityList = service.getCityList(map);
		
		if(dto.getCityIdx() == 0)
			dto.setCityIdx(cityList.get(0).getCityIdx());
		map.put("cityIdx", dto.getCityIdx());
		
		List<Reserve> cinemaList = service.getCinemaList(map);
		List<Reserve> dateList = service.getDateList(map);
		
		List<Integer> mIdxList = new ArrayList<>();
		List<Integer> cIdxList = new ArrayList<>();
		for (Reserve rr : movieList) 
			mIdxList.add(rr.getMovieIdx());
		for (Reserve rr : cinemaList)
			cIdxList.add(rr.getCinemaIdx());
		map.put("cIdxList", cIdxList);
		
		List<Reserve> noneMovies = null;
		List<Reserve> noneCinemas = null;
		
		if(mIdxList.size() != 0)
			noneMovies = service.getNoneMovies(mIdxList);	// dimmed 효과를 주기 위한 객체.
		if(cIdxList.size() != 0)
			 noneCinemas = service.getNoneCinemas(map);	// dimmed 효과를 주기 위한 객체.
		
		model.addAttribute("dto", dto);
		model.addAttribute("dateIdx", dateIdx);
		model.addAttribute("noneMovies", noneMovies);
		model.addAttribute("noneCinemas", noneCinemas);
		model.addAttribute("movieList", movieList);
		model.addAttribute("cityList", cityList);
		model.addAttribute("cinemaList", cinemaList);
		model.addAttribute("dateList", dateList);
		
		return "reserve/reserveForm";
	}
	
	@RequestMapping(value="/reserveStep2", method=RequestMethod.POST)
	public String reserveStep2(
						@RequestParam int scheduleIdx,
						Model model
			) {
		// 영화, 상영관, 시간을 선택 후 좌석선택 화면으로 넘어간다.
		Reserve dto = service.getSeat(scheduleIdx);
		List<Reserve> priceList = service.getPrice(scheduleIdx);
		String price="";
		String kind="";
		for (Reserve rr : priceList) { 
			price+=rr.getPrice()+",";
			kind+=rr.getKind()+",";
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("price", price);
		model.addAttribute("kind", kind);
		
		return "reserve/seatForm";
	}
	
	@RequestMapping(value="/reserveStep3", method=RequestMethod.POST)
	public String reserveStep3(Reserve dto, HttpSession session, Model model) {
		// 결제 화면으로 넘어간다.
		// 좌석, 금액, 예매정보
		// 회원 정보 -> 포인트 
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		if(info==null) {
			model.addAttribute("state", "false");
			return "reserve/reserveForm";
		}
		
		String seats = "";
		for (int i = 0; i < dto.getSeats().size(); i++) {
			seats+=dto.getSeats().get(i);
			if(i+1 < dto.getSeats().size())
				seats+=",";
		}
		
		int point = service.getPoint(info.getMemberIdx());
		
		model.addAttribute("dto", dto);
		model.addAttribute("point", point);
		model.addAttribute("seats", seats);
		
		return "reserve/paymentForm";
	}
	
	@RequestMapping(value="/reserve/reserveCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reserveCheck(Reserve dto, HttpSession session) {
		
		// 예매 확인.
		// 영화명, 극장, 상영관, 일시, 인원, 좌석, 결제금액, 결제수단, 총결제금액
		Reserve info = service.getReserveInfo(dto.getScheduleIdx());
		
		dto.setCinemaName(info.getCinemaName());
		dto.setMultiplexName(info.getMultiplexName());
		dto.setMovieName(info.getMovieName());
		dto.setPoster(info.getPoster());
		dto.setStartTime(info.getStartTime());
		
		String seats = "";
		for (int i = 0; i < dto.getSeats().size(); i++) {
			seats+=dto.getSeats().get(i);
			if(i+1 < dto.getSeats().size())
				seats+=", ";
		}
		
		Map<String, Object> model = new HashMap<>();
		
		model.put("dto", dto);
		model.put("seats", seats);
		
		return model;
	}
	
	@RequestMapping(value="/reserve/paymentSubmit", method=RequestMethod.POST)
	public String paymentSubmit(Reserve dto, Model model) throws Exception{
		service.insertReserve(dto);
		model.addAttribute("dto", dto);
		return "reserve/reserveResult";
	}
	
	@RequestMapping(value="/reserve/schedule", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> schedule(
							@RequestParam int movieIdx,
							@RequestParam int cinemaIdx,
							@RequestParam String date
				){
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("movieIdx", movieIdx);
		map.put("cinemaIdx", cinemaIdx);
		if(!date.equals("")) {
			String[] buf = date.split("\\.");
			
			buf[1] = (buf[1].length() < 2 ? "0" : "") + buf[1];
			buf[2] = (buf[2].length() < 6 ? "0" : "") + buf[2];
			date = buf[0]+"."+buf[1]+"."+buf[2].substring(0, 2);
			map.put("date", date);
		}
		
		List<Reserve> scheduleList = service.getScheduleList(map);
		
		for (Reserve rr : scheduleList) {
			System.out.println(rr.toString());
		}
		
		Map<String, Object> model = new HashMap<>();
		
		model.put("scheduleList", scheduleList);
		
		return model;
	}
	@RequestMapping(value="/reserveInfo", method=RequestMethod.POST)
	public String reserveInfo(
					Reserve dto,
					@RequestParam(defaultValue="") String date,
					Model model
			) {
		// 예매 정보 나타내기.
		Reserve movie = null;
		Reserve cinema = null;
		
		movie = service.getMovie(dto.getMovieIdx());
		cinema = service.getCinema(dto.getCinemaIdx());
		
		model.addAttribute("movie", movie);
		model.addAttribute("cinema", cinema);
		model.addAttribute("date", date);
		
		return "reserve/reserveInfo";
	}
	
	@RequestMapping(value="/reserve/timeInfo", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> timeInfo(@RequestParam int scheduleIdx) {
		Reserve dto = service.getTimeInfo(scheduleIdx);
		Map<String, Object> model = new HashMap<>();
		model.put("date", dto.getStartTime());
		model.put("multiplexName", dto.getMultiplexName());
		return model;
	}
	
	@RequestMapping(value="/reserveState", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reserveState(@RequestParam int scheduleIdx) {
		// 현재 예약된 좌석 정보를 가져 온다.List<Reserve> list = service.reservationState(scheduleIdx);
		List<Reserve> list = service.reserveState(scheduleIdx);
		Map<String, Object> model = new HashMap<>();
		model.put("list", list);
		return model;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
