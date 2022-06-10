package com.uni.spring.schedule.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.uni.spring.schedule.model.dto.Schedule;
import com.uni.spring.schedule.model.service.ScheduleService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ScheduleController {
	
	@Autowired
	private ScheduleService service;
	
	
	
	@RequestMapping("schedule.do")
	public String schedule() {
		return "schedule/calendar";
	}
	
	@RequestMapping(value= "/calendar", method = RequestMethod.GET)
	public ModelAndView getscheduleList(ModelAndView mv, HttpServletRequest request) {
		String viewpage = "calendar";
		List<Schedule> schedule = null;
		try {
			schedule = service.getschedule();
			request.setAttribute("scheduleList", schedule);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		mv.setViewName(viewpage);
		return mv;
	}
	
}
