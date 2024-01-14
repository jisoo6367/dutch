package com.spring.dutch.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.ParticipantsResultVO;
import com.spring.dutch.domain.ParticipantsVO;
import com.spring.dutch.dto.DutchBoardPagingCreatorDTO;
import com.spring.dutch.dto.DutchBoardPagingDTO;
import com.spring.dutch.dto.DutchRegisterDTO;
import com.spring.dutch.mapper.DutchBoardMapper;

@Service
public class DutchBoardServiceImpl implements DutchBoardService{

	private DutchBoardMapper dutchBoardMapper ;

	public DutchBoardServiceImpl(DutchBoardMapper dutchBoardMapper) {	
		this.dutchBoardMapper = dutchBoardMapper;
	}

	//더치페이 목록 조회
	@Override
	public DutchBoardPagingCreatorDTO getDutchList(DutchBoardPagingDTO dutchPaging) {



		return new DutchBoardPagingCreatorDTO(dutchBoardMapper.selectDutchRowTotal(dutchPaging), 
				                              dutchPaging, 
				                              dutchBoardMapper.selectDutchBoardList(dutchPaging));
	}

	//더치페이 등록 
	@Override
	public long DutchregisterBoard(DutchRegisterDTO dutchRegister) {
		System.out.println("서비스 VO 구성 전" + dutchRegister);
		DutchBoardVO insertVO = new DutchBoardVO();
		
		insertVO.setPtitle(dutchRegister.getPtitle());
		System.out.println("setPtitle");
		insertVO.setCategory(dutchRegister.getCategory());
		System.out.println("setCategory");
		insertVO.setNickname(dutchRegister.getNickname());
		System.out.println("setNickname");
		insertVO.setPcontent(dutchRegister.getPcontent());
		System.out.println("setPcontent");
		insertVO.setPpersonal(dutchRegister.getPpersonal());
		System.out.println("setPpersonal");
		insertVO.setPtotalPayment(dutchRegister.getPtotalPayment());
		System.out.println("setPtotal");
		
		System.out.println("서비스 VO 구성 후");
		dutchBoardMapper.insertDutchBoard(insertVO);
		System.out.println("서비스 VO를 insertDutchBoard에 넣어서 보냄");
		
		DutchBoardVO boardVO = dutchBoardMapper.selectForParticipants(insertVO);
		System.out.println("서비스 VO를 selectForParticipants에 넣어서 보냄");
		
		List<ParticipantsVO> participants = dutchRegister.getParticipants();
		System.out.println("participants: " + participants);
		participants.forEach(item -> {
			
			item.setPno(boardVO.getPno());
			item.setPtitle(boardVO.getPtitle());
			item.setPregDate(boardVO.getPregDate());
			item.setPpersonal(boardVO.getPpersonal());
			item.setPcalculated(boardVO.getPcalculated());
		});
		
		System.out.println("participants: " + participants);
		dutchBoardMapper.insertParticipants(participants);
		System.out.println("participants를 insertParticipants에 넣어서 보냄");
		return boardVO.getPno();
	}

	//더치페이 특정 게시물 조회 : 특정 게시물 하나의 데이터를 가져옴
	@Override
	public DutchBoardVO getDutchBoard(long pno) {

		DutchBoardVO dutchboard = dutchBoardMapper.selectDutchBoard(pno);

		return dutchboard;
	}





}