package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.dto.MypageDTO;
import com.spring.dutch.domain.ParticipantsVO;

public interface MypageService {

	//회원정보 가져오기
	public MemberVO getMemberData (String nickname) ;
	
	//회원정보 수정 (UPDATE)
	public int modifyMember(MemberVO member);
	
	//회원 탈퇴 (DELETE)
	public boolean withdrawMember (String nickname);
	
	//회원 탈퇴시 권한 테이블 데이터도 삭제
	public boolean withdrawMemberAuth (String nickname);
	
	//나의 개인정산금액 가져오기
	public List<ParticipantsVO> getPersonal (String nickname);
	
	//더치페이 내역 방 갯수 가져오기
	public List<MypageDTO> getDutchCount (String nickname);
}
