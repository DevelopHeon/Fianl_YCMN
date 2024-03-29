package com.uni.spring.employee.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.uni.spring.approval.controller.ApprovalController;
import com.uni.spring.common.CommException;
import com.uni.spring.common.Pagination;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.TimeOff;
import com.uni.spring.employee.model.dto.TimeOffContent;
import com.uni.spring.employee.model.dto.WorkingDay;
import com.uni.spring.employee.model.service.EmployeeService;
import com.uni.spring.hr.model.dto.Hr;
import com.uni.spring.hr.model.service.HrService;
import com.uni.spring.mail.model.service.MailService;

import ch.qos.logback.classic.Logger;
import lombok.RequiredArgsConstructor;

@SessionAttributes("loginUser")
@RequiredArgsConstructor
@Controller
public class EmployeeController {
	
	private final EmployeeService employeeService;
	private final MailService mailService;
	private final HrService hrService;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	private static final Logger log=(Logger) LoggerFactory.getLogger(EmployeeController.class);
	
	@RequestMapping("main.do")
	public String main(HttpSession session, Model model) {
		Employee emp = (Employee)session.getAttribute("loginUser");
		int empNo = emp.getEmpNo();
		//메일함에 새로운 메일이 카운팅(세션)
		//상단메뉴바에서 메일을 확인하면 상단에 여전히 카운팅 감소가 되지 않아 작성
		int unread = mailService.selectUnreadMail(empNo);
		session.setAttribute("unread", unread);
		
		return "main";
	}
	
	@RequestMapping("enrollForm.do")
	public String enrollForm(@ModelAttribute Employee employee) {
		return "employee/enrollForm";
	}
	
	// 회원가입
	@RequestMapping("insertEmployee.do")
	public String insertEmployee(@Valid Employee employee, BindingResult result, HttpServletRequest request) throws Exception {
		
		if(result.hasErrors()) {
			return "employee/enrollForm";
		}
		
		String encPwd = bCryptPasswordEncoder.encode(employee.getEmpPwd());
		System.out.println("비밀번호 : " + employee.getEmpPwd());
		
		employee.setEmpPwd(encPwd);
		employeeService.insertEmployee(employee);
		request.getSession().setAttribute("msg", "가입이 완료되었습니다. 관리자 승인이 필요합니다.");
		
		return "redirect:/";
	}
	
	//로그인
	@RequestMapping("login.do")
	public String loginEmployee(Employee emp, HttpSession session, Model model) {
		Employee loginUser = employeeService.loginEmployee(bCryptPasswordEncoder, emp);
		
		int empNo = loginUser.getEmpNo();
		model.addAttribute("loginUser", loginUser);
		
		//메일함에 새로운 메일이 카운팅(세션)
		int unread = mailService.selectUnreadMail(empNo);
		session.setAttribute("unread", unread);
		
		//프사 변경 
		Employee empInfo = employeeService.selectEmpMypage(empNo);
		session.setAttribute("empInfo", empInfo);
		
		return "main";
	}
	
