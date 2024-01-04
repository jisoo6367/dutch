package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.dto.DutchBoardPagingDTO;
import com.spring.dutch.domain.DutchBoardVO;

public interface DutchBoardMapper {

	//게시물 목록조회(READ)
	public List<DutchBoardVO> selectDutchBoardList(DutchBoardPagingDTO ductPaging) ;

	//게시물 총수(READ)
	public long selectDutchRowTotal(DutchBoardPagingDTO dutchboardPaging);

	//더치페이 게시물 등록(CREATE)
	public int insertDutchBoard(DutchBoardVO dutchBoard);

	//더치페이 특정 게시물 조회(detail.jsp): 특정 게시물 데이터를 가져옴
	public DutchBoardVO selectDutchBoard(long pno);




}