package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.ParticipantsVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MypagePagingCreatorDTOongoing {

	private MypagePagingDTOongoing mypagePaging ; 

	private int startPagingNum_0 ;
	private int endPagingNum_0 ;
	private boolean prev_0 ; 
	private boolean next_0 ;
	private long rowTotal_0 ; 
	private int pagingNumCnt_0 ;
	private int lastPageNum_0 ;
	private List<ParticipantsVO> dutchlist ; 

	public MypagePagingCreatorDTOongoing(long rowTotal_0, 
									MypagePagingDTOongoing mypagePaging, 
									List<ParticipantsVO> dutchlist) {
		this.rowTotal_0 = rowTotal_0 ;
		this.mypagePaging = mypagePaging ;
		this.dutchlist = dutchlist ;
		this.pagingNumCnt_0 = 5 ;	

		//계산된 끝 페이징 번호:
		this.endPagingNum_0 = (int) Math.ceil((double) mypagePaging.getPageNum_0()/this.pagingNumCnt_0) * this.pagingNumCnt_0;

		//계산된 시작 페이징 번호:
		this.startPagingNum_0 = this.endPagingNum_0 - (this.pagingNumCnt_0 -1) ;

		//총 페이지 수 = 맨 마지막 페이지번호
		this.lastPageNum_0 = (int) Math.ceil((double)this.rowTotal_0 / this.mypagePaging.getRowAmountPerPage());

		//맨 마지막 페이지번호를 endPagingNum_0에 대입
		if (this.lastPageNum_0 < this.endPagingNum_0) {
			this.endPagingNum_0 = this.lastPageNum_0 ;
		}

		//이전 버튼 표시(true) 여부
		this.prev_0 = this.startPagingNum_0 > 1 ;

		//다음 버튼 표시(true) 여부
		this.next_0 = this.endPagingNum_0 < this.lastPageNum_0 ;

		System.out.println("전달된 페이징 기본데이터-mypagePagingDTO: " + this.mypagePaging.toString());
		System.out.println("시작 페이징번호: " + this.startPagingNum_0);
		System.out.println("끝 페이징번호: " + this.endPagingNum_0);
		System.out.println("이전버튼 표시 여부: " + this.prev_0);
		System.out.println("다음버튼 표시 여부: " + this.next_0);
		System.out.println("마지막 페이지 번호: " + this.lastPageNum_0);
		System.out.println("표시할 데이터: " + this.dutchlist);

	}

}
