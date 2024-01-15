package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.domain.AttachFileVO;
import com.spring.dutch.domain.NoticeVO;
import com.spring.dutch.dto.NoticePagingCreatorDTO;
import com.spring.dutch.dto.NoticePagingDTO;

public interface NoticeService {

	//공지사항 목록조회(READ)
//	public List<NoticeVO> getNoticeList(NoticePagingDTO noticePaging);
	public NoticePagingCreatorDTO getNoticeList(NoticePagingDTO noticePaging);
	
	//공지사항 등록(CREATE)
	public long registerNotice(NoticeVO notice);
	
	//특정 게시물 조회: 하나의 데이터를 가져옴(조회수 1 증가 고려)
	public NoticeVO getNotice(long cno);
	
	//특정 게시물 수정 삭제 화면 도출 + 수정 후 조회 페이지 호출(조회수x)
	public NoticeVO getNotice2(long cno);
	
	//특정 게시물 수정(UPDATE)
	public boolean modifyNotice(NoticeVO notice);
	
	//특정 게시물 삭제요청
//	public boolean modifyCdelFlag(long cno);
	
	//특정 게시물 삭제(DELETE)
	public boolean removeNotice(long cno);
	
	//첨부파일 목록 조회
//	public List<AttachFileVO> getAttachFileList(Long cno);
}