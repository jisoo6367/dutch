package com.spring.dutch.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@NoArgsConstructor
@ToString
public class CommunityReplyVO {

	
	private long trno; 
    private long tno ;
    private String nickname;
    private String trcontent ;
    private Timestamp trmodDate ;
    private int trdelFlag;
    private Timestamp trregDate ;
    private int trrecommend ;
    private int trreport ;
    private int trcno ;
	
    private int lvl ;  //오라클 계층쿼리의 level 값을 저장할 필드

//	    trno number(10) NOT NULL, --커뮤니티댓글고유번호
//	    tno number(10)   NOT NULL, --커뮤니티고유번호
//	    mno number(10) NOT NULL, --회원고유번호
//      nickname VARCHAR2(100) NOT NULL, -- 닉네임
//	    trcontent varchar2(1000) NOT NULL, --댓글내용
//	    trmodDate Timestamp DEFAULT systimestamp(0), --댓글수정일자
//	    trdelFlag number(1) DEFAULT 0 NOT NULL, --댓글삭제요청
//	    trregDate date   DEFAULT sysdate   NOT NULL, --댓글생성일자
//      treplyCnt number(10) DEFAULT 0, --게시물의 댓글/답글 
//	    trrecommend number(5), --댓글추천수
//	    trreport number(5), --댓글신고수
//	    trcno number(10) --커뮤니티답글고유번호

}
