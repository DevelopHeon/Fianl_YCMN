package com.uni.spring.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ApprovalController {
	
	// 결재신청 양식목록 화면전환
	@RequestMapping("approvalList.do")
	public String approvalList() {
		return "Approval/approvalListView";
	}
	
	// 결재 작성 화면 이동
	@RequestMapping("approvalWrite.do")
	public String approvalWrite(int ano) {
		
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
}
