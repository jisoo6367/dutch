package com.spring.dutch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.dutch.domain.QnaVO;
import com.spring.dutch.dto.BoardPagingDTO;

public interface QnaMapper {

	//목록조회(READ)
	public List<QnaVO> selectQnaList(BoardPagingDTO boardPaging);

	//게시물총수(READ)
	public long selectQnaTotal(BoardPagingDTO boardPaging);

	//특정게시물조회
	public QnaVO selectQna(Long qno);

	//등록(CREATE)
	public int insertQna(QnaVO qna);

	//수정(UPDATE)
	public int updateQna(QnaVO qna);

	//삭제요청(UPDATE)
	public int updateQdelFlagAdmin(Long qno);

	//삭제(DELETE)
	public int deleteQna(Long qno);

	//시그널(UPDATE)
	public int updateQsignal(Long qno);

	//게시물의 댓글 개수 수정
	public void updateQreplyCnt(@Param("qno") Long qno,
								@Param("amount") int amount);
}