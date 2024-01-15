package com.spring.dutch.domain;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

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
public class QnaReplyVO {

	private Long qrno; //댓글고유번호
	private Long qno; //리스트고유번호
	private String nickname;
	private String qrcontent; //댓글내용
	private int qrdelFlag; //삭제요청 '1'삭제
	private Date qrregDate; //댓글생성일
	private Timestamp qrmodDate; //댓글수정일
	private int qrcno; //답글고유번호
	
	private int lvl; //오라클 계층쿼리의 level 값을 저장할 필드
	
	/*
	qrno number(10,0) primary key,--일대일댓글고유번호
	qno number(10,0) not null,--리스트고유번호
	mno number(10,0) not null,--회원고유번호
	qrcontent varchar2(100) not null,--댓글내용
	qrdelFlag number(1) DEFAULT '0',--댓글삭제요청 '1'삭제
	qrregDate DATE DEFAULT sysdate,--댓글생성일
	qrmodDate TIMESTAMP(0) DEFAULT systimestamp(0), --댓글수정일
	qrcno number(10) not null--일대일답글고유번호
	*/
	
	
}
