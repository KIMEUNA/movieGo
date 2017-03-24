package com.moviego.customer.notice;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.moviego.common.FileManager;
import com.moviego.common.MyUtil;

@Controller("notice.noticeController")
public class NoticeController {
	
	@Autowired
	private NoticeService service;
	@Autowired
	private MyUtil myutil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/notice/noticeList")  //사용자가 도메인 입력창에 작성하는 주소
	public String list(
			@RequestParam(value="page", defaultValue="1")int current_page,
			@RequestParam(value="searchKey", defaultValue="subject")String searchKey, 
			@RequestParam(value="searchValue", defaultValue="")String searchValue, 
				Model model, 
				HttpServletRequest req
			) throws Exception{
		
		String cp = req.getContextPath();
		
		int numPerPage=20;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		//전체 페이지 수 
		Map<String, Object> map =  new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		//데이터 개수
		dataCount = service.dataCount(map);
		if(dataCount!=0){
			total_page= myutil.pageCount(numPerPage, dataCount);
		}
		
		//다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if(total_page<current_page){
			total_page=current_page;
		}
		
		// 1페이지인 경우 공지리스트 가져오기
		List<Notice> noticeList = null;  //Notice 객체만 저장(다른건 불가)
		if(current_page==1){
			noticeList=service.noticeListTop(); //공지리스트 가져오기
		}
		
		//리스트에 출력할 데이터를 가져오기 
		int start = (current_page-1) * numPerPage +1; 
		int end = current_page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		
		//글리스트
		List<Notice> list = service.noticeList(map);  // 디비에서 리스트 가져오기
		
		// 리스트의 번호
		Date endDate = new Date();
		long gap;   // 한시간 전에 등록한 것을 글 리스트에서 new이미지 보이게 하기 위함
		int listNum, n = 0;
		Iterator<Notice> it =list.iterator();
		while(it.hasNext()){
			Notice data =it.next();
			listNum = dataCount - (start +n -1); 
			data.setListNum(listNum);
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
			Date beginDate = formatter.parse(data.getRegDate());
			
			gap=(endDate.getTime()- beginDate.getTime())/(60*60*1000);
			data.setGap(gap);
			
			data.setRegDate(data.getRegDate().substring(0, 10));
			n++;
		}
		
		String params="";
		String urlList=cp+"/notice/noticeList";  //리스트 주소
		String urlArticle = cp + "/notice/article?page=" + current_page;  //글보기 주소
		if(searchValue.length()!=0){
			params="searchKey="+ searchKey +
					"&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		if(params.length() !=0){
			urlList = cp+"/notice/noticeList?"+params;
			urlArticle = cp+"/notice/article?page="+ current_page+ "&" + params;
		}
		
		String paging=myutil.paging(current_page, total_page, urlList);
		
		model.addAttribute("noticeList", noticeList); //공지리스트를 뷰에 전달   Model addAttribute(String name, Object value)  :  value 객체를 name 이름으로 추가 
		model.addAttribute("list", list);   // 리스트를 뷰에 전달
		model.addAttribute("urlArticle", urlArticle); //글보기주소 뷰에 전달
		model.addAttribute("page", current_page);  // 현재 페이지
		model.addAttribute("dataCount", dataCount); //데이터갯수
 		model.addAttribute("paging", paging);  // 페이지
	
		
	return ".notice.noticeList";   // 타일즈 3단구성으로 /notice/noticeList.jsp   view단으로 이동함.
	}
	
	@RequestMapping(value="/notice/article", method=RequestMethod.GET)
	public String article(
		@RequestParam(value="noticeIdx") int noticeIdx,
		@RequestParam(value="page", defaultValue="1") String page,
		@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
		@RequestParam(value="searchValue", defaultValue="") String searchValue,
			Model model
			) throws Exception{
		
		searchValue = URLDecoder.decode(searchValue, "utf-8");
		service.updateHitCount(noticeIdx);
		
		//조회수 증가
		Notice dto=service.readNotice(noticeIdx);
		
	    if(dto==null)																			  //dto 가 null이면
	    	new ModelAndView("redirect:/notice/noticeList?page="+page);  // 이페이지로 리다이렉트하라

	    dto.setContent(dto.getContent().replaceAll("\n", "<br>")); 
	    
	    
	    // 이전 글, 다음 글
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("searchKey", searchKey);   // map.put(key, value)
	    map.put("searchValue", searchValue);
	    map.put("noticeIdx", noticeIdx);
	    
	    Notice preReadDto = service.preReadNotice(map);  // 이전 글보기
	    Notice nextReadDto = service.nextReadNotice(map); // 다음 글보기
	    
	    //파일
	   List<Notice> listFile=service.listFile(noticeIdx);       //위 article의 인자값 noticeIdx를  listFile로 받아와서,
	    
	    String params = "page="+page;
	    if(searchValue.length()!=0){
	    	params += "&searchKey=" + searchKey + 
	    			"&searchValue="+ URLEncoder.encode(searchValue, "utf-8");
	    }
	    
	    model.addAttribute("dto", dto);
	    model.addAttribute("preReadDto", preReadDto);
	    model.addAttribute("nextReadDto",nextReadDto);
	    model.addAttribute("listFile", listFile);    //받아온 값을 넘겨주는것. jsp파일에 el 태그   ${listFile}이 있을거다.
	    model.addAttribute("page", page);
	    model.addAttribute("params", params);

	    return ".notice.article";
	}
	
	@RequestMapping(value="notice/download")
	public void download(  // 파일다운로드
			@RequestParam int fileIdx,
			HttpServletResponse resp,
			HttpSession session) throws Exception{
		
		//String root = session.getServletContext().getRealPath("/");
		//String pathname = root + File.separator + "uploads" + File.separator + "notice";
		
		String pathname = "c:"+ File.separator + "uploads" + File.separator + "notice";
		boolean b = false; 
		
		Notice dto = service.readFile(fileIdx);
		
		if(dto !=null) {
			
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
}