	// 로그아웃
	@RequestMapping("logout.do")
	public String logoutEmployee(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping("idCheck.do")
	public String idCheck(String empId) {
		
		int result = employeeService.idCheck(empId);
		return String.valueOf(result);
	}
	
	@RequestMapping("myPage.do")
	public String myPage(Model model, HttpSession session, @ModelAttribute("loginUser")Employee emp) {
		int empNo = emp.getEmpNo();
		//프사 변경
		Employee empInfo = employeeService.selectEmpMypage(empNo);
		session.setAttribute("empInfo", empInfo);
		
		//인사정보
		Hr empPersonnel = employeeService.selectEmpPersonnel(empNo);
		model.addAttribute("empPer", empPersonnel);
		return "employee/myPage";
	}
	
	//수정하기(사원정보)
	@RequestMapping("updateEmp.do")
	public String updateEmp(@ModelAttribute Employee emp,
							HttpServletRequest request,
							
							Model model) throws Exception {
		Employee empInfo = employeeService.updateEmp(emp);
		model.addAttribute("loginUser",empInfo);
		
		//프사 변경 
//		Employee empInfo1 = employeeService.selectEmpMypage(emp.getEmpNo());
//		request.getSession().setAttribute("empInfo", empInfo1);
		
		request.getSession().setAttribute("msg", "사원 정보 수정 완료");
		return "employee/myPage";
	}
	
	//근태기록 확인(selectList)
	@RequestMapping("workingInfo.do")
	public String workingInfo(WorkingDay w, HttpSession session, Model model) {
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		
		//전날 미퇴근 출결이 있는지 업데이트(근무상태:조퇴)
		employeeService.updateWorkStatusE(empNo);
		//오늘 정상 출근했는지 업데이트(근무상태:지각)
		employeeService.updateWorkStatusL(empNo);
		
		//근태기록
		ArrayList<WorkingDay> working = employeeService.selectWorkingInfo(empNo);
		model.addAttribute("working", working);
		
		session.setAttribute("workInfo", working);

		//근무시간 합계
		String monthTotal = employeeService.selectWorkingWeekTotal(empNo);
		
		model.addAttribute("monthTotal", monthTotal);
		return "employee/workingInfo";
	}
	
	//근태-출근체크
	@ResponseBody
	@RequestMapping("workingCheck.do")
	public String workingCheck(@ModelAttribute WorkingDay w,
							   @RequestParam("startTime") String startTime,
							   @RequestParam("empNo") int empNo,
							   Model model) {
		w.setStartTime(startTime);
		w.setEmpNo(empNo);
		
		WorkingDay working = employeeService.insertStart(w, empNo);
		
		model.addAttribute("working", working);
		
		return "main";
	}
	
	
	//근태-퇴근체크
	@ResponseBody
	@RequestMapping("leaveCheck.do")
	public String leaveCheck(@ModelAttribute WorkingDay w,
							 @RequestParam("finishTime") String finishTime,
							 @RequestParam("today") String today,
							 @RequestParam("empNo") int empNo,							 
							 Model model) {
		
		w.setFinishTime(finishTime);
		w.setEmpNo(empNo);
		//오늘의 퇴근날짜를 찍기위해 가져감
		w.setToday(today);
		System.out.println(today);

		//퇴근 찍기
		WorkingDay working = employeeService.updateFinish(w);
		
		//오늘 근태시간 구하기
		int workHour = employeeService.updateWorkHour(w);
		
		model.addAttribute("working", working);
		model.addAttribute("workHour", workHour);
		
		return "main";
	}
	
	//출근체킹 여부
	@ResponseBody
	@RequestMapping("startCheck.do")
	public String startCheck(@RequestParam("empNo") int empNo) {
		
		int startCheck = employeeService.selectStartCheck(empNo);

		return String.valueOf(startCheck);
	}

	//퇴근체킹 여부
	@ResponseBody
	@RequestMapping("finishCheck.do")
	public String finishCheck(@RequestParam("empNo") int empNo) {
		
		int finishCheck = employeeService.selectFinishCheck(empNo);

		return String.valueOf(finishCheck);
	}
	
	//주소록
	@RequestMapping("empAddress.do")
	public String empAddress(Model model) {
		
		ArrayList<Employee> list = employeeService.selectEmpAddress();
		
		model.addAttribute("list", list);
		
		return "employee/empAddress";
	}
	
	//주소록_사원상세보기
	@RequestMapping("detailEmp.do")
	public String detailEmp(@RequestParam("eno")String empNo, Model model) {
		int empNo1 = Integer.parseInt(empNo);
		Employee detailEmp = employeeService.detailEmp(empNo1);

		model.addAttribute("detailEmp", detailEmp);
		
		return "employee/empDetail";
	}
	
	//주소록_사원검색
	@RequestMapping("searchEmp.do")
	public String searchEmp(@RequestParam("search")String empName, Model model) {
		
		ArrayList<Employee> searchEmp = employeeService.selectSearchEmp(empName);

		model.addAttribute("searchEmp", searchEmp);
		
		return "employee/empSearch";
	}
	
	//프로필변경
	@ResponseBody
	@RequestMapping("updateImg.do")
	public String updateImg(HttpServletRequest request,
							@RequestParam("empNo")String empNo,
							@RequestParam(name="file", required=false) MultipartFile file) {
		
		System.out.println(empNo);
		System.out.println(file.getOriginalFilename());

		Attachment attachment = null;
		//attachment에 파일을 저장
		attachment = saveFile(file, request);
		attachment.setEmpNo(empNo);
		
		employeeService.updateImg(attachment);

		return attachment.getOriginName();
	}
	
	//프로필삭제(기본이미지user.jpg로 변경)
	@ResponseBody
	@RequestMapping("deleteImg.do")
	public String deleteImg(@ModelAttribute("loginUser")Employee emp,
							Model model,
							HttpServletRequest request,
							@RequestParam("empNo")String empNo,
							@RequestParam(name="file", required=false) MultipartFile file) {

		
		deleteFile(file.getOriginalFilename(), request);
		
		employeeService.deleteImg(empNo);
		
		int empNo1 = emp.getEmpNo();
		//프사 변경 
		Employee empInfo = employeeService.selectEmpMypage(empNo1);
		request.getSession().setAttribute("empInfo", empInfo);
		return  "employee/myPage";
	}
	
	//첨부파일(프로필) 저장
	private Attachment saveFile(MultipartFile file, HttpServletRequest request) {
		
		Attachment attachment = new Attachment();
		
		String resources = request.getSession().getServletContext().getRealPath("resources");
		System.out.println("resources : " + resources);
		
		String savePath = resources + "\\empUpload_files\\";
		
		String originName = file.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String ext = originName.substring(originName.lastIndexOf("."));//ex)meta.jpg -> .jpg
		
		String changeName = currentTime + ext;
		System.out.println("changeName : " + changeName);
		
		attachment.setFilePath(savePath);
		attachment.setOriginName(originName);
		attachment.setChangeName(changeName);
		try {
			
			file.transferTo(new File(savePath + originName));
			
		} catch (IllegalStateException | IOException e) {
			
			e.printStackTrace();
			throw new CommException("파일 업로드 실패");
		}
		return attachment;
	}
	
	//첨부파일 삭제
	private void deleteFile(String originName, HttpServletRequest request) {
		String resources = request.getSession().getServletContext().getRealPath("resources");
		String savePath = resources + "\\empUpload_files\\";
		//경로지정
		File deleteFile = new File(savePath + originName);
		
		deleteFile.delete();
	}
	
	//내 연차조회
	@RequestMapping("timeOff.do")
	public String timeOff(@RequestParam(value="currentPage", defaultValue="1")int currentPage,
						  HttpSession session,
						  Model model) {
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		
		//페이징 처리
		int listCount = employeeService.selectListCount(empNo);
		int listLimit = 10;
		int pageLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, listLimit);
		
		// 연차내역 조회
		//연차내역 조회하면서 승인된 결재가 있으면 쿼리(update)
		ArrayList<TimeOffContent> timeOffList = employeeService.selectTimeOffContent(empNo, pi);
		
		//연차개수 조회
		TimeOff timeOff = employeeService.selectTimeOff(empNo);
		
		model.addAttribute("timeOff", timeOff); //연차개수
		model.addAttribute("timeOffList", timeOffList);//연차내역
		model.addAttribute("pi", pi);//페이징
		

		
		return "employee/empTimeOff";
	}
	
