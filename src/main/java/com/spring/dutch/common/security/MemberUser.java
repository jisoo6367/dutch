package com.spring.dutch.common.security;

import java.util.stream.Collectors;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.spring.dutch.domain.MemberVO;

public class MemberUser extends User{
	private static final long serialVersionUID = 1L;
	
	@SuppressWarnings("unused")
	private MemberVO member;
	
	public MemberUser(MemberVO member) {
		super(member.getEmail(),
			  member.getPassword(),
			  member.getAuthorityList()
				  		  .stream()
				  		  .map(myauth -> new SimpleGrantedAuthority(myauth.getAuthority()))
				  		  .collect(Collectors.toList())
		);
		
		this.member = member;
	}
	
}
