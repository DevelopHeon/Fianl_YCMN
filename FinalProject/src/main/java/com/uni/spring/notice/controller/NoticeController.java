package com.uni.spring.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;
import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.notice.model.dto.Notice;
import com.uni.spring.notice.model.service.NoticeService;

import ch.qos.logback.classic.Logger;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class NoticeController {
	
	private final NoticeService noticeService;
	private static final Logger log=(Logger) LoggerFactory.getLogger(NoticeController.class);
	
	// 공지사항 목록 페이지로 전환 메소드
	@RequestMapping("listNotice.do")
	public String selectNoticeList(@RequestParam(value="rownum", required = false, defaultValue = "5") 
			int rownum, Model model){
		
		log.info("rownum:" + rownum);
		ArrayList<Notice> list = noticeService.selectNoticeList(rownum);
		model.addAttribute("list", list);
		
		return "companyBoard/noticeListView";
	}
	
	@ResponseBody
	@RequestMapping(value="selectNoticeList.do", produces="application/json; charset=utf-8")
	public String selectNoticeViewMore(int rownum) {
		
		log.info("rownu 확인" + String.valueOf(rownum));
		ArrayList<Notice> list = noticeService.selectNoticeList(rownum);
		
		for(Notice n : list) {
			log.info(n.toString());
		}
		return new GsonBuilder().setDateFormat("yyyy-MM-dd").create().toJson(list);
	}
	
	@RequestMapping("enrollFormNotice.do")
	public String enrollFormNotice() {
		return "companyBoard/noticeEnrollForm";
	}
	
	@RequestMapping("insertNotice.do")
	public String insertNotice(Notice notice, HttpServletRequest request,
			@RequestParam(name="uploadFile", required=false) MultipartFile file) {
		log.info(file.getOriginalFilename());
		// 첨부파일 있을경우에 save 메소드 실행
		Attachment attachment = null;
		if(!file.getOriginalFilename().equals("")) {
			attachment = saveFile(file, request);
			
			if(attachment != null) {
				attachment.setEmpNo(notice.getNoticeWriter());
			}
		}
		noticeService.insertNotice(notice, attachment);
		return "redirect:listNotice.do";
	}

	private Attachment saveFile(MultipartFile file, HttpServletRequest request) {
		
		Attachment at = new Attachment();
		
		String resources = request.getSession().getServletContext().getRealPath("resources");
		// 실제 파일 저장 경로
		String savePath = resources + "\\noticeUpload_files\\";
		String originName = file.getOriginalFilename();
		// 파일 Change명으로 사용할 현재시간 format을 이용해서 담아준다.
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		String changeName = currentTime + ext;
		
		// 첨부파일 객체 반환해줄거임 여기서 필요한것들 전부 set해준다.
		at.setFilePath(savePath);
		at.setOriginName(originName);
		at.setChangeName(changeName);
		
		// transferTo를 사용해서 실제 폴더 저장
		try {
			file.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			throw new CommException("파일 업로드 에러");
		}
		return at;
	}
	
	// 상세페이지 전환 메소드
	@RequestMapping("detailNotice.do")
	public ModelAndView selectNotice(int noticeNo, ModelAndView mv) {
		
		Notice notice = noticeService.selectNotice(noticeNo);
		mv.addObject("notice", notice).setViewName("companyBoard/noticeDetailView");
		log.info(notice.toString());
		return mv;
	}
	
	@RequestMapping("updateFormNotice.do")
	public ModelAndView updateForm(int noticeNo, ModelAndView mv) {
		
		mv.addObject("notice", noticeService.selectNotice(noticeNo))
		.setViewName("companyBoard/noticeUpdateForm");
		
		return mv;
	}
	
	@RequestMapping("updateNotice.do")
	public ModelAndView updateNotice(Notice notice, ModelAndView mv, HttpServletRequest request,
			@RequestParam(name="reUploadFile", required=false) MultipartFile file) {
		
		Attachment attachment = null;
		// 새로운 첨부파일이 존재할 경우 첨부파일 등록 
		if(!file.getOriginalFilename().equals("")) {
			attachment = saveFile(file, request);
			
			if(attachment != null) {
				attachment.setEmpNo(notice.getNoticeWriter());
				attachment.setRefNo(notice.getNoticeNo());
			}
		}
		String orgChangeName = notice.getChangeName();
		// 기존에 첨부파일이 존재할경우 기존파일 삭제
		if(orgChangeName != null) {
			deleteFile(orgChangeName, request);
		}
		noticeService.updateNotice(notice, attachment);
		
		mv.addObject("noticeNo", notice.getNoticeNo())
				.setViewName("redirect:detailNotice.do");
		return mv;
	}

	private void deleteFile(String orgChangeName, HttpServletRequest request) {
		String resources = request.getSession().getServletContext().getRealPath("resources");
		
		String savePath = resources + "\\noticeUpload_files\\";
		
		File deleteFile = new File(savePath + orgChangeName);
		
		deleteFile.delete();
	}
	
	@RequestMapping("deleteNotice.do")
	public String deleteNotice(int noticeNo, String fileName, HttpServletRequest request) {
		
		log.info(fileName);
		
		noticeService.deleteNotice(noticeNo);
		if(fileName != null) {
			noticeService.deleteAttachment(noticeNo);
			deleteFile(fileName, request);
		}
		
		return "redirect:listNotice.do";
	}
	
	@ResponseBody
	@RequestMapping(value="mainListNotice.do", produces="application/json; charset=utf-8")
	public String selectMainList() {
		int rownum = 10;
		
		ArrayList<Notice> list = noticeService.selectNoticeList(rownum);
		
		return new GsonBuilder().setDateFormat("yyyy-MM-dd").create().toJson(list);
	}
}
