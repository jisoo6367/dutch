package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.domain.MemberVO;

public interface MypageService {

	//회원정보 가져오기
	public MemberVO getMemberData (long mno) ;
	
	//회원정보 수정 (UPDATE)
	public int modifyMember(MemberVO member);
	
	//회원 탈퇴 (DELETE)
	public boolean withdrawMember (long mno);
}
