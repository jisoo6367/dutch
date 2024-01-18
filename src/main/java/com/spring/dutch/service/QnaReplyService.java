package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.domain.QnaReplyVO;
import com.spring.dutch.dto.QnaReplyPagingCreatorDTO;
import com.spring.dutch.dto.QnaReplyPagingDTO;

public interface QnaReplyService {

	//특정 게시물에 대한 댓글 목록 조회
	public QnaReplyPagingCreatorDTO getReplyList(QnaReplyPagingDTO qnareplyPaging);
	
	//특정 게시물에 대한 댓글 등록(prcno: null)
	public Long registerReplyForQna(QnaReplyVO qnareply);
	
	//댓글에 대한 답글 등록(prcno: 부모글의 qrno값)
	public Long registerReplyForReply(QnaReplyVO qnareply);
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	public QnaReplyVO getQnaReply(long qno, long qrno);
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	public boolean modifyQnaReply(QnaReplyVO qnareply);
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(qrdelFlag를 1로 업데이트)
	public boolean modifyQrdelFlag(long qno, long qrno);
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	public int removeAllReply(long qno);

	
}
