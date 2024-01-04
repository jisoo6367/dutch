package com.spring.dutch.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardPagingDTO {

	private int pageNum; //페이징번호
	private int rowAmountPerPage; //표시행수
	private String scope; //검색범위검색범위(scope - btitle: T, bcontent: C, bwriter: W)
	private String keyword; //검색어

	//마이바티스 Setter
	public String[] getScopeArr() {
		return scope == null ? new String[] {} : scope.split("");
	}

	//목록에서 표시할 행수 선택하고 페이징 번호 클릭시 전달
	public BoardPagingDTO(Integer pageNum, Integer rowAmountPerPage) {

		if(pageNum == null || pageNum <= 0) {
			this.pageNum = 1;
		}else {
			this.pageNum = pageNum;
		}

		if(rowAmountPerPage == null) {
			this.rowAmountPerPage = 10; //10페이지씩 보여줌
		}else {
			this.rowAmountPerPage = rowAmountPerPage;
		}
	}

}