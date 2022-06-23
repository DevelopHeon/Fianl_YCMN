package com.uni.spring.approval.model.dto;

import java.sql.Date;
import java.sql.Timestamp;

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
public class Opinion {
	
	private int opinionNo;
	private int refNo;
	private String opinionWriter;
	private String opinionContent;
	private Timestamp createDate;
	private String status;
	private String empPfe;
}
