package com.spring.dutch.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaReplyPagingDTO {

	private long qno;
	private int pageNum; //페이징번호
	private int rowAmountPerPage; //표시행수
	
	//목록에서 표시할 행수 선택하고 페이징 번호 클릭시 전달
	public QnaReplyPagingDTO(Long qno, Integer pageNum) {
		
		this.qno = qno;
		
		if (pageNum == null) {
			this.pageNum = 1 ;
			
		} else {
			this.pageNum = pageNum;
		}
		
		this.rowAmountPerPage = 10;
	}
	
}
