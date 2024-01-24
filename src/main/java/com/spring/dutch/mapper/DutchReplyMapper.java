package com.spring.dutch.mapper;



import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.dutch.domain.DutchReplyVO;
import com.spring.dutch.dto.DutchReplyPagingDTO;

public interface DutchReplyMapper {
	//기본 CRUD 처리 메서드 정의

	//특정 게시물에 대한 댓글 목록 조회: 페이징 고려
	public List<DutchReplyVO> selectDutchReplyList(DutchReplyPagingDTO myreplyPaging) ;
	
	//특정 게시물에 대한 댓글 총 개수
	public long selectRowTotal(long pno) ;
	
	//특정 게시물에 대한 댓글 등록(prno: null)
	public long insertDutchReplyForBoard(DutchReplyVO dutchReply) ;

	//댓글에 대한 답글 등록(prno: 부모글의 rno 값)
	public long insertDutchReplyForReply(DutchReplyVO dutchReply) ;
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	public DutchReplyVO selectDutchReply(@Param("pno") long pno, @Param("rno") long rno) ;
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	public int updateDutchReply(DutchReplyVO myreply) ;
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
	public int updateRdelFlag(@Param("pno") long pno, @Param("rno") long rno) ;
	
	//특정 게시물에 대한 모든 댓글 삭제
	public int deleteAllReply(long pno) ;
	
}
