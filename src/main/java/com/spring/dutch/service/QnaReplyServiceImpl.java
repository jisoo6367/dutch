package com.spring.dutch.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dutch.domain.QnaReplyVO;
import com.spring.dutch.dto.QnaReplyPagingCreatorDTO;
import com.spring.dutch.dto.QnaReplyPagingDTO;
import com.spring.dutch.mapper.QnaMapper;
import com.spring.dutch.mapper.QnaReplyMapper;

@Service
public class QnaReplyServiceImpl implements QnaReplyService{

	//
	private QnaReplyMapper qnaReplyMapper;
	private QnaMapper qnaMapper;
	
	public QnaReplyServiceImpl(QnaReplyMapper qnaReplyMapper,
							   QnaMapper qnaMapper) {
		this.qnaReplyMapper = qnaReplyMapper;
		this.qnaMapper = qnaMapper;
	}
	
	//특정 게시물에 대한 댓글 목록 조회
	@Override
	public QnaReplyPagingCreatorDTO getReplyList(QnaReplyPagingDTO qnareplyPaging) {

		long replyTotCnt = qnaReplyMapper.selectRowTotal(qnareplyPaging.getQno());
		System.out.println("replyTotCnt: " + replyTotCnt);
		
		int pageNum = qnareplyPaging.getPageNum();
		
		if(pageNum == -10) {
			
		   pageNum = (int) Math.ceil((double)replyTotCnt/qnareplyPaging.getRowAmountPerPage()) ;
		   qnareplyPaging.setPageNum(pageNum) ;
		}
		
		List<QnaReplyVO> qnareplyList = qnaReplyMapper.selectQnaReplyList(qnareplyPaging);
		
		QnaReplyPagingCreatorDTO qnareplyPagingCreator
			= new QnaReplyPagingCreatorDTO(qnareplyList, replyTotCnt, qnareplyPaging);
		
		return qnareplyPagingCreator;
	}

	//특정 게시물에 대한 댓글 등록(qrcno: null)
	@Transactional
	@Override
	public Long registerReplyForQna(QnaReplyVO qnareply) {

		qnaReplyMapper.insertQnaReplyForQna(qnareply);
		
		qnaMapper.updateQreplyCnt(qnareply.getQno(), 1);
		
		return qnareply.getQrno();
	}

	//댓글에 대한 답글 등록(prcno: 부모글의 qrno값)
	@Override
	@Transactional
	public Long registerReplyForReply(QnaReplyVO qnareply) {
		qnaReplyMapper.insertQnaReplyForReply(qnareply);
		
		qnaMapper.updateQreplyCnt(qnareply.getQno(), 1);
		
		return qnareply.getQrno();
	}

	//특정 게시물에 대한 특정 댓글/답글 조회
	@Override
	public QnaReplyVO getQnaReply(long qno, long qrno) {
		
		return qnaReplyMapper.selectReply(qno, qrno);
	}

	//특정 게시물에 대한 특정 댓글/답글 수정
	@Override
	public boolean modifyQnaReply(QnaReplyVO qnareply) {
		
		return qnaReplyMapper.updateReply(qnareply) == 1;
	}

	//특정 게시물에 대한 특정 댓글/답글 삭제(qrdelFlag를 1로 업데이트)
	@Override
	@Transactional
	public boolean modifyQrdelFlag(long qno, long qrno) {

		int deleteRowCnt = qnaReplyMapper.updateQrdelFlag(qno, qrno);
		
		qnaMapper.updateQreplyCnt(qno, -1);
		
		return deleteRowCnt == 1;
	}

	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@Override
	public int removeAllReply(long qno) {
		
		return qnaReplyMapper.deleteReply(qno);
	}


}