	//사원 상태(온라인,오프라인,자리비움)변경
	@ResponseBody
	@RequestMapping("empOnOff.do")
	public String empOnOff(@RequestParam("empOnOff")String empOnOff, HttpSession session) {
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		loginUser.setEmpOnOff(empOnOff);
		
		employeeService.updateEmpOnOff(loginUser);
		return "redirect:main.do";

	}
	//메인_근무상태
	@ResponseBody
	@RequestMapping(value="mainWorkingInfo.do", produces = "application/text; charset=utf8")
	public String mainWorkingInfo(@ModelAttribute("loginUser")Employee emp, Model model) {
		
		String monthTotal = employeeService.selectWorkingWeekTotal(emp.getEmpNo());

		model.addAttribute("monthTotal", monthTotal);
		return monthTotal;
	}
	
	// 비밀번호 변경 메소드
	@RequestMapping("changePwd.do")
	public String changePwd(Employee employee, Model model, HttpSession session) {
		
		String originPwd = employeeService.selectOriginPwd(employee.getEmpNo());
		log.info("기존 비밀번호 : " + originPwd);
		// 현재 비밀번호가 일치하지 않으면 예외 발생
		if(!bCryptPasswordEncoder.matches(employee.getEmpPwd(), originPwd)) {
			throw new CommException("현재 비밀번호가 일치하지 않습니다.");
		}
		
		// 위 if구문 타지 않으면 비밀번호 update
		String encNewPwd = bCryptPasswordEncoder.encode(employee.getNewPwd());
		employee.setNewPwd(encNewPwd);
		employeeService.updateEmpPwd(employee);
		session.setAttribute("msg", "비밀번호 변경이 완료되었습니다.");
		return "main";
	}
}
