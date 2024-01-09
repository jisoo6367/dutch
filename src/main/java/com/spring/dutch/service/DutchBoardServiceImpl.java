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


	//모든 필드 초기화 생성자
	public DutchBoardServiceImpl(DutchBoardMapper dutchBoardMapper) {	
		this.dutchBoardMapper = dutchBoardMapper;

		System.out.println("DutchBoardServiceImpl의 모든 필드 초기화생성자입니다.");
		System.out.println("dutchBoardMapper: " + dutchBoardMapper);
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
		System.out.println("서비스 VO 구성 전");
		DutchBoardVO insertVO = null;
		insertVO.setPtitle(dutchRegister.getPtitle());
		insertVO.setCategory(dutchRegister.getCategory());
		insertVO.setMno(dutchRegister.getEmail());
		insertVO.setPcontent(dutchRegister.getPcontent());
		insertVO.setPpersonal(dutchRegister.getPpersonal());
		insertVO.setPtotalPayment(dutchRegister.getPtotalPayment());
		
		System.out.println("서비스 VO 구성 후");
		int pno = dutchBoardMapper.insertDutchBoard(insertVO);
		System.out.println("서비스 VO를 insertDutchBoard에 넣어서 보냄");
		DutchBoardVO boardVO = dutchBoardMapper.selectForParticipants(insertVO);
		System.out.println("서비스 VO를 selectForParticipants에 넣어서 보냄");
		ParticipantsResultVO pr = new ParticipantsResultVO();
		
		pr.setPno(boardVO.getPno());
		pr.setPtitle(boardVO.getPtitle());
		pr.setPregDate(boardVO.getPregDate());
		pr.setPpersonal(boardVO.getPpersonal());
		pr.setUserList(dutchRegister.getNickname());
		
		dutchBoardMapper.insertParticipants(pr);
		System.out.println("pr를 insertParticipants에 넣어서 보냄");
		return pno;
	}

	//더치페이 특정 게시물 조회 : 특정 게시물 하나의 데이터를 가져옴
	@Override
	public DutchBoardVO getDutchBoard(long pno) {

		DutchBoardVO dutchboard = dutchBoardMapper.selectDutchBoard(pno);

		return dutchboard;
	}





}