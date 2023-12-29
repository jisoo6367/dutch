package com.spring.dutch.common.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.spring.dutch.mapper.MemberMapper;

public class MemberUserDetailsServiceImpl implements UserDetailsService {
	
	private MemberMapper memberMapper ;
	
	@Autowired
	public void setMyMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
