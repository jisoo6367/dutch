package com.spring.dutch.common.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.mapper.MemberSecurityMapper;

public class MemberUserDetailsServiceImpl implements UserDetailsService {
	
	private MemberSecurityMapper memberMapper ;
	
	@Autowired
	public void setMyMemberMapper(MemberSecurityMapper memberMapper) {
		this.memberMapper = memberMapper;
	}

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		
		UserDetails userDetails = new MemberUser(memberMapper.selectMember(email));
		
		return memberMapper.selectMember(email) == null ? null : userDetails;
	}
	
	
}
