package com.uni.spring.anonym.model.dto;

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
public class AnonymReply {

	private int replyNo;
	private int refNo;
	private String replyWriter;
	private String replyContent;
	private Timestamp createDate;
	private String status;
}
