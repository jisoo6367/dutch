package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.domain.ParticipantsVO;
import com.spring.dutch.dto.MypageDTO;
import com.spring.dutch.dto.MypagePagingNicknameDTOhistory;
import com.spring.dutch.dto.MypagePagingNicknameDTOongoing;

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
//	public List<ParticipantsVO> selectPersonal_0 (String nickname, MypagePagingDTO mypagePaging);
//	public List<ParticipantsVO> selectPersonal_1(String nickname, MypagePagingDTO mypagePaging);
	
	public List<ParticipantsVO> selectPersonal_0 (MypagePagingNicknameDTOongoing mypagePagingNickname);
	public List<ParticipantsVO> selectPersonal_1(MypagePagingNicknameDTOhistory mypagePagingNickname);
	
	
	//더치페이 내역 방 갯수 가져오기
	public MypageDTO selectDutchCount(String nickname);
	
	//게시물 총 개수 조회(페이징)
//	public long selectRowTotal_0(MypagePagingDTOongoing mypagePaging);
//	public long selectRowTotal_1(MypagePagingDTOhistory mypagePaging);
	public long selectRowTotal_0(MypagePagingNicknameDTOongoing mypagePaging);
	public long selectRowTotal_1(MypagePagingNicknameDTOhistory mypagePaging);
	
	//1:1 문의 갯수 가져오기
	public long selectQnaCnt (String nickname);
	
	//1:1문의 안 읽은 답변 갯수 가져오기
	public long selectQsignalCnt (String nickname);
}