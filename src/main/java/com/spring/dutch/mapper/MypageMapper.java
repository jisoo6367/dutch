package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.dto.MypageDTO;
import com.spring.dutch.domain.ParticipantsVO;

public interface MypageMapper {

	//회원정보 가져오기
	public MemberVO selectMemberData(String nickname);
	
	//회원정보 수정 (UPDATE)
	public int updateMember(MemberVO member);
	
	//회원 탈퇴 (DELETE)
	public int deleteMember(String nickname);
	
	//회원 탈퇴시 권한테이블도 삭제
	public int deleteMemberAuth(String nickname);
	
	//나의 개인정산금액 가져오기 
	public List<ParticipantsVO> selectPersonal(String nickname);
	
	//더치페이 내역 방 갯수 가져오기
	public List<MypageDTO> selectDutchCount(String nickname);
}
