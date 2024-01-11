package com.spring.dutch.dto;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.ParticipantsVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DutchRegisterDTO {
	private String category;
	private String nickname ;             //회원고유번호
	private String ptitle ;        //방제목
	private String pcontent ;      //방삭제(관리자)
	private long ppersonal;        //개인부담금액
	private int ptotalPayment ;
	private List<ParticipantsVO> participants;
}
