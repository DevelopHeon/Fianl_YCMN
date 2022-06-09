package com.uni.spring.employee.controller;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.uni.spring.employee.model.dto.Employee;
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
	
	@RequestMapping("workingInfo.do")
	public String workingInfo() {
		return "employee/workingInfo";
	}
	
	@RequestMapping("workingCheck.do")
	public String workingCheck(@ModelAttribute WorkingDay w,
							   HttpSession session, 
							   HttpServletRequest request) {
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		w.setEmpNo(empNo);
		System.out.println("controller 들어옴?~??????????????");
		System.out.println(empNo);
		//name이 status인 파라미터를 가져옴
		String status = (String)request.getParameter("status");
		String clock = (String)request.getParameter("clock");
		String today = (String)request.getParameter("today");

		
		if(status == "s") {
			w.setStart(clock);
			employeeService.insertStart(w);
			System.out.println(w.getStart());
		}
		return "main";
	}
}
