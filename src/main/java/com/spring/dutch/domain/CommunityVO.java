package com.spring.dutch.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class CommunityVO {

	
	private long tno;
	private long mno;
	private String nickname;
	private String ttitle;
	private String tcontent;
	private Timestamp tmodDate;
	private int tdelFlag;
	private Timestamp tregDate;
	private int tviewCnt;
    private int treplyCnt;
	private int trecommend;
	private int treport;
	private String tcategory;
	
	private List<CommunityAttachFileVO> 
				attachFileList ;

//	   tno   number(10) NOT NULL, --커뮤니티고유번호
//	   mno   number(10) NOT NULL, --회원고유번호
//	   nickname VARCHAR2(100) NOT NULL, -- 닉네임
//	   ttitle varchar2(100) NOT NULL, --방제목
//	   tcontent varchar2(1000)   NOT NULL, --게시글내용
//	   tmodDate Timestamp DEFAULT systimestamp(0), --게시글수정일자
//	   tdelFlag number(1) DEFAULT 0 NOT NULL, --게시글삭제요청
//	   tregDate date DEFAULT sysdate NOT NULL, --게시글생성일자
//	   tviewCnt number(10), --게시글조회수
//	   trecommend number(5), --게시글추천수
//	   treport   number(5), --게시글신고수
//	   tcategory varchar2(10) --커뮤니티카테고리
	
	
	
}
