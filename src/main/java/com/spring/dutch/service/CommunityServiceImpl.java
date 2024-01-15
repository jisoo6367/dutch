package com.spring.dutch.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dutch.domain.CommunityAttachFileVO;
import com.spring.dutch.domain.CommunityVO;
import com.spring.dutch.dto.CommunityPagingCreatorDTO;
import com.spring.dutch.dto.CommunityPagingDTO;
import com.spring.dutch.mapper.CommunityAttachFileMapper;
import com.spring.dutch.mapper.CommunityMapper;


@Service
public class CommunityServiceImpl implements CommunityService {
	
		private CommunityMapper communityMapper;
		private CommunityAttachFileMapper communityAttachFileMapper;
		
		public CommunityServiceImpl(CommunityMapper communityMapper) {			
			this.communityMapper = communityMapper;
		}
	
	@Override
	public CommunityPagingCreatorDTO showCommunityList(CommunityPagingDTO communityPaging) {

		String beginDate = communityPaging.getBeginDate();
		String endDate = communityPaging.getEndDate() ;
	
		Date _endDate = null ;
		Calendar myCal = null ;
		
		if((beginDate != null && beginDate.length() != 0) 
				&& (endDate != null && endDate.length() != 0)) {
			if(beginDate.equals(endDate)) {
				
				SimpleDateFormat myDateFmt = new SimpleDateFormat("yyyy-MM-dd");
				try {
					_endDate = myDateFmt.parse(endDate);//Parses text from the beginning of the given string to produce a date
					myCal = Calendar.getInstance() ;
					myCal.setTime(_endDate); 			//Sets this Calendar's time with the given Date
					
					myCal.add(Calendar.DAY_OF_MONTH, 1);
					
					endDate = myDateFmt.format(myCal.getTime()) ; //문자열로 변환
					System.out.println("변환 후 endDate: " + endDate);
					
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
				communityPaging.setEndDate(endDate);
			}
			
		}
		
		return new CommunityPagingCreatorDTO(communityMapper.selectRowTotalCommunity(communityPaging), 
											 communityPaging, 
											 communityMapper.selectCommunityList(communityPaging));

		

	}

	@Override
	@Transactional
	public long registerCommunity(CommunityVO community) {
		
		communityMapper.insertCommunity(community) ;
		
		List<CommunityAttachFileVO> attachFileList = community.getAttachFileList() ;
		
		attachFileList.forEach(
				
				attachFile -> {
					attachFile.setTno(community.getTno());
					communityAttachFileMapper.insertAttachFile(attachFile);
				});
							
		return community.getTno() ;
	}

	
	//게시물 조회
	@Override
	public CommunityVO getCommunity1(long tno, String result) {
		CommunityVO community = communityMapper.selectCommunity(tno) ;
		
		if (result == null) {//목록페이지에서 조회요청 시에만
			communityMapper.updateTviewCntCommunity(tno);
		}
		
		System.out.println("community: " + community);
		System.out.println("조회수: " + community.getTviewCnt());
		
		return community ; 
	}

	//게시물 수정 삭제 화면 호출
	@Override
	public CommunityVO getCommunity2(long tno) {
		
		CommunityVO community = communityMapper.selectCommunity2(tno);
		
		return community;
	}

	//게시물 수정
	@Override
	@Transactional
	public boolean modifyCommunity(CommunityVO community) {
		
		long tno = community.getTno();
		

		boolean communityModifyResult = (communityMapper.updateCommunity(community) == 1);
		
		communityAttachFileMapper.deleteAttachFiles(tno); 
		
		List<CommunityAttachFileVO> attachFileList = community.getAttachFileList() ;
		
		if (communityModifyResult && attachFileList != null) {
			for(CommunityAttachFileVO attachFile : attachFileList) {
				attachFile.setTno(tno);
				communityAttachFileMapper.insertAttachFile(attachFile) ;	
			}
			
		}

		return communityModifyResult;
	}

	//게시물삭제
	@Transactional
	@Override
	public boolean removeCommunity(long tno) {
		
		//첨부파일 정보를 저장할 리스트 객체 생성
		List<CommunityAttachFileVO> attachFileList = communityAttachFileMapper.selectAttachFiles(tno) ;
		
		//업로드 파일 정보 삭제				
		int attachFileDeleteRows = communityAttachFileMapper.deleteAttachFiles(tno);
		System.out.println("attachFileDeleteRows: " + attachFileDeleteRows);
		
		//업로드 파일 삭제
		removeAttachFiles(attachFileList);		
		
		int rows = communityMapper.deleteCommunity(tno);
				
		return (rows == 1 );
	}

	
	//게시물삭제: 블라인드 처리	
		@Override
		@Transactional
		public boolean modifyTdelFlag(long tno) {
			
			int rows = communityMapper.updateTdelFlagCommunity(tno);

			return (rows == 1) ;
		}
	
	
	
	//특정 게시물의 첨부파일 목록 조회
	@Override
	public List<CommunityAttachFileVO> getAttachFileList(Long tno) {
	
		return communityAttachFileMapper.selectAttachFiles(tno);
	}

	
	//톰캣 서버의 업로드 파일 삭제 메서드
	private void removeAttachFiles(List<CommunityAttachFileVO> attachFileList) {
		
		if(attachFileList == null || attachFileList.size() == 0) {
			return ;
		}
		
		System.out.println("삭제시작: 삭제파일 목록:======\n" + attachFileList.toString());
		
		
		for(CommunityAttachFileVO attachFile : attachFileList) {
			//하나의 VO에 대한 실행코드를 작성
			Path filePath = Paths.get(attachFile.getRepoPath() ,
								      attachFile.getUploadPath() ,
								      attachFile.getUuid() + "_" + attachFile.getFileName()  );
			
			boolean deleteFileResult = false ;
			
			try {
				deleteFileResult = Files.deleteIfExists(filePath) ;
				
				if(attachFile.getFileType().equals("I")) {
					Path thumbnail = Paths.get(attachFile.getRepoPath() ,
											   attachFile.getUploadPath() ,
											   "s_" + attachFile.getUuid() + "_" + attachFile.getFileName()  );
					
					Files.deleteIfExists(thumbnail) ;
							
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
		
		
		
	}

	
	
}
