package com.spring.dutch.service;

import org.springframework.stereotype.Service;

import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.dto.DutchBoardPagingCreatorDTO;
import com.spring.dutch.dto.DutchBoardPagingDTO;
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
	public long DutchregisterBoard(DutchBoardVO dutchBoard) {

		dutchBoardMapper.insertDutchBoard(dutchBoard);

		return dutchBoard.getPno();
	}

	//더치페이 특정 게시물 조회 : 특정 게시물 하나의 데이터를 가져옴
	@Override
	public DutchBoardVO getDutchBoard(long pno) {

		DutchBoardVO dutchboard = dutchBoardMapper.selectDutchBoard(pno);

		return dutchboard;
	}





}