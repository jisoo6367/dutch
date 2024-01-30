package com.spring.dutch.mapper;



public interface AdminMapper {

	//전체멤버 성별 카운트
	public long genderCnt (String gender);
	
	//전체멤버 연령대 카운트
	public long ageCnt (String age);
	
	//월별 가입자 카운트
	public long monthlyMemberCnt (String regDate);
	
}