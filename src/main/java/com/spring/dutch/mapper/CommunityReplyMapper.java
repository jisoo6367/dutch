package com.spring.dutch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.dutch.dto.CommunityReplyPagingDTO;
import com.spring.dutch.domain.CommunityReplyVO;

public interface CommunityReplyMapper {

	//기본 CRUD 처리 메서드 정의

		//특정 게시물에 대한 댓글 목록 조회: 페이징 고려
		public List<CommunityReplyVO> selectCommunityReplyList(CommunityReplyPagingDTO communityreplyPaging) ;
		
		//특정 게시물에 대한 댓글 총 개수
		public long selectRowTotalCommunityReply(long tno) ;
		
		//특정 게시물에 대한 댓글 등록(prno: null)
		public long insertCommunityReplyForCommunity(CommunityReplyVO myreply) ;

		//댓글에 대한 답글 등록(prno: 부모글의 rno 값)
		public long insertCommunityReplyForCommunityReply(CommunityReplyVO myreply) ;
		
		//특정 게시물에 대한 특정 댓글/답글 조회
		public CommunityReplyVO selectCommunityReply(@Param("tno") long tno, @Param("trno") long rno) ;
		
		//특정 게시물에 대한 특정 댓글/답글 수정
		public int updateCommunityReply(CommunityReplyVO communityreply) ;
		
		//특정 게시물에 대한 특정 댓글/답글 삭제(rdelFlag를 1로 업데이트)
		public int updateTrdelFlag(@Param("tno") long tno, @Param("trno") long trno) ;
		 
		//특정 게시물에 대한 모든 댓글 삭제
		public int deleteAllReply(long tno) ;
	
}
