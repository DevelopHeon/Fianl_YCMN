package com.uni.spring.common.dto;

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
public class Attachment {
	private int fileNo; // 파일 고유 번호
	private String empNo; // 사원번호
	private int refNo;			// 참조하고 있는 게시글 번호
	private int category;		// 분류번호
	private String originName;	// 파일 원본명
	private String changeName;	// 파일 수정명
	private String filePath;	// 파일이 저장된 폴더 경로
	private Date uploadDate;	// 파일 업로드일
	private String status;		// 파일 상태값
}
