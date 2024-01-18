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
	
	
	
}
