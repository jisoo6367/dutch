package com.spring.dutch.domain;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class DutchBoardVO {

	private long pno ;             //페이방고유번호
	private String category ;      //카테고리
	private String nickname ;      //회원고유닉네임
	private String ptitle ;        //방제목
	private String pcontent ;      //방내용
	private Date pregDate ;        //방생성일자
	private Date pmodDate ;   //방수정일자
	private int pdelFlag ;         //방삭제요청
	private int preport;     //방삭제(관리자)
	private long ppersonal;        //개인부담금액
	private int ptotalPayment ;    //전체금액
	private int pcalculated ;      //방정산완료

	private List<DutchAttachFileVO> dutchFileList;
}
