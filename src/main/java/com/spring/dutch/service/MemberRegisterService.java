package com.spring.dutch.service;

import com.spring.dutch.domain.MemberVO;

public interface MemberRegisterService {
	public String registerMember(MemberVO member);
	
	public String findNicknameService(MemberVO member);
	
	public String checkNicknameService(String nickname);
}
