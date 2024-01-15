package com.spring.dutch.mapper;

import java.util.List;

import com.spring.dutch.domain.CommunityAttachFileVO;

public interface CommunityAttachFileMapper {
	
	public List<CommunityAttachFileVO> selectAttachFiles(Long tno) ;
	
	//첨부파일 추가
	public void insertAttachFile(CommunityAttachFileVO attachFile) ;
	
	//특정 첨부파일 삭제
	public void deleteAttachFile(String uuid) ;
	
	//특정 게시물의 모든 첨부파일 삭제
	//게시물 삭제 시, 해당 게시물의 모든 첨부파일을 삭제해야 게시물이 삭제됨
	//(on delete cascade 옵션이 없는 F.K인 경우),  
	public int deleteAttachFiles(Long tno) ;

}
