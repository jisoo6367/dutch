package com.spring.dutch.dto;

import java.util.List;

import org.apache.ibatis.reflection.SystemMetaObject;

import com.spring.dutch.domain.QnaReplyVO;
import com.spring.dutch.domain.QnaVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class QnaReplyPagingCreatorDTO {
	
	private QnaReplyPagingDTO qnareplyPaging;
	private List<QnaReplyVO> qnareplyList;
	private long replyTotCnt;
	
	public QnaReplyPagingCreatorDTO(List<QnaReplyVO> qnareplyList,
								 long replyTotCnt,
							 	 QnaReplyPagingDTO qnareplyPaging) {
		
		this.qnareplyList = qnareplyList;
		this.replyTotCnt = replyTotCnt;
		this.qnareplyPaging = qnareplyPaging;
		
	}
	
	
}
