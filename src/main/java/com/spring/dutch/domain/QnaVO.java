package com.spring.dutch.domain;

import java.sql.Timestamp;
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
public class QnaVO {

	private Long qno; //리스트고유번호
	private Long mno; //회원고유번호
	private String qtitle; //제목
	private String qcontent; //내용
	private Date qregDate; //생성일자
	private Timestamp qmodDate; //수정일자
	private int qdelFlag; //삭제 '1'삭제
	private int qdelFlagAdmin; //삭제요청 '1'삭제
	private int qsignal; //'1'시그널보냄

	/*
	qno number(10,0) primary key,--리스트고유번호
	mno number(10,0) NOT NULL,--회원고유번호
	qtitle varchar2(100) not null,--제목
	qregDate DATE DEFAULT sysdate,--생성일자
	qmodDate TIMESTAMP(0) DEFAULT systimestamp(0),--수정일자
	qdelFlag number(1) DEFAULT '0',--삭제요청 '1'삭제
	qdelFlagAdmin number(1) DEFAULT '0',--삭제요청 '1'삭제
	qsignal number(1) DEFAULT '0',--삭제요청 '1'시그널보냄
	qcontent varchar2(900) NOT NULL,--내용
	*/

}