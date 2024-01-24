package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.DutchReplyVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class DutchReplyPagingCreatorDTO {
	
	private List<DutchReplyVO> myreplyList ;
	private long replyTotCnt ;
	private DutchReplyPagingDTO myreplyPaging ;
	
	public DutchReplyPagingCreatorDTO(List<DutchReplyVO> myreplyList, 
								   long replyTotCnt,
								   DutchReplyPagingDTO myreplyPaging) {
		this.myreplyList = myreplyList ;
		this.replyTotCnt = replyTotCnt ;
		this.myreplyPaging = myreplyPaging ;
	}

}
