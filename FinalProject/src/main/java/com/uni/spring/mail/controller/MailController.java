package com.uni.spring.mail.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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
	public String writeMail(@RequestParam(name="eno", required=false)String empNo,
							@ModelAttribute("mail") Mail mail,
							HttpSession session,
							Model model) {
		//주소록에서 사원에게 메일쓰기를 클릭할때(empDetail, writeMail)
		if(empNo != null) {
			//필요한 것 : 사원번호, 이름
			//eno는 주소록에서 작성할때만 필요하므로 required=false로 두어야함
			//이때 required= false는  파라미터 값으로 int형을 받을 수 없다 -> string으로 쓰고 인자값에서 다시 int형변환
			Employee emp = mailService.selectChoiceMail(Integer.parseInt(empNo));
			model.addAttribute("emp", emp);
		}
		model.addAttribute("mail", mail);
		
		return "mail/writeMail";
	}
	
	//메일작성 완
	@RequestMapping("insertMail.do")
	public String insertMail(@ModelAttribute("mail") @Valid Mail mail,
			                 BindingResult result,
							 HttpSession session,
							 HttpServletRequest request, 
							 Model model,
							 @RequestParam(name="upfile", required=false) MultipartFile file) {
		//메일 잘 들어오는지 확인
		System.out.println(mail);
		//유효성 검사. 에러 있을 경우 작성한 내용이 날아가지 않고 다시 리턴
		if(result.hasErrors()) {
			return "mail/writeMail";
		}
		mail.setMailContent(mail.getMailContent().replaceAll("\n", "<br>"));
		
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
		
		session.setAttribute("msg", "메일이 전송되었습니다.");
		return "redirect:sendMail.do";
	}
	
	//메일 첨부파일 이미지
	@RequestMapping("mailUploadImg.do")
	public void smarteditorMultiImageUpload(HttpServletRequest request, HttpServletResponse response){
		try {
			//파일정보
			String sFileInfo = "";
			//파일명을 받는다 - 일반 원본파일명
			String sFilename = request.getHeader("file-name");
			//파일 확장자
			String sFilenameExt = sFilename.substring(sFilename.lastIndexOf(".")+1);
			//확장자를소문자로 변경
			sFilenameExt = sFilenameExt.toLowerCase();
				
			//이미지 검증 배열변수
			String[] allowFileArr = {"jpg","png","bmp","gif"};

			//확장자 체크
			int cnt = 0;
			for(int i=0; i<allowFileArr.length; i++) {
				if(sFilenameExt.equals(allowFileArr[i])){
					cnt++;
				}
			}

			//이미지가 아니라면
			if(cnt == 0) {
				PrintWriter print = response.getWriter();
				print.print("NOTALLOW_"+sFilename);
				print.flush();
				print.close();
			} else {
				//디렉토리 설정 및 업로드	
				
				//파일경로
				String filePath = request.getSession().getServletContext().getRealPath("resources");
				String savePath = filePath + "\\mailUpload_files\\";
				File file = new File(savePath);
				
				if(!file.exists()) {
					file.mkdirs();
				}
				
				String sRealFileNm = "";
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
				String today= formatter.format(new java.util.Date());
				sRealFileNm = today+UUID.randomUUID().toString() + sFilename.substring(sFilename.lastIndexOf("."));
				String rlFileNm = savePath + sRealFileNm;
				
				///////////////// 서버에 파일쓰기 ///////////////// 
				InputStream inputStream = request.getInputStream();
				OutputStream outputStream=new FileOutputStream(rlFileNm);
				int numRead;
				byte bytes[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
				while((numRead = inputStream.read(bytes,0,bytes.length)) != -1){
					outputStream.write(bytes,0,numRead);
				}
				if(inputStream != null) {
					inputStream.close();
				}
				outputStream.flush();
				outputStream.close();
				
				///////////////// 이미지 /////////////////
				// 정보 출력
				sFileInfo += "&bNewLine=true";
				// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
				sFileInfo += "&sFileName="+ sFilename;
				sFileInfo += "&sFileURL=/resources/mailUpload_files"+sRealFileNm;
				PrintWriter printWriter = response.getWriter();
				printWriter.print(sFileInfo);
				printWriter.flush();
				printWriter.close();
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
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
		int boardLimit = 10;
		int pageLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		//보낸메일함 리스트(수신,참조,비참까지 다 보이게)
		ArrayList<ReceiveMail> sendList = mailService.selectSendList(empNo, pi);
//
//		for(int i = 0; i < sendList.size(); i++) {
//			sendList.get(i).getReceiver()
//		}
		
		
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
		int boardLimit = 10;
		int pageLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		model.addAttribute("pi", pi);

		//받은메일함 리스트
		ArrayList<ReceiveMail> receiveList = mailService.selectReceiveList(empNo, pi);
		
		//전체 메일수
		int total = mailService.selectTotalMail(empNo);
	
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("total", total);
		//미확인 메일 수
		int unread = mailService.selectUnreadMail(empNo);
		model.addAttribute("unread", unread);
		
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
	public String detailReceiveMail(@RequestParam("mno")int receiveNo,
									@ModelAttribute("loginUser")Employee emp,
									Model model) {
		int empNo = emp.getEmpNo();
		//메일확인
		ReceiveMail receiveMail = mailService.selectReceiveMail(receiveNo);
		model.addAttribute("rMail", receiveMail);

		int unread = mailService.selectUnreadMail(empNo);
		model.addAttribute("unread", unread);
		return "mail/ReceiveDetailView";
	}
	
	//받은메일조회에서 삭제
	@RequestMapping("deleteRMail.do")
	public String deleteRMail(@RequestParam("receiveNo")int receiveNo, Model model) {

		mailService.updateTrashRMail(receiveNo);
	
		return "redirect:receiveMail.do";
	}
	
	//받은메일함 즐겨찾기
	@RequestMapping("starMail.do")
	public String starMail(@RequestParam("starM")int receiveNo, Model model) {
		
		mailService.updateStarMail(receiveNo);

		return "redirect:receiveMail.do";
	}

	//휴지통에서 영구 삭제
	@RequestMapping("realDelete.do")
	public String realDelete(@RequestParam("checkNo")List<Integer> list,
			  				 Model model) {
		
		for(int receiveNo : list) {
			System.out.println(list);
			mailService.realDelete(receiveNo);
		}
			return "redirect:deleteMail.do";
	}
	
	//받은메일 답장
	@RequestMapping("writeReplyForm.do")
	public ModelAndView writeReplyForm(@ModelAttribute("mail") Mail mail, int receiveNo, ModelAndView mv) {
		ReceiveMail receiveMail = mailService.selectReceiveMail(receiveNo);
	
		mv.addObject("reply", receiveMail).setViewName("mail/writeReply");

		return mv;
	}
	
	//메인_상단메일알림
	@ResponseBody
	@RequestMapping("mainMailList.do")
	public ArrayList<ReceiveMail> mainMailList(Model model, HttpSession session) {
		Employee emp = (Employee)session.getAttribute("loginUser");
		int empNo = emp.getEmpNo();
		
		ArrayList<ReceiveMail> mailList = mailService.selectMainMailList(empNo);
		
		return mailList;
	}
}