package com.spring.dutch.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.dutch.dto.AdminDTO;
import com.spring.dutch.mapper.AdminMapper;

import lombok.extern.log4j.Log4j;

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
	public List<AdminDTO> getMonthlyRegisterCnt () {
		
		List<AdminDTO> monthlyRegisterCntResult = adminMapper.registerCnt();
		System.out.println("==============monthlyRegisterCntResult: " + monthlyRegisterCntResult);
		
		return monthlyRegisterCntResult;
	}
	
	//더치페이방 신고수, 커뮤니티 신고수 카운트
	public AdminDTO getReportCnt() {
		
		AdminDTO reportResult = adminMapper.reportCnt();
		System.out.println("==========reportResult : " + reportResult);
		return reportResult;
	}
	
}