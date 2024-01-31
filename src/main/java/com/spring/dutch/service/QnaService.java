package com.spring.dutch.service;

import java.util.List;

import com.spring.dutch.domain.QnaAttachFileVO;
import com.spring.dutch.domain.QnaVO;
import com.spring.dutch.dto.QnaPagingCreatorDTO;
import com.spring.dutch.dto.QnaPagingDTO;

public interface QnaService {

	//QNA 목록조회
//	public List<QnaVO> getQnaList(QnaPagingDTO qnaPaging);
	public QnaPagingCreatorDTO getQnaList(QnaPagingDTO qnaPaging);
	
	//QNA 등록
	public long registerQna(QnaVO qna);
	
	//특정 QNA 조회: 하나의 데이터를 가져옴
	public QnaVO getQna(long qno);
	
	//특정 QNA 수정 삭제 화면 도출 + 수정 후 조회 페이지 호출
	public QnaVO getQna2(long qno);
	
	//특정 QNA 수정
	public boolean modifyQna(QnaVO qna);
	
	//QNA 삭제 요청
	public boolean modifyQdelFlagAdmin(long qno);
	
	//시그널 
	public long getSignal_0(long qno);
	public long getSignal_1(long qno);
	public long getSignal_2(long qno);
	
	//특정 QNA 삭제
	public boolean removeQna(long qno);

	//첨부파일 목록 조회
	public List<QnaAttachFileVO> getQnaAttachFileList(Long qno);

	
		
}
