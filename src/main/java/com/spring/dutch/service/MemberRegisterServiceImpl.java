package com.spring.dutch.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.mapper.MemberRegisterMapper;

import lombok.Setter;

@Service
public class MemberRegisterServiceImpl implements MemberRegisterService{
	

	@Setter(onMethod_ = @Autowired)
    private PasswordEncoder pwencoder;
	
	private MemberRegisterMapper memberRegisterMapper;
	
	public MemberRegisterServiceImpl(MemberRegisterMapper memberRegisterMapper) {
		this.memberRegisterMapper = memberRegisterMapper;
	}

	@Override
	public String registerMember(MemberVO member) {
		member.setPassword(pwencoder.encode(member.getPassword()));
		member.setMno(UUID.randomUUID().toString());
		
		memberRegisterMapper.insertMember(member);
		
		memberRegisterMapper.insertAuthority(member);
		
		return member.getNickname();
	}

	@Override
	public String findNicknameService(MemberVO member) {
		
		return memberRegisterMapper.selectUserNickname(member);
	}
	
	@Override
	public String checkNicknameService(String nickname) {
		int check = memberRegisterMapper.selectNick(nickname);
		
		return check == 1 ? "exist" : "empty";
	}
}
