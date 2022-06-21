package com.uni.spring.employee.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.uni.spring.common.CommException;
import com.uni.spring.common.Pagination;
import com.uni.spring.common.dto.Attachment;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.TimeOff;
import com.uni.spring.employee.model.dto.TimeOffContent;
import com.uni.spring.employee.model.dto.WorkingDay;
import com.uni.spring.employee.model.service.EmployeeService;

import lombok.RequiredArgsConstructor;

@SessionAttributes("loginUser")
@RequiredArgsConstructor
@Controller
public class EmployeeController {
	
	private final EmployeeService employeeService;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping("main.do")
	public String main() {
		return "main";
	}
	
	@RequestMapping("enrollForm.do")
	public String enrollForm() {
		return "employee/enrollForm";
	}
	
	// 회원가입
	@RequestMapping("insertEmployee.do")
	public String insertEmployee(@ModelAttribute Employee emp) throws Exception {
		
		String encPwd = bCryptPasswordEncoder.encode(emp.getEmpPwd());
		System.out.println("비밀번호 : " + emp.getEmpPwd());
		emp.setEmpPwd(encPwd);
		employeeService.insertEmployee(emp);
		return "redirect:/";
	}
	
	//로그인
	@RequestMapping("login.do")
	public String loginEmployee(Employee emp, Model model) {
		Employee loginUser = employeeService.loginEmployee(bCryptPasswordEncoder, emp);
		
		model.addAttribute("loginUser", loginUser);
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
	public String myPage() {
		return "employee/myPage";
	}
	
	//수정하기(사원정보)
	@RequestMapping("updateEmp.do")
	public String updateEmp(@ModelAttribute Employee emp, Model model) throws Exception {
		Employee empInfo = employeeService.updateEmp(emp);
		model.addAttribute("loginUser",empInfo);
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
		
		ArrayList<WorkingDay> working = employeeService.selectWorkingInfo(empNo);
		
		model.addAttribute("working", working);

		return "employee/workingInfo";
	}
	
	//근태-출근체크
	@ResponseBody
	@RequestMapping("workingCheck.do")
	public String workingCheck(@ModelAttribute WorkingDay w,
							   @RequestParam("startTime") String startTime,
							   @RequestParam("empNo") int empNo,
							   Model model) {
//		Employee loginUser = (Employee)session.getAttribute("loginUser");
//		int empNo = loginUser.getEmpNo();
//		w.setEmpNo(empNo);
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
		System.out.println(attachment.getOriginName());
		request.getSession().setAttribute("msg", "변경 완. 재로그인 바람");
		return attachment.getOriginName();
	}
	
	//프로필삭제(기본이미지user.jpg로 변경)
	@ResponseBody
	@RequestMapping("deleteImg.do")
	public String deleteImg(HttpServletRequest request,
							@RequestParam("empNo")String empNo,
							@RequestParam(name="file", required=false) MultipartFile file) {

		
		deleteFile(file.getOriginalFilename(), request);
		
		employeeService.deleteImg(empNo);

		request.getSession().setAttribute("msg", "변경 완. 재로그인 바람");
		return "employee/myPage";
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
						  HttpSession session, Model model) {
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		
		//페이징 처리
		int listCount = employeeService.selectListCount(empNo);
		int listLimit = 5;
		int pageLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, listLimit);
		
		//연차개수 조회
		TimeOff timeOff = employeeService.selectTimeOff(empNo);
		
		// 연차내역 조회
		//연차내역 조회하면서 승인된 결재가 있으면 쿼리(update)
		ArrayList<TimeOffContent> timeOffList = employeeService.selectTimeOffContent(empNo, pi);
		
		model.addAttribute("timeOff", timeOff); //연차개수
		model.addAttribute("timeOffList", timeOffList);//연차내역
		model.addAttribute("pi", pi);//페이징
		
		return "employee/empTimeOff";
	}
	

	
}
