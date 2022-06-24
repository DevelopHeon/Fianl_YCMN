package com.uni.spring.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalErs;
import com.uni.spring.approval.model.dto.ApprovalLeave;
import com.uni.spring.approval.model.dto.ApprovalReport;
import com.uni.spring.approval.model.dto.Opinion;
import com.uni.spring.approval.model.dto.mapDto.ApprovalMap;
import com.uni.spring.approval.model.serivce.ApprovalService;
import com.uni.spring.common.CommException;
import com.uni.spring.common.Pagination;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;

import ch.qos.logback.classic.Logger;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ApprovalController {
	
	// approvalService 사용 위해 생성자로 의존성 주입
	private final ApprovalService approvalService;
	private static final Logger log=(Logger) LoggerFactory.getLogger(ApprovalController.class);
	
	// 결재신청 양식목록 화면전환
	@RequestMapping("approvalList.do")
	public String approvalList() {
		return "approval/approvalListView";
	}
	
	// 결재 작성 화면 이동
	// 화면에서 검증 실패시에도 값 유지하기 위해 approval 객체 전달해준다.
	@RequestMapping("approvalEnrollForm.do")
	public String enrollFormApproval(int ano, @ModelAttribute Approval approval) {
		
		String approvalForm= "";
		// 화면에서 번호를 받아 각 번호에 맞는 양식 화면으로 이동
		if(ano == 1) {
			approvalForm = "approvalLeaveEnrollForm";
		}else if(ano == 2) {
			approvalForm = "approvalErEnrollForm";
		}else {
			approvalForm = "approvalReportEnrollForm";
		}
		
		return "approval/"+approvalForm;
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
			return "approval/approvalErForm";
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
		return "redirect:listOutbox.do?userNo="+approval.getAppWriterNo();
	}
	
	// 휴가 신청서는 첨부파일 선택 required=false 조건 걸어준다.
	@RequestMapping("insertLeaveApproval.do")
	public String insertLeaveApproval(@Valid Approval approval, BindingResult result, HttpServletRequest request,
			@RequestParam(name="uploadFile", required=false) MultipartFile file, HttpSession session) {

		if(result.hasErrors()) {
			return "approval/approvalLeaveEnrollForm";
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
		return "redirect:listOutbox.do?userNo="+approval.getAppWriterNo();
	}
	
	@RequestMapping("insertReportApproval.do")
	public String insertReportApproval(@Valid
			 Approval approval, BindingResult result, HttpServletRequest request,
			@RequestParam(name="uploadFile", required=false) MultipartFile file, HttpSession session) {
		
		if(result.hasErrors()) {
			return "approval/approvalReportEnrollForm";
		}
		ApprovalReport approvalReport = approval.getApprovalReport();
		
		Attachment attachment = null;
		// 파일 첨부 하지 않을경우 빈 문자열로 값이 넘어옴
		if(!file.getOriginalFilename().equals("")) {
			attachment = saveFile(file, request);
			
			if(attachment != null) {
				attachment.setEmpNo(approval.getAppWriterNo());
			}
		}
		approvalService.insertReportApproval(approval, approvalReport, attachment);
		session.setAttribute("msg", "업무 보고서 작성 완료");
		
		return "redirect:listOutbox.do?userNo="+approval.getAppWriterNo();
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

	// 부서 목록 조회하는 메소드
	@ResponseBody
	@RequestMapping(value="selectDept.do", produces="application/json; charset=utf-8")
	public String selectDeptList() {
		ArrayList<Department> list = approvalService.selectDeptList();
		return new GsonBuilder().create().toJson(list);
	}
	//결재자 사원 목록 조회하는 메소드
	@ResponseBody
	@RequestMapping(value="selectApprover.do", produces="application/json; charset=utf-8")
	public String selectApproverList(int empNo) {
		Employee employee = new Employee();
		employee.setEmpNo(empNo);
		ArrayList<Employee> list = approvalService.selectApproverList(employee);
		return new GsonBuilder().create().toJson(list);
	}
	
	// 부서별 사원 목록 조회 메소드
	@ResponseBody
	@RequestMapping(value="selectDeptEmp.do", produces="application/json; charset=utf-8")
	public String selectDeptEmpList(Employee employee) {
		
		ArrayList<Employee> list = approvalService.selectApproverList(employee);
		
		return new GsonBuilder().create().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping(value="searchAppEmp.do", produces="application/json; charset=utf-8")
	public String selectSearchEmpList(Employee employee) {
		
		ArrayList<Employee> list = approvalService.selectApproverList(employee);
		
		return new GsonBuilder().create().toJson(list);
	}
	
	// 결재 상신함 목록 화면 전환 (자신이 결재 올린 문서 목록)
	@RequestMapping("listOutbox.do")
	public String selectMyApprovalList(@RequestParam(value="currentPage", required=false, defaultValue="1")
	int currentPage, int userNo, Model model){
		
		int listCount = approvalService.selectMyApprovalListCnt(userNo);
		PageInfo pi = getPage(listCount, currentPage);
		
		ArrayList<Approval> list = approvalService.selectMyApprovalList(pi, userNo); 
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "approval/approvalOutboxListView";
	}
	
	// 결재 수신함 목록 화면 전환 (승인해주어야하는 문서 목록)
	@RequestMapping("listInbox.do")
	public String selectApprovalInboxList(@RequestParam(value="currentPage", required=false, defaultValue="1")
	int currentPage, int userNo, Model model) {
		
		// dto 생성하지 않고 map으로 받아서 화면에 전달
		Map<String, Object> appStatusCnt = (HashMap<String, Object>)approvalService.appStatusCnt(userNo);
		
		log.info("맵으로 출력"+appStatusCnt.toString());
		
		int listCount = approvalService.selectApprovalInboxListCnt(userNo);
		PageInfo pi = getPage(listCount, currentPage);
		
		ArrayList<Approval> list = approvalService.selectApprovalInboxList(pi, userNo); 

		model.addAttribute("appCnt", appStatusCnt);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		return "approval/approvalInboxListView";
	}
	
	// 결재 반려함 목록 화면 전환
	@RequestMapping("listReturn.do")
	public String selectApprovalReturnList(@RequestParam(value="currentPage", required=false, defaultValue="1")
	int currentPage, int userNo, Model model) {
		
		int listCount = approvalService.selectApprovalReturnListCnt(userNo);
		PageInfo pi = getPage(listCount, currentPage);
		
		ArrayList<Approval> list = approvalService.selectApprovalReturnList(pi, userNo);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		return "approval/approvalReturnListView";
	}
	
	// 공통으로 사용할 페이징 메소드
	private PageInfo getPage(int listCount, int currentPage) {
		int pageLimit = 5;
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		return pi;
	}

	@RequestMapping("selectBoxList.do")
	public String selectBoxList(String appStatus, String appWriterNo, Model model) {
		
		log.info("종류 : " + appStatus + "사번 : " + appWriterNo);
		
		Approval approval = new Approval();
		approval.setAppStatus(appStatus);
		approval.setAppWriterNo(appWriterNo);
		
		int listCount = approvalService.selectBoxListCnt(approval);
		PageInfo pi = getPage(listCount, 1);
		
		ArrayList<Approval> list = approvalService.selectBoxList(approval, pi); 
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "approval/approvalOutboxListView";
	}
	
	@RequestMapping("selectInboxList.do")
	public ModelAndView selectInboxList(String appStatus, int userNo, ModelAndView mv) {
		
		Approval approval = new Approval();
		approval.setAppStatus(appStatus);
		approval.setAppWriterNo(String.valueOf(userNo));
		
		int listCount = approvalService.selectInBoxListCnt(approval);
		PageInfo pi = getPage(listCount, 1);
		
		ArrayList<Approval> list = approvalService.selectInBoxList(approval, pi);
		Map<String, Object> appStatusCnt = (HashMap<String, Object>)approvalService.appStatusCnt(userNo);
		
		mv.addObject("list", list).addObject("appCnt", appStatusCnt).addObject("pi", pi).setViewName("approval/approvalInboxListView");
		return mv;
	}
	
	//전자결재 문서 상세 조회 페이지 전환
	@RequestMapping("detailApproval.do")
	public String selectApproval(int appNo, String appKinds, Model model) {
		
		ApprovalMap appMap = approvalService.selectApproval(appNo, appKinds);
		// 지출증빙 내역은 여러개일 수도 있으므로 list타입으로 반환해준다.
		String viewName = "";
		// 첨부파일 조회 따로, 같이 join 해주려 했는데 실패함..
		Attachment at = approvalService.selectAppAttachment(appNo);
		appMap.setAttachment(at);
		
		if(appKinds.equals("2")) {
			// 여러개의 증빙내역 배열로 받아서 model 객체에 담아준다.
			ArrayList<ApprovalErs> appErs = approvalService.selectAppErs(appNo);
			model.addAttribute("list", appErs);
			viewName = "/approvalErDetailView";
		}else if(appKinds.equals("3")) {
			viewName = "/approvalLvDetailView";
		}else if(appKinds.equals("4")) {
			viewName = "/approvalRpDetailView";
		}
		model.addAttribute("appMap", appMap); 
		
		return "approval"+viewName;
	}
	
	// 결재 승인 메소드 로그인한 유저의 네임을 받아서 승인자란에 들어가있는 회원이름과 비교한다.
	@RequestMapping("approve.do")
	public ModelAndView updateFirstApprove(Approval approval,
			@RequestParam("approverConfirm") String appCf, ModelAndView mv) {
		
		int appNo = approval.getAppNo();
		
		if(approval.getFirstApprover().equals(appCf)) {
			approvalService.updateFirstApprove(appNo);
		}else {
			approvalService.updateLastApprove(appNo);
		}
		
		mv.addObject("appNo", approval.getAppNo()).addObject("appKinds", approval.getAppKinds()).
		setViewName("redirect:detailApproval.do");
		return mv;
	}
	
	// 반려 처리 메소드
	@RequestMapping("insertRejecter.do")
	public ModelAndView insertRejecter(Approval approval, ModelAndView mv) {
		
		approvalService.insertRejecter(approval);
		
		mv.addObject("appNo", approval.getAppNo()).addObject("appKinds", approval.getAppKinds()).
		setViewName("redirect:detailApproval.do");
		return mv;
	}
	
	// 수정화면 전환 메소드
	@RequestMapping("updateFormApproval.do")
	public String updateFormApproval(int appNo, Model model, String appKinds) {
		
		ApprovalMap appMap = approvalService.selectApproval(appNo, appKinds);
		String viewName = "";
		Attachment at = approvalService.selectAppAttachment(appNo);
		appMap.setAttachment(at);
		
		if(appKinds.equals("2")) {
			// 여러개의 증빙내역 배열로 받아서 model 객체에 담아준다.
			ArrayList<ApprovalErs> appErs = approvalService.selectAppErs(appNo);
			model.addAttribute("list", appErs);
			viewName = "/approvalErUpdateForm";
		}else if(appKinds.equals("3")) {
			viewName = "/approvalLvUpdateForm";
		}else if(appKinds.equals("4")) {
			viewName = "/approvalRpUpdateForm";
		}
		model.addAttribute("appMap", appMap); 
		
		return "approval"+viewName;
	}
	
	// report approval 업데이트 메소드
	@RequestMapping("updateApprovalReport.do")
	public ModelAndView updateApprovalRp(Approval approval, ModelAndView mv, HttpServletRequest request,
			@RequestParam(name="reUploadFile", required=false) MultipartFile file) {
		
		approval.getApprovalReport().setAppNo(approval.getAppNo());
		
		Attachment attachment = null;
		// 새로운 첨부파일이 존재할 경우 첨부파일 등록 
		if(!file.getOriginalFilename().equals("")) {
			attachment = saveFile(file, request);
			
			if(attachment != null) {
				attachment.setEmpNo(approval.getAppWriterNo());
				attachment.setRefNo(approval.getAppNo());
			}
		}
		
		String orgChangeName = approval.getAttachment().getChangeName();
		// 기존에 첨부파일이 존재할경우 기존파일 삭제
		if(orgChangeName != null) {
			deleteFile(orgChangeName, request);
		}
		approvalService.updateApprovalRp(approval, attachment);
		
		mv.addObject("appNo", approval.getAppNo()).addObject("appKinds", approval.getAppKinds())
					.setViewName("redirect:detailApproval.do");
		return mv;
	}
	
	@RequestMapping("updateApprovalLeave.do")
	public ModelAndView updateApprovalLv(Approval approval, ModelAndView mv, HttpServletRequest request,
			@RequestParam(name="reUploadFile", required=false) MultipartFile file) {
		
		approval.getApprovalLeave().setAppNo(approval.getAppNo());
		Attachment attachment = null;
		if(!file.getOriginalFilename().equals("")) {
			attachment = saveFile(file, request);
			
			if(attachment != null) {
				attachment.setEmpNo(approval.getAppWriterNo());
				attachment.setRefNo(approval.getAppNo());
			}
		}
		
		String orgChangeName = approval.getAttachment().getChangeName();
		if(orgChangeName != null) {
			deleteFile(orgChangeName, request);
		}
		approvalService.updateApprovalLv(approval, attachment);
		
		mv.addObject("appNo", approval.getAppNo()).addObject("appKinds", approval.getAppKinds())
		.setViewName("redirect:detailApproval.do");
		return mv;
	}
	
	@RequestMapping("updateApprovalEr.do")
	public ModelAndView updateApprovalEr(Approval approval, ApprovalErs approvalErs,
			ModelAndView mv, HttpServletRequest request, @RequestParam(name="reUploadFile", required=false) MultipartFile file) {
		
		ArrayList<ApprovalErs> appers = new ArrayList<>();
		// 증빙 지출 내역 list에 참조 결재 번호 반복문으로 같은 값 담아준다.
		for(int i=0; i<approvalErs.getApprovalErs().size(); i++) {
			appers.add(approvalErs.getApprovalErs().get(i));
			appers.get(i).setErAppNo(approval.getAppNo());
		}
		approval.getApperAccount().setAppNo(approval.getAppNo());
		
		// 지출결의서는 기존에 첨부파일이 무조건 있으므로 새로운 첨부파일이 들어올 경우에만 삭제 진행
		Attachment attachment = null;
		if(!file.getOriginalFilename().equals("")) {
			attachment = saveFile(file, request);
			
			if(attachment != null) {
				attachment.setEmpNo(approval.getAppWriterNo());
				attachment.setRefNo(approval.getAppNo());
			}
			
			deleteFile(approval.getAttachment().getChangeName(), request);
		}
		approvalService.updateApprovalEr(approval, appers, attachment);
		
		mv.addObject("appNo", approval.getAppNo()).addObject("appKinds", approval.getAppKinds())
		.setViewName("redirect:detailApproval.do");
		return mv;
	}
	// 첨부파일 삭제 메소드 공통으로 사용하기위해 메소드로 선언
	private void deleteFile(String orgChangeName, HttpServletRequest request) {
		String resources = request.getSession().getServletContext().getRealPath("resources");
		
		String savePath = resources + "\\appUpload_files\\";
		
		File deleteFile = new File(savePath + orgChangeName);
		
		deleteFile.delete();
	}
	
	@ResponseBody
	@RequestMapping(value="olistApp.do", produces="application/json; charset=utf-8")
	public String selectOpinionList(int refNo) {
		
		ArrayList<Opinion> list = approvalService.selectOpinionList(refNo);
		
		log.info("댓글조회" + list.toString());
		return new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping(value="oinsertApp.do")
	public String insertOpinion(Opinion o) {
		
		int result = approvalService.insertOpinion(o);
		
		return String.valueOf(result);
	}
	
	@ResponseBody
	@RequestMapping(value="deleteOpinion.do")
	public String deleteOpinion(int opinionNo) {
		
		int result = approvalService.deleteOpinion(opinionNo);
		return String.valueOf(result);
	}
	
	// 전자결재 문서 삭제
	@RequestMapping("deleteApproval.do")
	public String deleteApproval(int appNo, int userNo, ModelAndView mv,
			String fileName, HttpServletRequest request) {
		
		approvalService.deleteApproval(appNo);
		// 첨부파일이 있는경우에만 첨부파일 삭제
		if(fileName != null) {
			approvalService.deleteAttachment(appNo);
			deleteFile(fileName, request);
		}
		
		return "redirect:listOutbox.do?userNo="+userNo;
		
	}
}
