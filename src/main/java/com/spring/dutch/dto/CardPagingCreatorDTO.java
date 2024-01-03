package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.CardVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class CardPagingCreatorDTO {

	private CardPagingDTO cardPaging;
	
	private int startPagingNum ;
	private int endPagingNum ;
	private boolean prev ;
	private boolean next ;
	private long rowTotal ; //행의 총 개수
	private int pagingNumCnt ; //기본 10
	private int lastPageNum ;
	private List<CardVO> cardList;
	
	public CardPagingCreatorDTO(long rowTotal, 
			            		CardPagingDTO cardPaging,
			            		List<CardVO> cardList) {
			
			this.rowTotal = rowTotal ;
			this.cardPaging = cardPaging ;
			this.cardList = cardList ;
			this.pagingNumCnt = 5 ;
			
			//계산된 끝 페이징 번호:
			this.endPagingNum = (int) Math.ceil((double) cardPaging.getPageNum()/this.pagingNumCnt) * this.pagingNumCnt;
			
			//계산된 시작 페이징 번호:
			this.startPagingNum = this.endPagingNum - (this.pagingNumCnt -1) ;
			
			//총 페이지 수 = 맨 마지막 페이징번호
			this.lastPageNum = (int) Math.ceil((double)this.rowTotal / this.cardPaging.getRowAmountPerPage());
			
			//맨 마지막 페이지번호를 endPagingNum에 대입
			if (this.lastPageNum < this.endPagingNum) {
			this.endPagingNum = this.lastPageNum ;
			}
			
			//이전 버튼 표시(true) 여부
			this.prev = this.startPagingNum > 1 ;
			
			//다음 버튼 표시(true) 여부
			this.next = this.endPagingNum < this.lastPageNum ;
			
			
		}
}
