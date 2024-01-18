package com.spring.dutch.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.dutch.domain.MemberVO;
import com.spring.dutch.domain.ParticipantsVO;
import com.spring.dutch.dto.MypageDTO;
import com.spring.dutch.dto.MypagePagingCreatorDTOhistory;
import com.spring.dutch.dto.MypagePagingCreatorDTOongoing;
import com.spring.dutch.dto.MypagePagingNicknameDTOhistory;
import com.spring.dutch.dto.MypagePagingNicknameDTOongoing;
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
		System.out.println("====================서비스임플의 memberData: " + memberData);
		
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


	//나의 개인정산금액 리스트 가져오기
//	//정산중인 방 : 0
//	@Override
//	public List<ParticipantsVO> getPersonal_0(String nickname) {
//		System.out.println("====================서비스 nickname : "+ nickname);
//		List<ParticipantsVO> personalData_0 = mypageMapper.selectPersonal_0(nickname);
//
//	
//		System.out.println("====================서비스 personalData_0 : "+ personalData_0);
//		return personalData_0;
//	}
//	//정산완료방 : 1
//	@Override
//	public List<ParticipantsVO> getPersonal_1(String nickname) {
//		System.out.println("====================서비스 nickname : "+ nickname);
//		List<ParticipantsVO> personalData_1 = mypageMapper.selectPersonal_1(nickname);
//
//	
//		System.out.println("====================서비스 personalData_1 : "+ personalData_1);
//		return personalData_1;
//	}
	
	

    @Override
    public MypagePagingCreatorDTOongoing getPersonal_0(MypagePagingNicknameDTOongoing mypagePagingNicknameDTO) {
        long rowTotal = mypageMapper.selectRowTotal_0(mypagePagingNicknameDTO);
        List<ParticipantsVO> personalData_0 = mypageMapper.selectPersonal_0(mypagePagingNicknameDTO);
        System.out.println("===================personalData_0: "+ personalData_0);

        return new MypagePagingCreatorDTOongoing(rowTotal, mypagePagingNicknameDTO.getMypagePaging(), personalData_0);
    }
    @Override
    public MypagePagingCreatorDTOhistory getPersonal_1(MypagePagingNicknameDTOhistory mypagePagingNicknameDTO) {
        long rowTotal = mypageMapper.selectRowTotal_1(mypagePagingNicknameDTO);
        List<ParticipantsVO> personalData_1 = mypageMapper.selectPersonal_1(mypagePagingNicknameDTO);
        return new MypagePagingCreatorDTOhistory(rowTotal, mypagePagingNicknameDTO.getMypagePaging(), personalData_1);
    }

	
	
////	정산중인 방 : 0
//	@Override
//	public MypagePagingCreatorDTO getPersonal_0(String nickname, MypagePagingDTO mypagePaging) {
//		
//		long rowTotal = mypageMapper.selectRowTotal_0(mypagePaging);
//		System.out.println("==========여기까진 되나요? rowTotal: "+ rowTotal);
//		
//		List<ParticipantsVO> personalData_0 = mypageMapper.selectPersonal_0(nickname, mypagePaging);
//		System.out.println("===========================personalData_0 : " + personalData_0);
//		
//		return new MypagePagingCreatorDTO (rowTotal,
//											mypagePaging,
//											personalData_0);
//	}
//	//정산완료방 : 1
//	@Override
//	public MypagePagingCreatorDTO getPersonal_1(String nickname, MypagePagingDTO mypagePaging) {
//		
//		long rowTotal = mypageMapper.selectRowTotal_1(mypagePaging);
//
//		List<ParticipantsVO> personalData_1 = mypageMapper.selectPersonal_1(nickname, mypagePaging);
//		
//		return new MypagePagingCreatorDTO (rowTotal,
//											mypagePaging,
//											personalData_1);
//	}


	
	
	//더치페이 내역 방 갯수 가져오기
	@Override
	public MypageDTO getDutchCount(String nickname) {
		System.out.println("====================서비스 카운트 nickname : "+ nickname);
		MypageDTO dutchCount = mypageMapper.selectDutchCount(nickname);


		System.out.println("====================서비스 dutchCount : "+ dutchCount);
		
		return dutchCount;
	}

	
	
	
	
	
	
}
