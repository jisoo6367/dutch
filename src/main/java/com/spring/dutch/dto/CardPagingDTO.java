package com.spring.dutch.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CardPagingDTO {
	
	private int pageNum ;
	private int rowAmountPerPage ;
	private String scope ;   //검색범위(scope - category: T, kname: C, kcompany: W)
	private String keyword ; //검색어
	
	//마이바티스 Setter
	public String[] getMyScopeArr() {
		return scope == null ? new String[] {} : scope.split("") ; //["T", "W"]
	}
	
	public CardPagingDTO(Integer pageNum, Integer rowAmountPerPage) {
		
		if (pageNum == null || pageNum <= 0) {
			this.pageNum = 1 ;
			
		} else {
			this.pageNum = pageNum;
		}
		
		if (rowAmountPerPage == null) {
			this.rowAmountPerPage = 4 ;
		
		} else {
			this.rowAmountPerPage = rowAmountPerPage;
		
		}
		
	}
}
