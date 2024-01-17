package com.spring.dutch.mapper;

import com.spring.dutch.domain.MemberVO;

public interface MemberRegisterMapper {
	public int insertMember(MemberVO member) ;
	
	public int insertAuthority(MemberVO member);
	
	public String selectUserNickname(MemberVO member);
	
	public int selectNick(String nickname);
}
