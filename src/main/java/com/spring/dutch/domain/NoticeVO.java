package com.spring.dutch.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class NoticeVO {

	private Long cno; //리스트고유번호
	private Long mno; //회원고유번호
	private String ctitle; //제목
	private Date cregDate; //생성일
	private int cviewCnt; //조회수
	private String ccontent; //내용
	private String ccategory; //카테고리

	/*
	cno number(10,0) primary key,--리스트고유번호
	mno number(10,0) not null,--회원고유번호
	ctitle varchar2(100) NOT NULL, --제목
	cregDate DATE DEFAULT sysdate, --생성일자
	cviewCnt number(5), --조회수
	ccontent varchar2(1000), --내용
	ccategory varchar2(100),--카테고리 
	*/
}
