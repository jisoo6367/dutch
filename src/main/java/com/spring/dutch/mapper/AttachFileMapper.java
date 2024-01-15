package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.domain.AttachFileVO;

public interface AttachFileMapper {

	//특정 게시물의 첨부파일 목록 조회
	public List<AttachFileVO> selectAttachFiles(Long qno);
	//Long qno
	
	//첨부파일 추가
	public void insertAttachFile(AttachFileVO attachFile);
	
	//특정 첨부파일 삭제
	public void deleteAttachFile(String uuid);
	
	//특정 게시물의 모든 첨부파일 삭제
	public int deleteAttachFiles(Long qno);//개인용 
	//String nickname
	
	
	
}
