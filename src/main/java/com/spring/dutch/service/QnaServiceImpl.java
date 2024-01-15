package com.spring.dutch.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dutch.domain.AttachFileVO;
import com.spring.dutch.domain.QnaVO;
import com.spring.dutch.dto.QnaPagingCreatorDTO;
import com.spring.dutch.dto.QnaPagingDTO;
import com.spring.dutch.mapper.AttachFileMapper;
import com.spring.dutch.mapper.QnaMapper;
import com.spring.dutch.domain.AttachFileVO;

@Service
public class QnaServiceImpl implements QnaService{
	
	private QnaMapper qnaMapper;
	private AttachFileMapper attachFileMapper;

	//모든 필드 초기 생성자
	public QnaServiceImpl(QnaMapper qnaMapper, AttachFileMapper attachFileMapper) {
		this.qnaMapper = qnaMapper;
		this.attachFileMapper = attachFileMapper;
	}
	
	//QNA 목록조회
	@Override
	public QnaPagingCreatorDTO getQnaList(QnaPagingDTO qnaPaging) {
		
		return new QnaPagingCreatorDTO(qnaMapper.selectQnaTotal(qnaPaging), 
									   qnaPaging,
									   qnaMapper.selectQnaList(qnaPaging));
	}

	//QNA 등록
	@Override
	@Transactional
	public long registerQna(QnaVO qna) {

		qnaMapper.insertQna(qna);
		
		List<AttachFileVO> attachFileList = qna.getAttachFileList();
		
		if(attachFileList != null && attachFileList.size() > 0) {
			attachFileList.forEach(attachFile -> {
//				attachFile.setQno(qna.getQno());
				attachFile.setNickname(qna.getNickname());
				attachFileMapper.insertAttachFile(attachFile);
				
			});
			
		}
		
		return qna.getQno();
	}

	//QNA 조회: 특정 QNA 하나의 데이터를 가져옴
	@Override
	@Transactional
	public QnaVO getQna(long qno) {

		QnaVO qna = qnaMapper.selectQna(qno);
		
		return qna;
	}

	//특정 QNA 수정 삭제 화면 호출
	@Override
	public QnaVO getQna2(long qno) {

		QnaVO qna = qnaMapper.selectQna2(qno);
		
		return qna;
	}

	//특정 QNA 수정
	@Override
	@Transactional
	public boolean modifyQna(QnaVO qna) {
		
		long qno = qna.getQno();
		String nickname = qna.getNickname();
		
		boolean qnaModifyResult = (qnaMapper.updateQna(qna) == 1);
		
		attachFileMapper.deleteAttachFiles(qno);
		
		List<AttachFileVO> attachFileList = qna.getAttachFileList();
		
		if(qnaModifyResult && attachFileList != null) {
			for(AttachFileVO attachFile : attachFileList) {
				attachFile.setNickname(nickname);
//				attachFile.setQno(qno);
				attachFileMapper.insertAttachFile(attachFile);
			}
		}
		
		return qnaModifyResult;
	}

	//특정 QNA 삭제
	@Override
	@Transactional
	public boolean removeQna(long qno) {
		
		List<AttachFileVO> attachFileList = getQnaAttachFileList(qno);
		
		int attachFileDeleteRows = attachFileMapper.deleteAttachFiles(qno);
		System.out.println("attachFileDeleteRows: " + attachFileDeleteRows);
		
		removeAttachFiles(attachFileList);

		int rows = qnaMapper.deleteQna(qno);
		
		return (rows == 1);
	}

	@Override
	@Transactional
	public boolean modifyQdelFlagAdmin(long qno) {
		
		int rows = qnaMapper.updateQdelFlagAdmin(qno);
		
		return (rows == 1);
	}

	//특정 닉네임으로 가져옴
	@Override
	public List<AttachFileVO> getQnaAttachFileList(Long qno) {
		
		return attachFileMapper.selectAttachFiles(qno);
	}

	//업로드 파일 삭제 메서드
	private void removeAttachFiles(List<AttachFileVO> attachFileList) {

		if(attachFileList == null || attachFileList.size() == 0) {
			return ;
		}
		
		System.out.println("삭제시작: 삭제파일 목록:=====" + attachFileList.toString());
		
		for(AttachFileVO attachFile : attachFileList) {
			//하나의 VO에 대한 실행코드를 작성, forEach 메서드가 반복함
			Path filePath = Paths.get(attachFile.getRepoPath() ,
									  attachFile.getUploadPath() ,
									  attachFile.getUuid() + "_" + attachFile.getFileName() );
			
			boolean deleteFileResult = false ; 
			
			try {
				deleteFileResult = Files.deleteIfExists(filePath);
				
				if(attachFile.getFileType().equals("I")) {
					Path thumnail = Paths.get(attachFile.getRepoPath() ,
											  attachFile.getUploadPath() ,
											  "s_" + attachFile.getUuid() + "_" + attachFile.getFileName() );
					
					deleteFileResult = Files.deleteIfExists(thumnail);	
				}
			
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//try-catch
			
			
			
			}//if-end
		}//for-end
}