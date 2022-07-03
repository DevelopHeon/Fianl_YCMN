package com.uni.spring.reservation.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uni.spring.common.Pagination;
import com.uni.spring.common.dto.PageInfo;
import com.uni.spring.employee.model.dto.Employee;
import com.uni.spring.reservation.model.dto.Reservation;
import com.uni.spring.reservation.model.dto.Resources;
import com.uni.spring.reservation.model.service.ReservationService;

import ch.qos.logback.classic.Logger;
import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Controller
public class ReservationController {
	private static final Logger log = (Logger) LoggerFactory.getLogger(ReservationController.class);
	private final ReservationService reservationService;
	// 예약 메인 페이지로 이동
	@RequestMapping("reservMain.do")
	public String reservMain() {
		return "reservation/reservationMain";
	}

	// 예약 메인 페이지
	@ResponseBody
	@GetMapping("reserveList.do")
	public List<Map<String, Object>> reserveList(HttpSession session) {
		// 세션 정보 조회
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		System.out.println("loginUser : "+loginUser);
		
		// 예약할 자원 조회
		ArrayList<Resources> rscList = reservationService.getRscList();
		log.info("rscList :" + rscList);
		
		// 예약된 스케줄 조회
		List<Reservation> listAll = reservationService.getRezList();
		log.info("listAll : "+listAll);
		
		JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();
 
        HashMap<String, Object> hash = new HashMap<>();
        for (int i = 0; i < listAll.size(); i++) {
        	hash.put("rezNo", listAll.get(i).getRezNo());
        	hash.put("rezWriter", listAll.get(i).getRezWriter());
        	hash.put("empName", listAll.get(i).getEmpName());
        	hash.put("title", listAll.get(i).getRezTitle());
        	hash.put("start", listAll.get(i).getStartTime());
        	hash.put("end", listAll.get(i).getEndTime());
        	hash.put("status", listAll.get(i).getStatus());
        	hash.put("rscNo", listAll.get(i).getRscNo());
        	hash.put("rscName", listAll.get(i).getRscName());
        	
            jsonObj = new JSONObject(hash);
            jsonArr.add(jsonObj);
        }
        log.info("jsonObj : "+jsonObj);
        log.info("jsonArr : "+jsonArr);
        return jsonArr;
	}
	
	// 모달에 자원 목록 출력
	@ResponseBody
	@GetMapping("rscList.do")
	public JSONArray getRscList() {
		ArrayList<Resources> rscList = reservationService.getRscList();
		
        JSONArray jsonArr = new JSONArray();
        
        for (Resources rsc : rscList) {
        	JSONObject jsonObj = new JSONObject();
			jsonObj.put("rscNo", rsc.getRscNo());
			jsonObj.put("rscName", rsc.getRscName());
			jsonObj.put("rcNo", rsc.getRcNo());
			jsonObj.put("rcName", rsc.getRcName());
			
			jsonArr.add(jsonObj);
		}
        log.info("jsonArr : "+jsonArr);
		return jsonArr;
	}
	
	// 예약 추가
	@RequestMapping("insertReserve.do")
    public String insertReserve(Reservation rez) {
		log.info("rez : "+rez);
		reservationService.insertReserve(rez);
        return "redirect:/reservMain.do";
    }
	
	// 나의 예약 정보 조회
	@RequestMapping("myRezList.do")
	public String myRezList(Model model
			, @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage
			, HttpSession session) {
		// 세션 정보 조회
		Employee loginUser = (Employee)session.getAttribute("loginUser");
		int empNo = loginUser.getEmpNo();
		log.info("empNo : "+empNo);
		
		// 페이징 용
		int listCount = reservationService.selectListCount(empNo);
		
		int pageLimit = 10; // 하단 최대 페이지 수
		int boardLimit = 15; // 한 페이지에 보여질 예약 수
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		List<Reservation> myRezList = reservationService.myRezList(empNo, pi);
		model.addAttribute("myRezList", myRezList);
		model.addAttribute("pi", pi);
		
		log.info("myRezList : "+myRezList);
		
		return "reservation/myRezManage";
	}
	
	// 예약 취소/반납
	@RequestMapping("myRezManage.do")
	public String myRezManage(String updateRezBtn, int rezNo) {
		
		if(updateRezBtn.equals("N")) {
			reservationService.returnReserve(rezNo);
		}else if(updateRezBtn.equals("C")) {
			reservationService.cancleReserve(rezNo);
		}
		
		return "redirect:/myRezList.do";
	}
	
	
	// 회의실 비품 관리 페이지로 이동
	@RequestMapping("resourceManage.do")
	public String resourceManage(Model model) {
		ArrayList<Resources> roomList = reservationService.getRoomList();
		ArrayList<Resources> supplyList = reservationService.getSupplyList();
		
		model.addAttribute("supplyList", supplyList);
		model.addAttribute("roomList", roomList);
		return "reservation/resourceManage";
	}
	
	// 선택한 자원을 모달에 출력
	@ResponseBody
	@RequestMapping(value="selectRsc.do")
	public JSONObject selectRsc(int rscNo){
		ArrayList<Resources> rscList = reservationService.getRscList();
		
		log.info("selectRoom.do > rscNo : "+rscNo);
		
		Resources selectRsc = null;
		JSONObject jsonObj = null;
		
		for(int i = 0; i < rscList.size(); i++) {
			if (rscList.get(i).getRscNo() == rscNo) {
				selectRsc = rscList.get(i);
				
				jsonObj = new JSONObject();
				
				jsonObj.put("rscNo", selectRsc.getRscNo());
				jsonObj.put("rscName", selectRsc.getRscName());
				jsonObj.put("rscEtc", selectRsc.getRscEtc());
				jsonObj.put("status", selectRsc.getStatus());
			}
		}
		return jsonObj;
	}

	// 자원 추가
	@RequestMapping("insertRsc.do")
	public String insertRsc(Resources rsc, Model model) {
		log.info("rsc : "+rsc.toString());
		reservationService.insertRsc(rsc);
		
		return "redirect:/resourceManage.do";
	}
	
	// 자원 수정/삭제
	@RequestMapping("updateRsc.do")
	public String updateRsc(Resources rsc, Model model, String updateRscBtn) {
		if(updateRscBtn.equals("update")) {
			reservationService.updateRsc(rsc);
		}else if(updateRscBtn.equals("delete")) {
			reservationService.deleteRsc(rsc);
		}
		
		return "redirect:/resourceManage.do";
	}

}
