package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.dto.AdminDTO;

public interface AdminService {

	//전체고객 성별 카운트
	public long getGenderCnt (String gender);
	
	//전체고객 연령대 카운트
	public long getAgeCnt (String age);
	
	//월별 가입자 카운트
	public List<AdminDTO> getMonthlyRegisterCnt ();
	
	//더치페이방 신고수, 커뮤니티 신고수 카운트
	public AdminDTO getReportCnt() ;
}