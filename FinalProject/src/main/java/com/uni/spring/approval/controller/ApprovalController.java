package com.uni.spring.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.GsonBuilder;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.approval.model.dto.ApprovalLeave;
import com.uni.spring.approval.model.serivce.ApprovalService;
import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ApprovalController {
	
	// approvalService 사용 위해 생성자로 의존성 주입
	private final ApprovalService approvalService;
	
	// 결재신청 양식목록 화면전환
	@RequestMapping("approvalList.do")
	public String approvalList() {
		return "Approval/approvalListView";
	}
	
	// 결재 작성 화면 이동
	// 화면에서 검증 실패시에도 값 유지하기 위해 approval 객체 전달해준다.
	@RequestMapping("enrollFormApproval.do")
	public String enrollFormApproval(int ano, @ModelAttribute Approval approval) {
		
		String approvalForm= "";
		// 화면에서 번호를 받아 각 번호에 맞는 양식 화면으로 이동
		if(ano == 1) {
			approvalForm = "approvalLeaveForm";
		}else if(ano == 2) {
			approvalForm = "approvalErForm";
		}else {
			approvalForm = "approvalReport";
		}
		
		return "Approval/"+approvalForm;
	}
	
	/*
	 * 지출결의서 작성메소드 유효성 검사를 위해 @Valid를 추가 error나 BindingResult는 바인딩 받는 객체 바로 다음 선언해
	 * 주어야 한다. 몰라서 쌩쑈함
	 */
	@RequestMapping("insertErApproval.do")
	public String insertErApproval(@Valid Approval approval, BindingResult result, 
			ApprovalErs approvalErs, HttpServletRequest request, 
			@RequestParam(name="uploadFile") MultipartFile file, HttpSession session) {
		
		if(result.hasErrors()) {
			return "Approval/approvalErForm";
		}
		
		ArrayList<ApprovalErs> appers = new ArrayList<>();
		
		for(int i=0; i<approvalErs.getApprovalErs().size(); i++) {
			appers.add(approvalErs.getApprovalErs().get(i));
		}
		
		// 첨부파일 테이블에 추가해주기 위해 객체 생성
		Attachment attachment = null;
		// 공통으로 파일 저장시 사용할 메소드 생성
		attachment = saveFile(file, request);
		// changeName 잘 받아왔는지 확인 잘 받았을 경우 첨부파일테이블에 추가
		if(attachment != null) {
			attachment.setEmpNo(approval.getAppWriterNo());
		}
		approvalService.insertErApproval(approval, appers, attachment);
		session.setAttribute("msg", "지출결의서 작성 완료.");
		return "redirect:approvalList.do";
	}
	
	// 휴가 신청서는 첨부파일 선택 required=false 조건 걸어준다.
	@RequestMapping("insertLeaveApproval.do")
	public String insertLeaveApproval(@Valid Approval approval, BindingResult result, HttpServletRequest request,
			@RequestParam(name="uploadFile", required=false) MultipartFile file, HttpSession session) {

		if(result.hasErrors()) {
			return "Approval/approvalLeaveForm";
		}
		ApprovalLeave approvalLeave = approval.getApprovalLeave();
		
		Attachment attachment = null;
		// 파일 첨부 하지 않을경우 빈 문자열로 값이 넘어옴
		if(!file.getOriginalFilename().equals("")) {
			attachment = saveFile(file, request);
			
			if(attachment != null) {
				attachment.setEmpNo(approval.getAppWriterNo());
			}
		}
		
		approvalService.insertLeaveApproval(approval, approvalLeave, attachment);
		
		session.setAttribute("msg", "휴가신청서 작성 완료");
		return "redirect:approvalList.do";
	}

	// 파일 저장시 사용하는 메소드
	private Attachment saveFile(MultipartFile file, HttpServletRequest request) {
		
		Attachment at = new Attachment();
		
		String resources = request.getSession().getServletContext().getRealPath("resources");
		// 실제 파일 저장 경로
		String savePath = resources + "\\appUpload_files\\";
		String originName = file.getOriginalFilename();
		// 파일 Change명으로 사용할 현재시간 format을 이용해서 담아준다.
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		String changeName = currentTime + ext;
		System.out.println(changeName);
		
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

	@ResponseBody
	@RequestMapping(value="selectApprover.do", produces="application/json; charset=utf-8")
	public String selectApproverList(int empNo) {
		
		ArrayList<Employee> list = approvalService.selectApproverList(empNo);
		
		for(Employee e : list) {
			System.out.println(e);
		}
		return new GsonBuilder().create().toJson(list);
	}
}
