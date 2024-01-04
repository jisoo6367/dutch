package com.spring.dutch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.dutch.domain.QnaReplyVO;
import com.spring.dutch.dto.ReplyPagingDTO;

public interface QnaReplyMapper {

	//특정 게시물에 대한 댓글 목록조회(READ)
	public List<QnaReplyVO> selectQnaReplyList(ReplyPagingDTO replyPaging);

	//특정 게시물에 대한 댓글 총 개수
	public long selectRowTotal(long qno);

	//특정 게시물에 대한 댓글 등록(CREATE)(qrno: null)
	public long insertQnaReplyForBoard(QnaReplyVO reply);

	//댓글에 대한 답글 등록
	public long insertQnaReplyForReply(QnaReplyVO reply);

	//특정 게시물에 대한 특정 댓글/답글 조회(READ)
	public QnaReplyVO selectReply(@Param("qno") long qno, @Param("qrno") long qrno);

	//특정 게시물에 대한 특정 댓글/답글 수정(UPDATE)
	public int updateReply(QnaReplyVO reply);

	//특정 게시물에 대한 특정 댓글/답글 삭제요청(UPDATE)
	public int updateQrdelFlag(@Param("qno") long qno, @Param("qrno") long qrno);

	//특정 게시물에 대한 모든 댓글 삭제(DELETE)
	public int deleteReply(long qno);
}