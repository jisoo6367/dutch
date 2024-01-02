package com.spring.dutch.service;

import org.springframework.stereotype.Service;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.mapper.MemberRegisterMapper;

@Service
public class MemberRegisterServiceImpl implements MemberRegisterService{
	private MemberRegisterMapper memberRegisterMapper;
	
	public MemberRegisterServiceImpl(MemberRegisterMapper memberRegisterMapper) {
		this.memberRegisterMapper = memberRegisterMapper;
	}

	@Override
	public String registerMember(MemberVO member) {
		
		memberRegisterMapper.insertMember(member);
		
		
		return member.getEmail();
	}
	
	
}
