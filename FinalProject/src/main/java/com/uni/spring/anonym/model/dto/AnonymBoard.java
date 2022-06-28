package com.uni.spring.anonym.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class AnonymBoard {
	
	private int rowNum;
	private int anoNo;
	private String anoWriter;
	private String anoTitle;
	private String anoContent;
	private Date createDate;
	private int count;
	private String status;
	private int category;
	private int replyCnt;
}
