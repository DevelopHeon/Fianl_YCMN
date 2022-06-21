package com.uni.spring.manager.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;
import com.uni.spring.employee.model.dto.Department;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.employee.model.dto.JobPosition;
import com.uni.spring.hr.model.dto.Hr;
import com.uni.spring.manager.model.service.ManagerService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ManagerController {

	private final ManagerService ManagerService;
	
	// 인사관리 페이지로 이동
	@RequestMapping("managerEmp.do")
	public String managerEmp() {
		return "manager/empListView";
	}
	
	// 사원 전체 정보를 리스트로 조회함. 
	// 페이징 처리 들어가야 함. = 변경하고나서 이 주석 지우기
	@RequestMapping("listEmp.do")
	public String selectList(HttpServletRequest request, Model model
//			, @RequestParam("find") String find
//			, @RequestParam("keyword") String keyword
			) {
		
		ArrayList<Employee> list = ManagerService.selectList();
		model.addAttribute("list", list);
		
//		ArrayList<Employee> list2 = ManagerService.selectList(find, keyword, 1);
		 
		return "manager/empListView";
	}
	
	// UpdateForm으로 이동. 화면에서 eno를 받아서 eno에 해당하는 사원 정보를 불러옴
	// 후에 관리자만 들어올 수 있는 메뉴로 변경 = 변경하고나서 이 주석 지우기
	@RequestMapping("updateFormEmp.do")
	public ModelAndView updateForm(int empNo, ModelAndView mv) {
		
		System.out.println("조회★★★★★★★★★★★★★★★★");
		mv.addObject("getPosList", ManagerService.getPosList()); // 직위 정보
		mv.addObject("getDepList", ManagerService.getDepList()); // 부서 정보
		mv.addObject("e", ManagerService.selectEmp(empNo));
		
		mv.setViewName("manager/empUpdateForm");
		
		return mv;
	}
	
	// 사원 정보와 인사 기록 수정
	@RequestMapping("updateEmpDetail.do")
	public String updateEmpDetail(int empNo, Employee e, Model model){
		System.out.println("업데이트★★★★★★★★★★★★★★★★");
		
		Hr hr = e.getHr();
		hr.setEmpNo(e.getEmpNo());
		System.out.println("hr.toString() : "+hr.toString());
		System.out.println("e.toString() : "+e.toString());

		ManagerService.updateEmpDetail(e, hr);
		// 수정한 정보를 Form에 띄워주기 위함
		model.addAttribute("e", ManagerService.selectEmp(e.getEmpNo()));
		model.addAttribute("getPosList", ManagerService.getPosList());
		model.addAttribute("getDepList", ManagerService.getDepList());
		
		return "manager/empUpdateForm";
	}
	
	// 엑셀 다운로드
	@RequestMapping(value = "/empExcelDown.do")
	public void excelDown(HttpServletResponse response) throws Exception {
	    // 게시판 목록조회
	    List<Employee> list = ManagerService.selectExcelList();

	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("개발웍스 임직원 목록");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;
	    
	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();
	    
	    // 헤더 폰트
	    Font headerFont = wb.createFont();
	    headerFont.setFontName("나눔고딕");
	    headerFont.setFontHeight((short)240); // 지정할 폰트*20
	    headerFont.setColor(IndexedColors.WHITE.getIndex());
	    headerFont.setBold(true);
	    headStyle.setFont(headerFont); // 폰트 적용
	    
	    // 배경색 지정
	    headStyle.setFillForegroundColor(HSSFColorPredefined.GREY_25_PERCENT.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

	    // 가운데 정렬
	    headStyle.setAlignment(HorizontalAlignment.CENTER);
	    
	    // 데이터용
	    CellStyle bodyStyle = wb.createCellStyle();
	    // 데이터 폰트
	    Font bodyFont = wb.createFont();
	    bodyFont.setFontName("나눔고딕");
	    bodyFont.setFontHeight((short)240);
	    bodyStyle.setFont(bodyFont);
	    
	    // 경계 테두리
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);
		
	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("사번");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("아이디");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("이름");
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("이메일");
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("직통 번호");
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("휴대폰 번호");
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("부서 명");
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("직위 명");
	    
	    
	    // 데이터 부분 생성
	    for(Employee vo : list) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getEmpNo());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getEmpId());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getEmpName());
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getEmpEmail());
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getOfficeTel());
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getEmpPhone());
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getDepName());
	        cell = row.createCell(7);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getPosName());
	    }
	    
	    // 컬럼 너비 자동 조절
		for (int i = 0; i < row.getLastCellNum(); i++){
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 512);
		}

		// 현재 날짜 구하기        
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formatedNow = now.format(formatter);
	
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode("개발웍스 임직원 목록 (","UTF-8")+formatedNow+").xls");
	    
	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
	// 조직도 페이지로 이동
    @RequestMapping("organizationChart.do")
    public String organizationChart() {
        return "manager/organizationChart";
    }
    
	// 직위/부서 페이지로 이동
	@RequestMapping("jobManage.do")
	public String JobManage(Model model) {
		ArrayList<JobPosition> posList = ManagerService.getPosList();
		ArrayList<Department> depList = ManagerService.getDepList();
		
		System.out.println("직위 조회 :" + posList);
		System.out.println("부서 조회 :" + depList);
		
		model.addAttribute("posList", posList);
		model.addAttribute("depList", depList);
		
		return "manager/JobManagement";
	}
	
	// 모달창에 선택한 직위 띄워주는 용도
	@ResponseBody
	@RequestMapping(value="selectPos.do")
	public JSONObject selectPos1(int posNo){
		ArrayList<JobPosition> posList = ManagerService.getPosList();
		
		System.out.println("selectPos.do > posNo : "+posNo);
		
		JobPosition selectPos = null;
		JSONObject jsonObj = null;
		
		for(int i = 0; i < posList.size(); i++) {
			if (posList.get(i).getPosNo() == posNo) {
				selectPos = posList.get(i);
				
				jsonObj = new JSONObject();
				
				jsonObj.put("posNo", selectPos.getPosNo());
				jsonObj.put("posGrade", selectPos.getPosGrade());
				jsonObj.put("posName", selectPos.getPosName());
				jsonObj.put("status", selectPos.getStatus());
			}
		}
		return jsonObj;
	}
	
	// 직위 추가
	@RequestMapping("insertPos.do")
	public String insertJobPosition(JobPosition job, Model model) {
		ManagerService.insertJobPosition(job);
		
		ArrayList<JobPosition> posList = ManagerService.getPosList();
		ArrayList<Department> depList = ManagerService.getDepList();

		model.addAttribute("posList", posList);
		model.addAttribute("depList", depList);
		
		return "manager/JobManagement";
	}
	
	// 직위 수정/삭제
	@RequestMapping("updatePos.do")
	public String updateJobPosition(JobPosition job, Model model, String updatePosBtn) {
		System.out.println("직위 수정");
		System.out.println("jp : "+job);
		
		if(updatePosBtn.equals("update")) {
			ManagerService.updateJobPosition(job);
		}else if(updatePosBtn.equals("delete")) {
			ManagerService.deleteJobPosition(job);
		}
		
		ArrayList<JobPosition> posList = ManagerService.getPosList();
		ArrayList<Department> depList = ManagerService.getDepList();
		
		model.addAttribute("posList", posList);
		model.addAttribute("depList", depList);
		
		return "manager/JobManagement";
	}
	
	// 모달창에 선택한 직위 띄워주는 용도
	@ResponseBody
	@RequestMapping(value="selectDep.do")
	public JSONObject selectDep(int depNo){
		ArrayList<Department> depList = ManagerService.getDepList();
		
		System.out.println("selectDep.do > depNo : "+depNo);
		
		Department selectDep = null;
		JSONObject jsonObj = null;
		
		for(int i = 0; i < depList.size(); i++) {
			if (depList.get(i).getDepNo() == depNo) {
				selectDep = depList.get(i);
				
				jsonObj = new JSONObject();
				
				jsonObj.put("depNo", selectDep.getDepNo());
				jsonObj.put("depName", selectDep.getDepName());
				jsonObj.put("status", selectDep.getStatus());
			}
		}
		return jsonObj;
	}
	
	// 부서 추가
	@RequestMapping("insertDept.do")
	public String insertDepartment(Department dep, Model model) {

		ManagerService.insertDepartment(dep);
		
		ArrayList<JobPosition> posList = ManagerService.getPosList();
		ArrayList<Department> depList = ManagerService.getDepList();

		model.addAttribute("posList", posList);
		model.addAttribute("depList", depList);
		
		return "manager/JobManagement";
	}
	
	// 부서 수정
	@RequestMapping("updateDept.do")
	public String updateDepartment(Department dep, Model model, String updateDepBtn) {
		if(updateDepBtn.equals("update")) {
			ManagerService.updateDepartment(dep);
		}else if(updateDepBtn.equals("delete")) {
			ManagerService.deleteDepartment(dep);
		}
		
		ArrayList<JobPosition> posList = ManagerService.getPosList();
		ArrayList<Department> depList = ManagerService.getDepList();
		
		model.addAttribute("posList", posList);
		model.addAttribute("depList", depList);
		
		return "manager/JobManagement";
	}
}