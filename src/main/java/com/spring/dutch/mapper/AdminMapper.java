package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.dto.AdminDTO;

public interface AdminMapper {

	//전체멤버 성별 카운트
	public long genderCnt (String gender);
	
	//전체멤버 연령대 카운트
	public long ageCnt (String age);
	
	//월별 가입자 카운트
	public List<AdminDTO> registerCnt ();
	
	//더치페이방 신고수, 커뮤니티 신고수 카운트
	public AdminDTO reportCnt();
}