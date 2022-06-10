package com.uni.spring.schedule.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Schedule {
	private int scheduleNo;
	private int empNo;
	private int calNo;
	private int groupNo;
	private String scheduleTitle;
	private String scheduleContent;
	private Date scheduleStart;
	private Date scheduleEnd;
	private String scheduleAllday;
	private String scheduleShare;
	private String companySd;
	private Date createDate;
	private String scheduleStatus;

}
