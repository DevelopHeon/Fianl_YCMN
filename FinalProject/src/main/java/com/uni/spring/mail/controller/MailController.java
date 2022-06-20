package com.uni.spring.mail.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.uni.spring.common.CommException;
import com.uni.spring.common.Pagination;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.mail.model.dto.Mail;
import com.uni.spring.mail.model.dto.ReceiveMail;
import com.uni.spring.mail.model.service.MailService;

import lombok.RequiredArgsConstructor;

@SessionAttributes("loginUser")
@RequiredArgsConstructor
@Controller
public class MailController {
//	Employee emp = (Employee)session.getAttribute("loginUser");
//	int empNo = emp.getEmpNo();
	
	private final MailService mailService;
	
	//메일작성폼
	@RequestMapping("writeMail.do")
	public String writeMail(HttpSession session) {
		
		return "mail/writeMail";
	}
	
	//메일작성 완
	@RequestMapping("insertMail.do")
	public String insertMail(Mail mail,
							 HttpSession session,
							 HttpServletRequest request, 
							 Model model,
							 @RequestParam(name="upfile", required=false) MultipartFile file) {
		//메일 잘 들어오는지 확인
		System.out.println(mail);
		
		Attachment attachment = null;
		if(!file.getOriginalFilename().equals("")) { //첨부파일에 업로드가 되었다면
			//attachment에 파일을 저장
			attachment = saveFile(file, request);
			
			if(attachment != null) {
				mail.setFileName(file.getOriginalFilename());
				attachment.setEmpNo(String.valueOf(mail.getEmpNo()));
			}
		}
		
		mailService.insertMail(mail, attachment);
		
		session.setAttribute("msg", "메일 작성 완료");
		return "mail/writeMail";
	}
	
	//첨부파일저장
	private Attachment saveFile(MultipartFile file, HttpServletRequest request) {
		
		Attachment attachment = new Attachment();
		
		String resources = request.getSession().getServletContext().getRealPath("resources");
		System.out.println("resources : " + resources);
		
		String savePath = resources + "\\mailUpload_files\\";
		
		String originName = file.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String ext = originName.substring(originName.lastIndexOf("."));//ex)meta.jpg -> .jpg
		
		String changeName = currentTime + ext;
		System.out.println("changeName : " + changeName);
		
		attachment.setFilePath(savePath);
		attachment.setOriginName(originName);
		attachment.setChangeName(changeName);
		try {
			
			file.transferTo(new File(savePath + changeName));
			
		} catch (IllegalStateException | IOException e) {
			
			e.printStackTrace();
			throw new CommException("파일 업로드 실패");
		}
		return attachment;
	}
	
	//보낸메일함
	@RequestMapping("sendMail.do")
	public String sendMail(@RequestParam(value="currentPage", defaultValue="1")int currentPage,
						   HttpSession session,
						   Model model) {
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		
		int listCount = mailService.selectSendListCount();
		int boardLimit = 5;
		int pageLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<ReceiveMail> sendList = mailService.selectSendList(empNo, pi);
		return "mail/sendMail";
	}
	
	
	//받은메일함
	@RequestMapping("receiveMail.do")
	public String receiveMail() {
		return "mail/receiveMail";
	}

	//휴지통
	@RequestMapping("deleteMail.do")
	public String deleteMail() {
		return "mail/deleteMail";
	}

}
