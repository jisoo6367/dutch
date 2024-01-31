package com.spring.dutch.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.dutch.domain.DutchAttachFileVO;
import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.ParticipantsVO;
import com.spring.dutch.dto.DutchAndPartiListDTO;
import com.spring.dutch.dto.DutchBoardPagingCreatorDTO;
import com.spring.dutch.dto.DutchBoardPagingDTO;
import com.spring.dutch.dto.DutchModifyDTO;
import com.spring.dutch.dto.DutchRegisterDTO;
import com.spring.dutch.mapper.DutchAttachFileMapper;
import com.spring.dutch.mapper.DutchBoardMapper;

@Service
public class DutchBoardServiceImpl implements DutchBoardService{

	private DutchBoardMapper dutchBoardMapper ;
	private DutchAttachFileMapper dutchAttachfileMapper;

	public DutchBoardServiceImpl(DutchBoardMapper dutchBoardMapper,
								DutchAttachFileMapper dutchAttachfileMapper) {	
		this.dutchBoardMapper = dutchBoardMapper;
		this.dutchAttachfileMapper = dutchAttachfileMapper;
	}

	// 더치페이 목록 조회
	@Override
	public DutchBoardPagingCreatorDTO getDutchList(DutchBoardPagingDTO dutchPaging) {

		return new DutchBoardPagingCreatorDTO(dutchBoardMapper.selectDutchRowTotal(dutchPaging), 
				                              dutchPaging, 
				                              dutchBoardMapper.selectDutchBoardList(dutchPaging));
	}

	// 더치페이 등록 
	@Override
	public long registerDutchBoard(DutchRegisterDTO dutchRegister) {
		System.out.println("서비스 VO 구성 전" + dutchRegister);
		
		DutchBoardVO insertVO = new DutchBoardVO();
		
		insertVO.setPtitle(dutchRegister.getPtitle());

		insertVO.setCategory(dutchRegister.getCategory());

		insertVO.setNickname(dutchRegister.getNickname());

		insertVO.setPcontent(dutchRegister.getPcontent());

		insertVO.setPpersonal(dutchRegister.getPpersonal());

		insertVO.setPtotalPayment(dutchRegister.getPtotalPayment());

		
		System.out.println("서비스 VO 구성 후");
		dutchBoardMapper.insertDutchBoard(insertVO);
		System.out.println("서비스 VO를 insertDutchBoard에 넣어서 보냄");
				
		DutchBoardVO boardVO = dutchBoardMapper.selectForParticipants(insertVO);
		System.out.println("서비스 VO를 selectForParticipants에 넣어서 보냄");
		
		List<ParticipantsVO> participants = dutchRegister.getParticipants();
		System.out.println("participants: " + participants);
		participants.forEach(item -> {
			
			item.setPno(boardVO.getPno());
			item.setPtitle(boardVO.getPtitle());
			item.setPregDate(boardVO.getPregDate());
			item.setPpersonal(boardVO.getPpersonal());
			item.setPcalculated(boardVO.getPcalculated());
		});
		
		System.out.println("participants: " + participants);
		dutchBoardMapper.insertParticipants(participants);
		System.out.println("participants를 insertParticipants에 넣어서 보냄");
		
		/* 파일경로 디비에 업로드 */
		List<DutchAttachFileVO> fileList = dutchRegister.getAttachFileList();
		
		if(fileList != null && fileList.size() > 0) {
			fileList.forEach(attachFile -> {
				attachFile.setPno(boardVO.getPno());
				dutchAttachfileMapper.insertAttachFile(attachFile);
			});
		}
		
		return boardVO.getPno();
	}

	// 더치페이 특정 게시물 조회 : 특정 게시물 하나의 데이터를 가져옴
	@Override
	   public DutchAndPartiListDTO getDutchBoard(long pno) {

	      DutchBoardVO dutchboard = dutchBoardMapper.selectDutchBoard(pno);
	      
	      List<ParticipantsVO> partiList = dutchBoardMapper.selectParticipants(pno);
	      
	      DutchAndPartiListDTO dto = new DutchAndPartiListDTO(dutchboard, partiList);
	      System.out.println("=============도대체 dto는: " + dto);
	      return dto;
	   }

