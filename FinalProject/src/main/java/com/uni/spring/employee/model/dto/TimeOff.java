package com.uni.spring.employee.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class TimeOff {
	private int empNo; //사원번호
	private int totalNum; //총 연차개수
	private int useNum; //사용개수
	private int remainNum; //남은개수
}
