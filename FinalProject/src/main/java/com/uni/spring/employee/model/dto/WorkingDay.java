package com.uni.spring.employee.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class WorkingDay {
	private int workNo; //근태번호
	private int empNo; //사원번호	
	private String today; //날짜
	private String startTime; //출근시간
	private String finishTime; //퇴근시간
	private String status; //근태관리 L지각, N결근, Y정상, E조퇴
	private String workHour; //근무시간
}
