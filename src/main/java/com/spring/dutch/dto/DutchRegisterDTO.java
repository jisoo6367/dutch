package com.spring.dutch.dto;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.spring.dutch.domain.DutchBoardVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DutchRegisterDTO {
	private long pno;
	private String category;
	private String mno ;             //회원고유번호
	private String ptitle ;        //방제목
	private String pcontent ;      //방내용
	private Date pregDate ;        //방생성일자
	private Timestamp pmodDate ;   //방수정일자
	private int pdelFlag ;         //방삭제요청
	private int pdelFlagAdmin;     //방삭제(관리자)
	private long ppersonal;        //개인부담금액
	private int ptotalPayment ;    //전체금액
	private int pcalculated ;
	private List<String> nickname;
}
