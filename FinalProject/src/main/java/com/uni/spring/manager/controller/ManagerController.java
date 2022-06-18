package com.uni.spring.manager.controller;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.uni.spring.employee.model.dto.Employee;
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
	public String selectList(Model model) {

		ArrayList<Employee> list = ManagerService.selectList();
		model.addAttribute("list", list);

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
	
}