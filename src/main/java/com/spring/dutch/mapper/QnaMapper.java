package com.spring.dutch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.dutch.domain.QnaVO;
import com.spring.dutch.dto.QnaPagingDTO;

public interface QnaMapper {

	//목록조회(READ)
	public List<QnaVO> selectQnaList(QnaPagingDTO qnaPaging);
	
	//게시물총수(READ)
	public long selectQnaTotal(QnaPagingDTO qnaPaging);
	
	//특정게시물조회: 하나의 데이터만 가져옴1
	public QnaVO selectQna(long qno);
	
	//특정게시물조회2
	public QnaVO selectQna2(long qno);
	
	//등록(CREATE)
	public int insertQna(QnaVO qna);
	
	//수정(UPDATE)
	public int updateQna(QnaVO qna);
	
	//삭제요청(UPDATE)
	public int updateQdelFlagAdmin(Long qno);
	
	//삭제(DELETE)
	public int deleteQna(long qno);
	
	//시그널(UPDATE)
	public int updateQsignal(long qno);
	
	//게시물의 댓글 개수 수정
	public void updateQreplyCnt(@Param("qno") Long qno,
								@Param("amount") int amount);
}
