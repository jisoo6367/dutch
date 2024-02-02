package com.spring.dutch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.dutch.domain.CommunityVO;
import com.spring.dutch.dto.CommunityPagingDTO;

public interface CommunityMapper {

	//게시물 목록조회(READ)
	public List<CommunityVO> selectCommunityList(CommunityPagingDTO communityPaging);
	 
	//게시물 총 수 조회(READ)
	public long selectRowTotalCommunity(CommunityPagingDTO communityPaging);	

	//새 게시물 등록(CREATE)
	public int insertCommunity(CommunityVO communityVO) ;
	
	//특정 게시물 조회(detail.jsp, JOIN-SELECT): 특정 게시물 하나의 데이터를 가져옴
	public CommunityVO selectCommunity(long tno) ;
	
	//특정 게시물 조회(modify:jsp, 단순-SELECT): 특정 게시물 하나의 데이터를 가져옴
	public CommunityVO selectCommunity2(long tno) ;
	
	//특정 게시물 수정(UPDATE)
	public Integer updateCommunity(CommunityVO communityVO) ;
	
	//특정 게시물 삭제(DELETE)
	public int deleteCommunity(long tno) ;
	
	//특정 게시물 삭제요청(UPDATE)
	public int updateTdelFlagCommunity(long tno) ;
	
	//게시물 조회수 증가(+1씩 증가)
	public int updateTviewCntCommunity(long tno) ;
	

	//게시물의 댓글 개수 수정: 
    //댓글추가 시에 #{amount}에 1, 댓글삭제 시 #{amount}에 -1 이 각각 전달됨
	public void updateTreplyCntCommunity(@Param("tno") Long tno, @Param("amount") int amount) ;
	
	//댓글 5개
	public List<CommunityVO> selectRecentCommunityList(@Param("count") int count);
	
	//신고된 게시물 목록조회(READ)
	   public List<CommunityVO> reportedCommunityList(CommunityPagingDTO communityPaging);
	       
	//신고된 게시물 총 수 조회(READ)
	public long reportedRowTotalCommunity(CommunityPagingDTO communityPaging);
	
	//게시물 신고 (UPDATE)
		public Integer updateTreport(long pno);
	
}
