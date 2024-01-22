package com.spring.dutch.service;

import com.spring.dutch.domain.CommunityReplyVO;
import com.spring.dutch.dto.CommunityReplyPagingCreatorDTO;
import com.spring.dutch.dto.CommunityReplyPagingDTO;

public interface CommunityReplyService {

		//특정 게시물에 대한 댓글 목록 조회
		public CommunityReplyPagingCreatorDTO getReplyList(CommunityReplyPagingDTO communityreplyPaging) ;
		
		//특정 게시물에 대한 댓글 등록(trcno: null)
		public Long registerCommunityReplyForCommunity(CommunityReplyVO communityreply) ;
		
		//댓글에 대한 답글 등록(trcno: 부모글의 trno 값)
		public Long registerCommunityReplyForCommunityReply(CommunityReplyVO communityreply);
		
		//특정 게시물에 대한 특정 댓글/답글 조회
		public CommunityReplyVO getCommunityReply(long tno, long trno) ;
		
		//특정 게시물에 대한 특정 댓글/답글 수정
		public boolean modifyCommunityReply(CommunityReplyVO communityreply);
		
		//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
		public boolean modifyTrdelFlag(long tno, long trno) ;
		
		//특정 게시물에 대한 모든 댓글 삭제: 삭제 행수가 반환됨
		public int removeAllCommunityReply(long tno) ;

}
