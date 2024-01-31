package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.domain.DutchAttachFileVO;
import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.dto.DutchAndPartiListDTO;
import com.spring.dutch.dto.DutchBoardPagingCreatorDTO;
import com.spring.dutch.dto.DutchBoardPagingDTO;
import com.spring.dutch.dto.DutchModifyDTO;
import com.spring.dutch.dto.DutchRegisterDTO;

public interface DutchBoardService {

	//더치페이 목록조회(READ)
	public DutchBoardPagingCreatorDTO getDutchList(DutchBoardPagingDTO dutchPaging) ;

	//더치페이 게시물 등록(CREATE)
	public long registerDutchBoard(DutchRegisterDTO dutchRegister);

	//특정 게시물 조회: 특정 게시물 하나의 데이터를 가져옴
	public DutchAndPartiListDTO getDutchBoard(long pno);
	
	//게시물 수정
	public boolean modifyDutchBoard(DutchModifyDTO participants, DutchBoardVO boardVO, long bno) ;

	//게시물 삭제
	public boolean deleteDutchBoard(long pno);
	
	//특정 게시물의 첨부파일 목록 조회
	public List<DutchAttachFileVO> getAttachFileList(Long pno);
	
	//특정 게시물의 서버 업로드 파일 삭제
	public void removeAttachFiles(List<DutchAttachFileVO> attachFileList) ;
	
	//정산 완료
	public boolean updatePcalculated (long pno);
	
	//게시물 신고 (UPDATE)
	public boolean updatePreport(long pno);

}
