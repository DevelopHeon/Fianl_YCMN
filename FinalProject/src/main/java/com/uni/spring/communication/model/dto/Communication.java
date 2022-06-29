package com.uni.spring.communication.model.dto;

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
public class Communication {

	private int commNo;
	private int depNo;
	private int grp;
	private int grpi;
	private String commWriter;
	private String commContent;
	private Date createDate;
	private String empPfe;
}
