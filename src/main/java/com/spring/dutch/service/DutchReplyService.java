package com.spring.dutch.service;

import com.spring.dutch.domain.DutchReplyVO;
import com.spring.dutch.dto.DutchReplyPagingCreatorDTO;
import com.spring.dutch.dto.DutchReplyPagingDTO;

public interface DutchReplyService {

	//특정 게시물에 대한 댓글 목록 조회
	public DutchReplyPagingCreatorDTO getReplyList(DutchReplyPagingDTO dutchReplyPaging);
	
	//특정 게시물에 대한 댓글 등록(prcno: null)
	public Long registerReplyForBoard(DutchReplyVO dutchReply);
	
	//댓글에 대한 답글 등록(prcno: 부모글의 qrno값)
	public Long registerReplyForReply(DutchReplyVO dutchReply);
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	public DutchReplyVO getDutchReply(long pno, long rno);
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	public boolean modifyDutchReply(DutchReplyVO dutchReply);
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(qrdelFlag를 1로 업데이트)
	public boolean modifyRdelFlag(long pno, long rno);
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	public int removeAllReply(long pno);

	
}
