package com.spring.dutch.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dutch.domain.CommunityReplyVO;
import com.spring.dutch.dto.CommunityReplyPagingCreatorDTO;
import com.spring.dutch.dto.CommunityReplyPagingDTO;
import com.spring.dutch.mapper.CommunityMapper;
import com.spring.dutch.mapper.CommunityReplyMapper;

@Service
public class CommunityReplyServiceImpl implements CommunityReplyService{

	private CommunityReplyMapper communityReplyMapper ;
	private CommunityMapper communityMapper ;
	
	public CommunityReplyServiceImpl(CommunityReplyMapper communityReplyMapper,
									 CommunityMapper communityMapper) {
		this.communityReplyMapper = communityReplyMapper ;
		this.communityMapper = communityMapper ;
		} 

	//특정 게시물에 대한 댓글 목록 조회
	@Override
	public CommunityReplyPagingCreatorDTO getReplyList(CommunityReplyPagingDTO communityreplyPaging) {
		
		long replyTotCnt = communityReplyMapper.selectRowTotalCommunityReply(communityreplyPaging.getTno());
		
		int pageNum = communityreplyPaging.getPageNum() ;
		
		if (pageNum == -10) {
			
			pageNum = (int) Math.ceil((double)replyTotCnt/communityreplyPaging.getRowAmountPerPage()) ;
			communityreplyPaging.setPageNum(pageNum) ;
		}
		
		List<CommunityReplyVO> communityreplyList = communityReplyMapper.selectCommunityReplyList(communityreplyPaging) ;
		
		
		CommunityReplyPagingCreatorDTO communityreplyPagingCreator
			= new CommunityReplyPagingCreatorDTO(communityreplyList, replyTotCnt, communityreplyPaging);
				
		return communityreplyPagingCreator ;
	}

	
	//특정 게시물에 대한 댓글 등록(trno: null)
	@Transactional
	@Override
	public Long registerCommunityReplyForCommunity(CommunityReplyVO communityreply) {
		communityReplyMapper.insertCommunityReplyForCommunity(communityreply) ;
		communityMapper.updateTreplyCntCommunity(communityreply.getTno(), 1);
		return communityreply.getTrno(); 
	}

	
	//댓글에 대한 답글 등록(prno: 부모글의 rno 값)
	@Override
	public Long registerCommunityReplyForCommunityReply(CommunityReplyVO communityreply) {
		communityReplyMapper.insertCommunityReplyForCommunityReply(communityreply) ;
		communityMapper.updateTreplyCntCommunity(communityreply.getTno(), 1);
		
		return communityreply.getTrno();
	}

	
	//특정 게시물에 대한 특정 댓글/답글 조회
	@Override
	public CommunityReplyVO getCommunityReply(long tno, long trno) {
	
		return communityReplyMapper.selectCommunityReply(tno, trno) ;
	}

	//특정 게시물에 대한 특정 댓글/답글 수정
	@Override
	public boolean modifyCommunityReply(CommunityReplyVO communityreply) {
		
		return communityReplyMapper.updateCommunityReply(communityreply) == 1;
	}

	
	//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
	@Override
	@Transactional
	public boolean modifyTrdelFlag(long tno, long trno) {
		int deleteRowCnt = communityReplyMapper.updateTrdelFlag(tno, trno) ;
		
		communityMapper.updateTreplyCntCommunity(tno, -1);
		
		return deleteRowCnt == 1 ;
	}

	//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
	@Override
	public int removeAllCommunityReply(long tno) {
	
		return communityReplyMapper.deleteAllReply(tno);
	}




}
