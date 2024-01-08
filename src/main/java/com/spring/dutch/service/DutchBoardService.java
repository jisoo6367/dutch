package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.ParticipantsVO;
import com.spring.dutch.dto.DutchBoardPagingCreatorDTO;
import com.spring.dutch.dto.DutchBoardPagingDTO;
import com.spring.dutch.dto.DutchRegisterDTO;

public interface DutchBoardService {

	//더치페이 목록조회(READ)
	public DutchBoardPagingCreatorDTO getDutchList(DutchBoardPagingDTO dutchPaging) ;

	//더치페이 게시물 등록(CREATE)
	public long DutchregisterBoard(DutchRegisterDTO dutchRegister);

	//특정 게시물 조회: 특정 게시물 하나의 데이터를 가져옴
	public DutchBoardVO getDutchBoard(long pno);
	


}
