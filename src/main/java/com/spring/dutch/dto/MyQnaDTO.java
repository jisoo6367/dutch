package com.spring.dutch.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MyQnaDTO {
	private QnaPagingDTO qnaPaging;
	private String nickname;
	
}
