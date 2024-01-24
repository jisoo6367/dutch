package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.domain.DutchAttachFileVO;

public interface DutchAttachFileMapper {

	//특정 게시물의 첨부파일 목록 조회
	public List<DutchAttachFileVO> selectAttachFiles(Long pno);
	
	//첨부파일 추가
	public void insertAttachFile(DutchAttachFileVO attachFile);
	
	//특정 첨부파일 삭제
	public void deleteAttachFile(String uuid);
	
	//특정 게시물의 모든 첨부파일 삭제
	public int deleteAttachFiles(Long pno);


}
