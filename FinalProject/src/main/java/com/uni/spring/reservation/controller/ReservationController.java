package com.uni.spring.reservation.controller;

import java.util.ArrayList;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uni.spring.reservation.model.dto.Resources;
import com.uni.spring.reservation.model.service.ReservationService;

import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Controller
public class ReservationController {
	
	private final ReservationService reservationService;
	// 예약 메인 페이지로 이동
	@RequestMapping("reservMain.do")
	public String reservMain() {
		return "reservation/reservationMain";
	}
	
	
	
	// 내 예약 현황 페이지로 이동
	@RequestMapping("myResList.do")
	public String myResList() {
		return "reservation/myReservationList";
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
		
		System.out.println("selectRoom.do > rscNo : "+rscNo);
		
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
		System.out.println("rsc : "+rsc.toString());
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
