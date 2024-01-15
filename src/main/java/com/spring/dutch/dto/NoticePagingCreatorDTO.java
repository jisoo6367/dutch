package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.NoticeVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class NoticePagingCreatorDTO {

	private NoticePagingDTO noticePaging ;
	
	private int startPagingNum;
	private int endPagingNum;
	private boolean prev;
	private boolean next;
	private long rowTotal; //행의 총 개수
	private int pagingNumCnt; //기본 10
	private int lastPageNum;
	private List<NoticeVO> noticeList;
	
	public NoticePagingCreatorDTO(long rowTotal,
								  NoticePagingDTO noticePaging,
							      List<NoticeVO> noticeList) {
		this.rowTotal = rowTotal;
		this.noticePaging = noticePaging;
		this.noticeList = noticeList;
		this.pagingNumCnt = 10;
		
		//계산 된 끝 페이징 번호:
		this.endPagingNum = (int) Math.ceil((double)noticePaging.getPageNum()/this.pagingNumCnt) * this.pagingNumCnt;
		
		//계산된 시작 페이징 번호:
		this.startPagingNum = this.endPagingNum - (this.pagingNumCnt -1) ;
		
		//총 페이지수 = 맨 마지막 페이지 번호
		this.lastPageNum = (int) Math.ceil((double)this.rowTotal / this.noticePaging.getRowAmountPerPage());
		
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
