package com.spring.dutch.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.dto.MypageDTO;
import com.spring.dutch.domain.ParticipantsVO;
import com.spring.dutch.mapper.MypageMapper;

import lombok.Setter;

@Service
public class MypageServiceImpl implements MypageService {

	private MypageMapper mypageMapper ;
	
	public MypageServiceImpl (MypageMapper mypageMapper) {
		this.mypageMapper = mypageMapper ;
	}
	
	
	@Setter(onMethod_ = @Autowired)
    private PasswordEncoder pwencoder;
	
	//회원정보 가져오기
	@Override
	public MemberVO getMemberData (String nickname) {
		
		MemberVO memberData = mypageMapper.selectMemberData(nickname);
		
		return memberData;
	}
	
	
	//회원정보 수정 (UPDATE)
	@Override
	public int modifyMember(MemberVO member) {
		

		//변경한 비밀번호 인코더처리
		member.setPassword(pwencoder.encode(member.getPassword()));
		
		int memberModifyResult = mypageMapper.updateMember(member);
		

		return memberModifyResult;
	}

	
	//회원 탈퇴 (DELETE)
	@Override
	public boolean withdrawMember(String nickname) {
		
		boolean memberDeleteResult = (mypageMapper.deleteMember(nickname) == 1 ) ;
		
		return memberDeleteResult;
	}
	
	//회원 탈퇴시 권한테이블 데이터도 삭제
	@Override
	public boolean withdrawMemberAuth(String nickname) {
		
		boolean memberAuthDeleteResult = (mypageMapper.deleteMember(nickname) == 1 ) ;
		
		return memberAuthDeleteResult;
	}


	//나의 개인정산금액 가져오기
	@Override
	public List<ParticipantsVO> getPersonal(String nickname) {

		List<ParticipantsVO> personalData = mypageMapper.selectPersonal(nickname);
		
		return personalData;
	}

	//더치페이 내역 방 갯수 가져오기
	@Override
	public List<MypageDTO> getDutchCount(String nickname) {
		
		List<MypageDTO> dutchCount = mypageMapper.selectDutchCount(nickname);
		
		return dutchCount;
	}

	
	
	
	
	
	
}
