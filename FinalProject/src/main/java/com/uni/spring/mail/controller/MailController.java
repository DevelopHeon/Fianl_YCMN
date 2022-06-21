package com.uni.spring.mail.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
		//보낸메일함 페이징처리
		int listCount = mailService.selectSendListCount(empNo);
		int boardLimit = 5;
		int pageLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		//보낸메일함 리스트(수신,참조,비참까지 다 보이게)
		ArrayList<ReceiveMail> sendList = mailService.selectSendList(empNo, pi);
		
		model.addAttribute("sendList", sendList);
		model.addAttribute("pi", pi);

		return "mail/sendMail";
	}
	
	
	//받은메일함
	@RequestMapping("receiveMail.do")
	public String receiveMail(@RequestParam(value="currentPage", defaultValue="1")int currentPage,
			   				  HttpSession session,
			   				  Model model) {
		
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		//받은메일함 페이징처리
		int listCount = mailService.selectReceiveListCount(empNo);
		int boardLimit = 5;
		int pageLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		//받은메일함 리스트
		ArrayList<ReceiveMail> receiveList = mailService.selectReceiveList(empNo, pi);
		
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("pi", pi);

		
		return "mail/receiveMail";
	}

	//휴지통
	@RequestMapping("deleteMail.do")
	public String deleteMail(HttpSession session,
							 Model model) {
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();

		ArrayList<ReceiveMail> trashMail = mailService.selectDeleteList(empNo);
		
		model.addAttribute("trashMail",trashMail);
		
		return "mail/deleteMail";
	}
	
	
	//보낸메일List에서 삭제
	@RequestMapping("deleteTrashSMail.do")
	public String deleteTrashSMail(@RequestParam("checkNo")List<Integer> list,
								  Model model) {
		
		for(int receiveNo : list) {
			System.out.println(list);
			mailService.updateTrashSMail(receiveNo);
		}
		return "redirect:sendMail.do";
	}
	
	//보낸메일조회(detail)
	@RequestMapping("detailSendMail.do")
	public String detailSendMail(@RequestParam("mno")int mailNo, 
								 Model model) {
		
		//메일확인
		ReceiveMail sendMail = mailService.selectSendMail(mailNo);
		
		model.addAttribute("sMail", sendMail);
		return "mail/SendDetailView";
	}

	
	//받은메일List에서 삭제
	@RequestMapping("deleteTrashRMail.do")
	public String deleteTrashRMail(@RequestParam("checkNo")List<Integer> list,
								  Model model) {
		
		for(int receiveNo : list) {
			System.out.println(list);
			mailService.updateTrashRMail(receiveNo);
		}
		return "redirect:receiveMail.do";
	}
	
	//받은메일조회(detail)
	@RequestMapping("detailReceiveMail.do")
	public String detailReceiveMail(@RequestParam("mno")int receiveNo, Model model) {
		
		//메일확인
		ReceiveMail receiveMail = mailService.selectReceiveMail(receiveNo);
		
		model.addAttribute("rMail", receiveMail);
		return "mail/ReceiveDetailView";
	}
	
	//받은메일조회에서 삭제
	@RequestMapping("deleteRMail.do")
	public String deleteRMail(@RequestParam("receiveNo")int receiveNo, Model model) {

		mailService.updateTrashRMail(receiveNo);
	
		return "redirect:receiveMail.do";
	}
	


}
