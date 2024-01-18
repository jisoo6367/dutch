package com.spring.dutch.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MypagePagingDTOongoing {

	private int pageNum_0 ;
	private int rowAmountPerPage ;


	//생성자: 목록 화면에서 사용자가 표시할 행수를 선택하고 페이징 번호 클릭 시,
	//페이지번호와 행수를 각각 사용자가 선택한 페이징번호와 표시행수로 전달
	public MypagePagingDTOongoing(Integer pageNum_0, Integer rowAmountPerPage) {

		if (pageNum_0 == null || pageNum_0 <= 0) {
			this.pageNum_0 = 1 ;

		} else {
			this.pageNum_0 = pageNum_0;
		}

		if (rowAmountPerPage == null) {
			this.rowAmountPerPage = 5 ;

		} else {
			this.rowAmountPerPage = rowAmountPerPage;

		}

	}	

}
