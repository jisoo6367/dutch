package com.spring.dutch.service;


import static org.hamcrest.CoreMatchers.instanceOf;

import org.springframework.stereotype.Service;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.mapper.MypageMapper;

@Service
public class MypageServiceImpl implements MypageService {

	private MypageMapper mypageMapper ;
	
	public MypageServiceImpl (MypageMapper mypageMapper) {
		this.mypageMapper = mypageMapper ;
	}
	
	//회원정보 가져오기
	@Override
	public MemberVO getMemberData (long mno) {
		
		MemberVO memberData = mypageMapper.selectMemberData(mno);
		
		return memberData;
	}
	
	
	//회원정보 수정 (UPDATE)
	@Override
	public int modifyMember(MemberVO member) {
		
		int memberModifyResult = mypageMapper.updateMember(member);
		

		return memberModifyResult;
	}

	
	//회원 탈퇴 (DELETE)
	@Override
	public boolean withdrawMember(long mno) {
		
		boolean memberDeleteResult = (mypageMapper.deleteMember(mno) == 1 ) ;
		
		return memberDeleteResult;
	}
	

	
	
	
}
