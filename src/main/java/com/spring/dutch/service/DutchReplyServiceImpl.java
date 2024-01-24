package com.spring.dutch.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dutch.domain.DutchReplyVO;
import com.spring.dutch.dto.DutchReplyPagingCreatorDTO;
import com.spring.dutch.dto.DutchReplyPagingDTO;
import com.spring.dutch.mapper.DutchBoardMapper;
import com.spring.dutch.mapper.DutchReplyMapper;

@Service
public class DutchReplyServiceImpl implements DutchReplyService{

	private DutchReplyMapper dutchReplyMapper;
	private DutchBoardMapper dutchBoardMapper;
	
	public DutchReplyServiceImpl(DutchReplyMapper dutchReplyMapper,
								DutchBoardMapper dutchBoardMapper) {
			this.dutchReplyMapper = dutchReplyMapper ;
			this.dutchBoardMapper = dutchBoardMapper ;
}
	//특정 게시물에 대한 댓글 목록 조회
	@Override
	public DutchReplyPagingCreatorDTO getReplyList(DutchReplyPagingDTO dutchReplyPaging) {
		long replyTotCnt = dutchReplyMapper.selectRowTotal(dutchReplyPaging.getPno()) ;
		
		int pageNum = dutchReplyPaging.getPageNum() ;
		
		if (pageNum == -10) {
			
			pageNum = (int) Math.ceil((double)replyTotCnt/dutchReplyPaging.getRowAmountPerPage()) ;
			dutchReplyPaging.setPageNum(pageNum) ;
		}
		
		List<DutchReplyVO> dutchReplyList = dutchReplyMapper.selectDutchReplyList(dutchReplyPaging) ;
		
		
		DutchReplyPagingCreatorDTO dutchReplyPagingCreator
			= new DutchReplyPagingCreatorDTO(dutchReplyList, replyTotCnt, dutchReplyPaging);
				
		return dutchReplyPagingCreator ;
	}	
	
	//특정 게시물에 대한 댓글 등록(prno: null)
	@Transactional
	@Override
	public Long registerReplyForBoard(DutchReplyVO dutchReply) {
		
		dutchReplyMapper.insertDutchReplyForBoard(dutchReply) ;
		return dutchReply.getRno() ; 
	}
	
	//댓글에 대한 답글 등록(prno: 부모글의 rno 값)
	@Transactional
	@Override
	public Long registerReplyForReply(DutchReplyVO dutchReply) {
		dutchReplyMapper.insertDutchReplyForReply(dutchReply) ;
		
		return dutchReply.getRno() ; 
	}
	
	//특정 게시물에 대한 특정 댓글/답글 조회
	@Override
	public DutchReplyVO getDutchReply(long pno, long rno) {
		return dutchReplyMapper.selectDutchReply(pno, rno) ;
	}	
	
	//특정 게시물에 대한 특정 댓글/답글 수정
	@Override
	public boolean modifyDutchReply(DutchReplyVO dutchReply) {
		return dutchReplyMapper.updateDutchReply(dutchReply) == 1 ;
	}
	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
	@Transactional
	@Override
	public boolean modifyRdelFlag(long pno, long rno) {
		int deleteRowCnt = dutchReplyMapper.updateRdelFlag(pno, rno) ;
		
		return deleteRowCnt == 1 ;
	}
	
	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@Override
	public int removeAllReply(long pno) {
		return dutchReplyMapper.deleteAllReply(pno) ;

	}
	
	

}
