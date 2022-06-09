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
public class JobPosition {
	private int posNo;
	private String posName;
	private int posGrade;
	private String status; 
}
