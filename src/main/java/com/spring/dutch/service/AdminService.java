package com.spring.dutch.service;


public interface AdminService {

	//전체고객 성별 카운트
	public long getGenderCnt (String gender);
	
	//전체고객 연령대 카운트
	public long getAgeCnt (String age);
	
	//월별 가입자 카운트
	public long getMonthlyMemberCnt (String regDate);
}