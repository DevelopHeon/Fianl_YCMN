package com.uni.spring.approval.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.uni.spring.approval.model.dto.ApperAccount;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalEr;
import com.uni.spring.approval.model.serivce.ApprovalService;
import com.uni.spring.employee.model.service.EmployeeService;

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
	@RequestMapping("enrollFormApproval.do")
	public String enrollFormApproval(int ano) {
		
		String approvalForm= "";
		
		// 화면에서 번호를 받아 각 번호에 맞는 양식 화면으로 이동
		if(ano == 1) {
			approvalForm = "approvalLeaveForm";
		}else if(ano == 2) {
			approvalForm = "approvalErFrom";
		}else {
			approvalForm = "approvalReport";
		}
		
		return "Approval/"+approvalForm;
	}
	
	// 지출결의서 작성메소드
	@RequestMapping("insertErApproval.do")
	public String insertErApproval(Approval approval, ApprovalEr approvalErs, ApperAccount apperAccount, 
			HttpServletRequest request, @RequestParam(name="uploadFile") MultipartFile file) {
		
		System.out.println("approval : " + approval + ", apperAccount : " + apperAccount + ", file : " + file.getOriginalFilename());
		System.out.println("approvalEr : " + approvalErs);
		
		approvalService.insertErApproval(approval, approvalErs, apperAccount);
		
		return null;
	}
}
