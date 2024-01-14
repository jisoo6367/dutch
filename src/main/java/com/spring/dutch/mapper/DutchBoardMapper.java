package com.spring.dutch.mapper;

import java.util.Date;
import java.util.List;

import com.spring.dutch.dto.DutchBoardPagingDTO;
import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.ParticipantsResultVO;
import com.spring.dutch.domain.ParticipantsVO;

public interface DutchBoardMapper {

	//게시물 목록조회(READ)
	public List<DutchBoardVO> selectDutchBoardList(DutchBoardPagingDTO ductPaging) ;

	//게시물 총수(READ)
	public long selectDutchRowTotal(DutchBoardPagingDTO dutchboardPaging);

	//더치페이 게시물 등록(CREATE)
	public int insertDutchBoard(DutchBoardVO dutchBoard);

	//더치페이 특정 게시물 조회(detail.jsp): 특정 게시물 데이터를 가져옴
	public DutchBoardVO selectDutchBoard(long pno);
	
	//방 등록하고나서 pno, pregDate, ppersonal 가져오는 메서드
	public DutchBoardVO selectForParticipants(DutchBoardVO boardVO);

	//방 등록하면서 회원닉네임 개인부담금액 방번호 방개설날짜 넣는 메서드 
	public int insertParticipants(List<ParticipantsVO> participants);


}