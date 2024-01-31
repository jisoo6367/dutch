package com.spring.dutch.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dutch.domain.QnaAttachFileVO;
import com.spring.dutch.domain.QnaVO;
import com.spring.dutch.dto.QnaPagingCreatorDTO;
import com.spring.dutch.dto.QnaPagingDTO;
import com.spring.dutch.mapper.QnaAttachFileMapper;
import com.spring.dutch.mapper.QnaMapper;

@Service
public class QnaServiceImpl implements QnaService{
	
	private QnaMapper qnaMapper;
	private QnaAttachFileMapper qnaAttachFileMapper;

	//모든 필드 초기 생성자
	public QnaServiceImpl(QnaMapper qnaMapper, QnaAttachFileMapper qnaAttachFileMapper) {
		this.qnaMapper = qnaMapper;
		this.qnaAttachFileMapper = qnaAttachFileMapper;
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
		
		List<QnaAttachFileVO> qnaAttachFileList = qna.getQnaAttachFileList();
		
		if(qnaAttachFileList != null && qnaAttachFileList.size() > 0) {
			qnaAttachFileList.forEach(
					qnaAttachFile -> {
						qnaAttachFile.setQno(qna.getQno());
				qnaAttachFileMapper.insertAttachFile(qnaAttachFile);
				
			});
			
		}
		
		return qna.getQno();
	}

	//QNA 조회: 특정 QNA 하나의 데이터를 가져옴
	@Override
	@Transactional
	public QnaVO getQna(long qno) {

		QnaVO qna = qnaMapper.selectQna(qno);
		
		qna.setQnaAttachFileList(qnaAttachFileMapper.selectAttachFiles(qno));
		
		System.out.println("qna: " + qna);
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
		
		boolean qnaModifyResult = (qnaMapper.updateQna(qna) == 1);
		
		qnaAttachFileMapper.deleteAttachFiles(qno);
		
		List<QnaAttachFileVO> qnaAttachFileList = qna.getQnaAttachFileList();
		
		if(qnaModifyResult && qnaAttachFileList != null) {
			for(QnaAttachFileVO qnaAttachFile : qnaAttachFileList) {
				qnaAttachFile.setQno(qno);
				qnaAttachFileMapper.insertAttachFile(qnaAttachFile);
			}
		}
		
		return qnaModifyResult;
	}

	//특정 QNA 삭제
	@Override
	@Transactional
	public boolean removeQna(long qno) {
		
		List<QnaAttachFileVO> qnaAttachFileList = getQnaAttachFileList(qno);
		
		int attachFileDeleteRows = qnaAttachFileMapper.deleteAttachFiles(qno);
		System.out.println("attachFileDeleteRows: " + attachFileDeleteRows);
		
		removeAttachFiles(qnaAttachFileList);

		int rows = qnaMapper.deleteQna(qno);
		
		return (rows == 1);
	}

	//블라인드처리
	@Override
	@Transactional
	public boolean modifyQdelFlagAdmin(long qno) {
		
		int rows = qnaMapper.updateQdelFlagAdmin(qno);
		
		return (rows == 1);
	}
	
	//시그널보냄(0/1/2)
	@Override
	public long getSignal_0(long qno) {
		
		long getSignal_0 = qnaMapper.updateQsignal_0(qno);
		System.out.println("시그널 0으로 업데이트=====" + getSignal_0);
		
		return getSignal_0;
	}

	@Override
	public long getSignal_1(long qno) {
		
		long getSignal_1 = qnaMapper.updateQsignal_1(qno);
		System.out.println("시그널 1으로 업데이트=====" + getSignal_1);
		
		return getSignal_1;
	}

	@Override
	public long getSignal_2(long qno) {
		
		long getSignal_2 = qnaMapper.updateQsignal_2(qno);
		System.out.println("시그널 2으로 업데이트=====" + getSignal_2);
		
		return getSignal_2;
	}
	

	//특정 게시글로 가져옴
	@Override
	public List<QnaAttachFileVO> getQnaAttachFileList(Long qno) {
		
		return qnaAttachFileMapper.selectAttachFiles(qno);
	}

	//업로드 파일 삭제 메서드
	private void removeAttachFiles(List<QnaAttachFileVO> qnaAttachFileList) {

		if(qnaAttachFileList == null || qnaAttachFileList.size() == 0) {
			return ;
		}
		
		System.out.println("삭제시작: 삭제파일 목록:=====" + qnaAttachFileList.toString());
		
		for(QnaAttachFileVO qnaAttachFile : qnaAttachFileList) {
			//하나의 VO에 대한 실행코드를 작성, forEach 메서드가 반복함
			Path filePath = Paths.get(qnaAttachFile.getRepoPath() ,
									  qnaAttachFile.getUploadPath() ,
									  qnaAttachFile.getUuid() + "_" + qnaAttachFile.getFileName() );
			
			boolean deleteFileResult = false ; 
			
			try {
				deleteFileResult = Files.deleteIfExists(filePath);
				
				if(qnaAttachFile.getFileType().equals("I")) {
					Path thumnail = Paths.get(qnaAttachFile.getRepoPath() ,
											  qnaAttachFile.getUploadPath() ,
											  "s_" + qnaAttachFile.getUuid() + "_" + qnaAttachFile.getFileName() );
					
					deleteFileResult = Files.deleteIfExists(thumnail);	
				}
			
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//try-catch
			
			
			
			}//if-end
		}//for-end

}