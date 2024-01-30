package com.spring.dutch.service;

import org.springframework.stereotype.Service;

import com.spring.dutch.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {

	private AdminMapper adminMapper ;
	
	public AdminServiceImpl (AdminMapper adminMapper) {
		this.adminMapper = adminMapper ;
	}
	
	//전체고객 성별 카운트
	public long getGenderCnt (String gender) {
		
		long genderCntResult = adminMapper.genderCnt(gender);
				
		return genderCntResult;
	}
	
	
	//전체고객 연령대 카운트
	public long getAgeCnt (String age) {
		
		long ageCntResult = adminMapper.ageCnt(age);
		
		return ageCntResult;
	}
	
	//월별 가입자 카운트
	public long getMonthlyMemberCnt (String regDate) {
		System.out.println("==============="+regDate);
		long monthlyMemberCntResult = adminMapper.monthlyMemberCnt(regDate);
		System.out.println("==============monthlyMemberCntResult: " + monthlyMemberCntResult);
		
		return monthlyMemberCntResult;
	}
	
}