package com.spring.dutch.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityPagingDTO {
  
	private int pageNum ;
	private int rowAmountPerPage ;
	private String scope ;   //검색범위(scope - ttitle: T, tcontent: C, twriter: W)
	private String keyword ; //검색어
	
	//@DateTimeFormat(pattern = "yyyy-MM-dd")  //java.util.Date
	private String beginDate ;
		
	//@DateTimeFormat(pattern = "yyyy-MM-dd")  //java.util.Date
	private String endDate ;
	
	//마이바티스 Setter
	public String[] getMyScopeArr() {
		return scope == null ? new String[] {} : scope.split("") ; //["T", "W"]
		
	}

	
//생성자: 목록 화면에서 사용자가 표시할 행수를 선택하고 페이징 번호 클릭 시,
//페이지번호와 행수를 각각 사용자가 선택한 페이징번호와 표시행수로 전달
	public CommunityPagingDTO(Integer pageNum, Integer rowAmountPerPage) {
	
		if (pageNum == null || pageNum <= 0) {
			this.pageNum = 1 ;
			
		} else {
			this.pageNum = pageNum;
		}
		
		if (rowAmountPerPage == null) {
			this.rowAmountPerPage = 10 ;
		
		} else {
			this.rowAmountPerPage = rowAmountPerPage;
		
		}
	
}
	
	
	
}
