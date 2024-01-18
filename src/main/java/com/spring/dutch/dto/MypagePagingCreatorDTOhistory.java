package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.ParticipantsVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MypagePagingCreatorDTOhistory {

	private MypagePagingDTOhistory mypagePaging ; 

	private int startPagingNum_1 ;
	private int endPagingNum_1 ;
	private boolean prev_1 ; 
	private boolean next_1 ;
	private long rowTotal_1 ; 
	private int pagingNumCnt_1 ;
	private int lastPageNum_1 ;
	private List<ParticipantsVO> dutchlist ; 

	public MypagePagingCreatorDTOhistory(long rowTotal_1, 
									MypagePagingDTOhistory mypagePaging, 
									List<ParticipantsVO> dutchlist) {
		this.rowTotal_1 = rowTotal_1 ;
		this.mypagePaging = mypagePaging ;
		this.dutchlist = dutchlist ;
		this.pagingNumCnt_1 = 5 ;	

		//계산된 끝 페이징 번호:
		this.endPagingNum_1 = (int) Math.ceil((double) mypagePaging.getPageNum_1()/this.pagingNumCnt_1) * this.pagingNumCnt_1;

		//계산된 시작 페이징 번호:
		this.startPagingNum_1 = this.endPagingNum_1 - (this.pagingNumCnt_1 -1) ;

		//총 페이지 수 = 맨 마지막 페이지번호
		this.lastPageNum_1 = (int) Math.ceil((double)this.rowTotal_1 / this.mypagePaging.getRowAmountPerPage());

		//맨 마지막 페이지번호를 endPagingNum_1에 대입
		if (this.lastPageNum_1 < this.endPagingNum_1) {
			this.endPagingNum_1 = this.lastPageNum_1 ;
		}

		//이전 버튼 표시(true) 여부
		this.prev_1 = this.startPagingNum_1 > 1 ;

		//다음 버튼 표시(true) 여부
		this.next_1 = this.endPagingNum_1 < this.lastPageNum_1 ;

		System.out.println("전달된 페이징 기본데이터-mypagePagingDTO: " + this.mypagePaging.toString());
		System.out.println("시작 페이징번호: " + this.startPagingNum_1);
		System.out.println("끝 페이징번호: " + this.endPagingNum_1);
		System.out.println("이전버튼 표시 여부: " + this.prev_1);
		System.out.println("다음버튼 표시 여부: " + this.next_1);
		System.out.println("마지막 페이지 번호: " + this.lastPageNum_1);
		System.out.println("표시할 데이터: " + this.dutchlist);

	}

}
