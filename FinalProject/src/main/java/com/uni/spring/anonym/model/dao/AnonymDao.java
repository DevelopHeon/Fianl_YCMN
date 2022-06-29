package com.uni.spring.anonym.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.anonym.model.dto.AnonymBoard;
import com.uni.spring.anonym.model.dto.AnonymReply;
import com.uni.spring.common.dto.PageInfo;

@Repository
public class AnonymDao {

	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("anonymBoardMapper.selectListCount");
	}

	public ArrayList<AnonymBoard> selectListCount(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("anonymBoardMapper.selectList", null, rowBounds);
	}

	public int insertAnonymBoard(SqlSessionTemplate sqlSession, AnonymBoard anonym) {
		return sqlSession.insert("anonymBoardMapper.insertAnonymBoard", anonym);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int anoNo) {
		return sqlSession.update("anonymBoardMapper.increaseCount", anoNo);
	}

	public AnonymBoard selectAnonymBoard(SqlSessionTemplate sqlSession, int anoNo) {
		return sqlSession.selectOne("anonymBoardMapper.selectAnonymBoard", anoNo);
	}

	public ArrayList<AnonymReply> selectReplyList(SqlSessionTemplate sqlSession, int anoNo) {
		return(ArrayList)sqlSession.selectList("anonymBoardMapper.selectReplyList", anoNo);
	}

	public int insertAnoReply(SqlSessionTemplate sqlSession, AnonymReply aReply) {
		return sqlSession.insert("anonymBoardMapper.insertAnoReply", aReply);
	}

	public int deleteAnoReply(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.delete("anonymBoardMapper.deleteAnoReply", replyNo);
	}

	public int updateAnoBoard(SqlSessionTemplate sqlSession, AnonymBoard anoBoard) {
		return sqlSession.update("anonymBoardMapper.updateAnoBoard", anoBoard);
	}

	public int deleteAnoBoard(SqlSessionTemplate sqlSession, int anoNo) {
		return sqlSession.update("anonymBoardMapper.deleteAnoBoard", anoNo);
	}

	public int selectSearchListCount(SqlSessionTemplate sqlSession, String search) {
		return sqlSession.selectOne("anonymBoardMapper.selectSearchListCount", search);
	}

	public ArrayList<AnonymBoard> selectSearchList(SqlSessionTemplate sqlSession, String search, PageInfo pi) {
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("anonymBoardMapper.selectSearchList", search);
	}

	public ArrayList<AnonymBoard> selectMainAnoList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("anonymBoardMapper.selectMainAnoList");
	}

}
