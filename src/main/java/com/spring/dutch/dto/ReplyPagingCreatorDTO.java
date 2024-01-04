package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.NoticeVO;
import com.spring.dutch.domain.QnaVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReplyPagingCreatorDTO {

	private ReplyPagingDTO replyPaging;
	private List<NoticeVO> noticeList;
	private List<QnaVO> qnaList;
	private long replyTotCnt;

	public ReplyPagingCreatorDTO(long replyTotCnt,
								 ReplyPagingDTO replyPaging,
							     List<NoticeVO> noticeList,
							 	 List<QnaVO> qnaList) {

		this.replyTotCnt = replyTotCnt;
		this.noticeList = noticeList;
		this.qnaList = qnaList;
		this.replyPaging = replyPaging;
	}

}