	// 게시물 수정
	public boolean modifyDutchBoard(DutchModifyDTO dutchModify, DutchBoardVO boardVO, long pno) {
		
		// 기존 참여자 삭제하기전 행 갯수 가져오기
		List<ParticipantsVO> beforeParti = dutchBoardMapper.selectParticipants(pno);	
		
		// participants 테이블에서 기존 참여자 정보 삭제
		int deleteResult = dutchBoardMapper.deleteParticipants(pno);

		// dutch 테이블에 게시글 업데이트
		int updateResult = dutchBoardMapper.updateDutchBoard(boardVO);;
		
		// participants 테이블에 넣을 정보 dutch 테이블에서 뽑아오기
		DutchBoardVO dutchBoard = dutchBoardMapper.selectForParticipantsByPno(boardVO);
		
		// participants 테이블에서 수정한 참가자에게 insert
		List<ParticipantsVO> participants = dutchModify.getParticipants();

		participants.forEach(item -> {
			
			item.setPno(dutchBoard.getPno());
			item.setPtitle(dutchBoard.getPtitle());
			item.setPregDate(dutchBoard.getPregDate());
			item.setPpersonal(dutchBoard.getPpersonal());
			item.setPcalculated(dutchBoard.getPcalculated());
		});
		
		//참가자VO에 넣은 새정보를 DB에 저장
		int insertResult = dutchBoardMapper.insertParticipants(dutchModify.getParticipants());

		return ((deleteResult == beforeParti.size()) && (updateResult == 1) && (insertResult == participants.size())) ? true : false;
	}

	// 게시물 삭제
	public boolean deleteDutchBoard(long pno) {
		
		boolean deleteResult = (dutchBoardMapper.deleteDutchBoard(pno) == 1);
		
		return deleteResult;
	}
	
	// 정산 완료 처리 
	public boolean updatePcalculated (long pno) {
		
		boolean resultOfDutch = (dutchBoardMapper.updatePcalDutch(pno) == 1);
		
		int resultOfParti = dutchBoardMapper.updatePcalParti(pno);
		
		// 업데이트 전 기존 참여자 행 갯수 가져오기
		List<ParticipantsVO> beforeParti = dutchBoardMapper.selectParticipants(pno);
		
		
		return resultOfDutch && (resultOfParti == beforeParti.size()) ? true : false ;
	}

	
	//게시물 신고 (UPDATE)
	public boolean updatePreport(long pno) {
		
		boolean reportResult = (dutchBoardMapper.updatePreport(pno) == 1);
		
		return reportResult;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	//특정 게시물의 첨부파일 목록 조회
	@Override
	public List<DutchAttachFileVO> getAttachFileList(Long pno) {
		return dutchAttachfileMapper.selectAttachFiles(pno) ;
	}

	
	//톰캣 서버의 업로드 파일 삭제 메서드
	public void removeAttachFiles(List<DutchAttachFileVO> attachFileList) {
		
		if(attachFileList == null || attachFileList.size() == 0) {
			return ;
		}
		
		System.out.println("삭제시작: 삭제파일 목록:======\n" + attachFileList.toString());
		
//		attachFileList.forEach(
//				
//				attachFile -> {
//					//하나의 VO에 대한 실행코드를 작성, forEach 메서드가 반복함
//				}
//		);
		
		for(DutchAttachFileVO attachFile : attachFileList) {
			//하나의 VO에 대한 실행코드를 작성
			Path filePath = Paths.get(attachFile.getRepoPath() ,
								      attachFile.getUploadPath() ,
								      attachFile.getUuid() + "_" + attachFile.getFileName()  );
			
			boolean deleteFileResult = false ;
			
			try {
				deleteFileResult = Files.deleteIfExists(filePath) ;
				

					Path thumbnail = Paths.get(attachFile.getRepoPath() ,
											   attachFile.getUploadPath() ,
											   "s_" + attachFile.getUuid() + "_" + attachFile.getFileName()  );
					
					Files.deleteIfExists(thumbnail) ;

				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}