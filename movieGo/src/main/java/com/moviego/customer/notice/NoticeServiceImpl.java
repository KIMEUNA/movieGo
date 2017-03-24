package com.moviego.customer.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;

@Service("notice.noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result=dao.getIntValue("notice.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Notice> noticeList(Map<String, Object> map) {
		List<Notice> list = null;
		
		try {
			list=dao.getListData("notice.noticeList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Notice> noticeListTop() {
		List<Notice> list = null;
		
		try {
			list=dao.getListData("notice.noticeListTop");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int updateHitCount(int noticeIdx) {
	int result=0;
		
		try {
			result=dao.updateData("notice.updateHitCount", noticeIdx);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Notice readNotice(int noticeIdx) {
		Notice dto = null;
		
		try {
			dto=dao.getReadData("notice.readNotice", noticeIdx);  

		} catch (Exception e) {
		}
		return dto;

	}

	@Override
	public Notice preReadNotice(Map<String, Object> map) {
		Notice dto = null;
		
		try {
			dto=dao.getReadData("notice.preReadNotice", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Notice nextReadNotice(Map<String, Object> map) {
		Notice dto = null;
		
		try {
			dto=dao.getReadData("notice.nextReadNotice", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public List<Notice> listFile(int noticeIdx) {
		List<Notice> listFile=null;
		
		try {
			listFile=dao.getListData("notice.listFile", noticeIdx);  // 여기서 mapper로 들어가서 쿼리문을 실행한다..
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return listFile;
	}

	@Override
	public Notice readFile(int fileIdx) {
		Notice dto=null;
		
		try {
			dto=dao.getReadData("notice.readFile", fileIdx);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}


}

