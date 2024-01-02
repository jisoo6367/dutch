package com.spring.dutch.mapper;

import com.spring.dutch.domain.MemberVO;

public interface MemberSecurityMapper {
	public MemberVO selectMember(String email) ;
}
