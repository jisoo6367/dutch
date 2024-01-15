package com.spring.dutch.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dutch.domain.AttachFileVO;
import com.spring.dutch.domain.NoticeVO;
import com.spring.dutch.dto.NoticePagingCreatorDTO;
import com.spring.dutch.dto.NoticePagingDTO;
import com.spring.dutch.mapper.AttachFileMapper;
import com.spring.dutch.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService{

	private NoticeMapper noticeMapper;
	private AttachFileMapper attachFileMapper;
	
	//모든 필드 초기 생성자
	public NoticeServiceImpl(NoticeMapper noticeMapper,
							 AttachFileMapper attachFileMapper) {
		this.noticeMapper = noticeMapper;
		this.attachFileMapper = attachFileMapper;
//		System.out.println("NoticeServiceImpl 초기 생성자 입니다.");
	}

//	//방법1:Setter 이용
//	public NoticeServiceImpl() {
//		System.out.println("NoticeServiceImpl의 기본생성자입니다.");
//	}
//	
//	@Autowired
//	public void setMyBoardMapper(NoticeMapper noticeMapper) {
//		this.noticeMapper = noticeMapper;
//		System.out.println("NoticeServiceImpl의 NoticeMapper의 Setter입니다.");	
//	}
	
	
	//공지사항 목록 조회
	@Override
	public NoticePagingCreatorDTO getNoticeList(NoticePagingDTO noticePaging) {
		
//		long rowTotal = noticeMapper.selectNoticeTotal(noticePaging);
//		
//		List<NoticeVO> noticeList = noticeMapper.selectNoticeList(noticePaging);
//		
//		NoticePagingCreatorDTO pagingCreator =
//				new NoticePagingCreatorDTO(rowTotal, noticePaging, noticeList);
		
//		return noticeList;
		return new NoticePagingCreatorDTO(noticeMapper.selectNoticeTotal(noticePaging), 
										  noticePaging, 
										  noticeMapper.selectNoticeList(noticePaging));
	}

	//공지사항 등록
	@Override
	@Transactional
	public long registerNotice(NoticeVO notice) {

//		System.out.println("컨트롤러 ->서비스로 전달된 myBoard: " + notice);
//		//컨트롤러 ->서비스로 전달된 myBoard: MyBoardVO(bno=0, btitle=서비스 새글 입력  테스트 제목, ....)
//		
//		long rows = noticeMapper.insertNotice(notice) ; 
//		System.out.println("rows: " + rows); //1
//		
//		System.out.println("DB 처리 후 notice: " + notice);
//		//DB 처리 후myBoard: MyBoardVO(bno=41, btitle=서비스 새글 입력  테스트 제목, ....)
//		
//		return (rows == 1) ? notice.getCno() : 0;
		
		noticeMapper.insertNotice(notice);
		
		return notice.getCno();
	}

	//공지사항 조회: 특정 공지사항 하나의 데이터를 가져옴
	@Override
	@Transactional
	public NoticeVO getNotice(long cno) {
		
		int rows = noticeMapper.updateCviewCnt(cno);

		NoticeVO notice = noticeMapper.selectNotice(cno);
		System.out.println("notice: " + notice);
		System.out.println("조회수: " + notice.getCviewCnt());
		
//		if(result == null) {
//			noticeMapper.updateCviewCnt(cno);
//		}
		
//		return notice;
		return (rows == 1 ) ? notice : null ;
	}

	//특정 공지사항 수정 삭제 화면 호출
	@Override
	public NoticeVO getNotice2(long cno) {

		NoticeVO notice = noticeMapper.selectNotice2(cno);
		System.out.println("notice: " + notice);

		return notice;
	}

	//특정 공지사항 수정
	@Override
	@Transactional
	public boolean modifyNotice(NoticeVO notice) {

//		long cno = notice.getCno();
//		
//		boolean noticeModifyResult = (noticeMapper.updateNotice(notice) == 1);
//		
//		return noticeModifyResult;
		
		int rows = noticeMapper.updateNotice(notice);
		
		return rows == 1;
	}

	//특정 공지사항 삭제
	@Override
	@Transactional
	public boolean removeNotice(long cno) {

		int rows = noticeMapper.deleteNotice(cno);
		
		return (rows == 1);
	}

	//블라인드 처리
//	@Override
//	@Transactional
//	public boolean modifyCdelFlag(long cno) {
//
//		int rows = noticeMapper.updateCdelFlag(cno);
//		
//		return (rows == 1);
//	}


	
	
}