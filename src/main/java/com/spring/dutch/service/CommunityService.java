package com.spring.dutch.service;
  
import java.util.List;

import com.spring.dutch.domain.CommunityAttachFileVO;
import com.spring.dutch.domain.CommunityVO;
import com.spring.dutch.dto.CommunityPagingCreatorDTO;
import com.spring.dutch.dto.CommunityPagingDTO;
  
  public interface CommunityService {
  
  //게시물 목록조회(READ) 
  public CommunityPagingCreatorDTO showCommunityList(CommunityPagingDTO communityPaging);
 
  //새 게시물 등록(CREATE): 
  public long registerCommunity(CommunityVO Community) ;
  
  //특정 게시물 조회: 특정 게시물 하나의 데이터를 가져옴(조회수1증가 고려) 
  public CommunityVO getCommunity1(long tno, String result) ;
  
  //특정 게시물 수정 삭제 화면 호출 & 수정 후 조회 페이지 호출(조회수 증가 없음) 
  public CommunityVO getCommunity2(long tno) ;
  
  //특정 게시물 수정(UPDATE) 
  public boolean modifyCommunity(CommunityVO Comunity) ;
  
  //특정 게시물 삭제(DELETE) 
  public boolean removeCommunity(long tno) ;
  
  //특정 게시물 삭제요청(UPDATE) 
  public boolean modifyTdelFlag(long tno) ;
  
  //특정 게시물의 첨부파일 목록 조회
  public List<CommunityAttachFileVO> getAttachFileList(Long tno) ;//String nickname
  
  //최근 게시물 5개 보여주기 메서드
  List<CommunityVO> getRecentCommunityList(int count);
  
  }
 