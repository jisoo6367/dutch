package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.NoticeVO;
import com.spring.dutch.domain.QnaVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class QnaPagingCreatorDTO {

	private QnaPagingDTO qnaPaging ;
	
	private int startPagingNum;
	private int endPagingNum;
	private boolean prev;
	private boolean next;
	private long rowTotal; //행의 총 개수
	private int pagingNumCnt; //기본 10
	private int lastPageNum;
	private List<QnaVO> qnaList;
	
	public QnaPagingCreatorDTO(long rowTotal,
							   QnaPagingDTO qnaPaging,
							   List<QnaVO> qnaList) {
		this.rowTotal = rowTotal;
		this.qnaPaging = qnaPaging;
		this.qnaList = qnaList;
		this.pagingNumCnt = 10;
		
		//계산 된 끝 페이징 번호:
		this.endPagingNum = (int) Math.ceil((double)qnaPaging.getPageNum()/this.pagingNumCnt) * this.pagingNumCnt;
		
		//계산된 시작 페이징 번호:
		this.startPagingNum = this.endPagingNum - (this.pagingNumCnt -1) ;
		
		//총 페이지수 = 맨 마지막 페이지 번호
		this.lastPageNum = (int) Math.ceil((double)this.rowTotal / this.qnaPaging.getRowAmountPerPage());
		
		//맨 마지막 페이지번호를 endPagingNum에 대입
		if (this.lastPageNum < this.endPagingNum) {
			this.endPagingNum = this.lastPageNum ;
		}
		
		//이전 버튼 표시(true)여부
		this.prev = this.startPagingNum > 1 ;
		
		//다음 버튼 표시(true)여부
		this.next = this.endPagingNum < this.lastPageNum ;
		
		
	}
	
}
