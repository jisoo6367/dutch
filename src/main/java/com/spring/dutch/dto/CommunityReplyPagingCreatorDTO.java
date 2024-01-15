package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.CommunityReplyVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class CommunityReplyPagingCreatorDTO {

	private List<CommunityReplyVO> communityreplyList ;
	private long replyTotCnt ;
	private CommunityReplyPagingDTO communityreplyPaging ;
	
	public CommunityReplyPagingCreatorDTO(List<CommunityReplyVO> communityreplyList, 
										  long replyTotCnt,
										  CommunityReplyPagingDTO communityreplyPaging) {
		
		this.communityreplyList = communityreplyList ;
		this.replyTotCnt = replyTotCnt ;
		this.communityreplyPaging = communityreplyPaging ;
	}
	
}
