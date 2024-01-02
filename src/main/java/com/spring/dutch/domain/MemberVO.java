package com.spring.dutch.domain;

import java.sql.Timestamp;
import java.util.List;

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
public class MemberVO {
	
	private long mno;
	private String nickname;
	private String bank;
	private long bankAccount;
	private String username;
	private String email;
	private String password;
	private long hp;
	private long cellphone;
	private Timestamp regDate;
	private Timestamp modDate;
	private int delFlag;
	private String loginType;
	private String gender;
	private String age;
	private boolean enabled;
	private List<AuthorityVO> authorityList;
	private boolean accountNonExpired;
	
	
	/*
	 * mno NUMBER(10,0) PRIMARY KEY, -- 회원정보 고유번호 
	 * nickname VARCHAR2(100) , -- 닉네임
	 * bank VARCHAR2(100) , -- 은행 종류 
	 * bank_account NUMBER(20) UNIQUE, -- 계좌번호
	 * kakao_nickname VARCHAR2(100) , --카카오 닉네임 
	 * naver_nickname VARCHAR2(100) , --네이버 닉네임 
	 * google_nickname VARCHAR2(100) , -- 구글 닉네임 
	 * username VARCHAR2(100) NOT NULL , -- 실명 
	 * email VARCHAR2(100) NOT NULL UNIQUE, --이메일(로그인시 사용) 
	 * password VARCHAR2(100) NOT NULL, -- 비밀번호 
	 * hp NUMBER(14) UNIQUE , -- 전화번호 
	 * cellphone NUMBER(14) UNIQUE , -- 휴대폰번호 
	 * reg_date DATE DEFAULT sysdate NOT NULL, -- 가입일자
	 * mod_date TIMESTAMP(0) DEFAULT SYSTIMESTAMP(0) , -- 수정일자 (밀리초 X) 
	 * del_flag NUMBER(1) DEFAULT 0 NOT NULL, --탈퇴 요청 (1: 삭제요청(Y) , 0: 유지(N)) 
	 * kakao_email VARCHAR2(100) , -- 카카오 이메일 
	 * kakao_gender VARCHAR2(100) , -- 카카오 성별
	 * kakao_username VARCHAR2(100) , -- 카카오 실명 
	 * kakao_age_range VARCHAR2(100) , -- 카카오 연령대 
	 * naver_email VARCHAR2(100) , -- 네이버 이메일 
	 * naver_gender VARCHAR2(100) ,-- 네이벌 성별 
	 * naver_username VARCHAR2(100) , -- 네이버 실명 
	 * naver_age_range VARCHAR2(100) , -- 네이버 연령대 
	 * google_email VARCHAR2(100) , -- 구글 이메일
	 * google_gender VARCHAR2(100) , -- 구글 성별 
	 * google_username VARCHAR2(100) , -- 구글실명 
	 * google_age_range VARCHAR2(100) , -- 구글 연령대 
	 * enabled CHAR(1) DEFAULT 1 --시큐리티
	 */
}
