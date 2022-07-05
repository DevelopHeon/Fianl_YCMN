package com.uni.spring.anonym.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.uni.spring.anonym.model.dao.AnonymDao;
import com.uni.spring.anonym.model.dto.AnonymBoard;
import com.uni.spring.anonym.model.dto.AnonymReply;
import com.uni.spring.common.CommException;
import com.uni.spring.common.dto.PageInfo;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service	
public class AnonymServiceImpl implements AnonymService {
	
	private final AnonymDao anonymDao;
	private final SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		return anonymDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<AnonymBoard> selectList(PageInfo pi) {
		return anonymDao.selectListCount(sqlSession, pi);
	}

	@Override
	public void insertAnonymBoard(AnonymBoard anonym) {
		
		int result = anonymDao.insertAnonymBoard(sqlSession, anonym);
		
		if(result < 0) {
			throw new CommException("게시글 등록 실패");
		}
	}

	@Override
	public AnonymBoard selectAnonymBoard(int anoNo, String confirmUser, BCryptPasswordEncoder bCryptWriterEncoder) {
		
		int result = anonymDao.increaseCount(sqlSession, anoNo);
		AnonymBoard anonymBoard = null;
		
		if(result < 0) {
			throw new CommException("익명게시글 조회수 증가 실패");
		}else {
			anonymBoard = anonymDao.selectAnonymBoard(sqlSession, anoNo);
		}
		// 암호화된 작성자와 로그인한 유저의 아이디를 비교 같을경우 Y로 변경
		if(bCryptWriterEncoder.matches(confirmUser, anonymBoard.getAnoWriter())) {
			anonymBoard.setAnoWriter("Y");
		}
		return anonymBoard;
	}

	@Override
	public ArrayList<AnonymReply> selectReplyList(int anoNo, String confirmUser,
			BCryptPasswordEncoder bCryptWriterEncoder) {
		ArrayList<AnonymReply> list = anonymDao.selectReplyList(sqlSession ,anoNo);
		// 익명 게시판 댓글 또한 작성자 암호화 처리 본인 댓글 삭제위해서 복호화 후 같으면 작성자 Y로 변경 
		for(AnonymReply a : list) {
			if(bCryptWriterEncoder.matches(confirmUser, a.getReplyWriter())) {
				a.setReplyWriter("Y");
			}
		}
		
		return list;
	}

	@Override
	public int insertAnoReply(AnonymReply aReply) {
		
		int result = anonymDao.insertAnoReply(sqlSession, aReply);
		
		if(result < 0) {
			throw new CommException("익명게시글 댓글 등록 실패");
		}
		
		return result;
	}

	@Override
	public int deleteAnoReply(int replyNo) {

		int result = anonymDao.deleteAnoReply(sqlSession, replyNo);
		
		if(result < 0) {
			throw new CommException("익명게시글 댓글 삭제 실패");
		}
		
		return result;
	}

	@Override
	public void updateAnoBoard(AnonymBoard anoBoard) {
		
		int result = anonymDao.updateAnoBoard(sqlSession, anoBoard);
		
		if(result < 0) {
			throw new CommException("익명게시글 수정 실패");
		}
	}

	@Override
	public void deleteAnoBoard(int anoNo) {
		
		int result = anonymDao.deleteAnoBoard(sqlSession, anoNo);
		
		if(result < 0) {
			throw new CommException("익명 게시글 삭제 실패");
		}
	}

	@Override
	public int selectSearchListCount(String search) {
		return anonymDao.selectSearchListCount(sqlSession, search);
	}

	@Override
	public ArrayList<AnonymBoard> selectSearchList(String search, PageInfo pi) {
		return anonymDao.selectSearchList(sqlSession, search, pi);
	}

	@Override
	public ArrayList<AnonymBoard> SelectMainAnoList() {
		return anonymDao.selectMainAnoList(sqlSession);
	}


}
