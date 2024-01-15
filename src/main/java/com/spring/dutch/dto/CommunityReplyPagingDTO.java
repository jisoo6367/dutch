package com.spring.dutch.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommunityReplyPagingDTO {

	private long tno ;
	private int pageNum ;
	private int rowAmountPerPage ;

	
	public CommunityReplyPagingDTO(long tno, Integer pageNum) {
		
		this.tno = tno ;
		
		if (pageNum == null) {
			this.pageNum = 1 ;
			
		} else {
			this.pageNum = pageNum;
		}
		
		this.rowAmountPerPage = 10 ;
		
	}
	
}
