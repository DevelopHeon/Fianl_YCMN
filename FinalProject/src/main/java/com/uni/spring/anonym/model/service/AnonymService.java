package com.uni.spring.anonym.model.service;

import java.util.ArrayList;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.spring.anonym.model.dto.AnonymBoard;
import com.uni.spring.anonym.model.dto.AnonymReply;
import com.uni.spring.common.dto.PageInfo;

public interface AnonymService {

	int selectListCount();

	ArrayList<AnonymBoard> selectList(PageInfo pi);

	void insertAnonymBoard(AnonymBoard anonym);

	AnonymBoard selectAnonymBoard(int anoNo, String confirmUser, BCryptPasswordEncoder bCryptWriterEncoder);

	ArrayList<AnonymReply> selectReplyList(int anoNo, String confirmUser, BCryptPasswordEncoder bCryptWriterEncoder);

	int insertAnoReply(AnonymReply aReply);

	int deleteAnoReply(int replyNo);

}
