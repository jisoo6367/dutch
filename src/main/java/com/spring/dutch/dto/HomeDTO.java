package com.spring.dutch.dto;

import java.util.List;

import com.spring.dutch.domain.CardVO;
import com.spring.dutch.domain.CommunityVO;
import com.spring.dutch.domain.DutchBoardVO;
import com.spring.dutch.domain.NoticeVO;

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
public class HomeDTO {
	private List<NoticeVO> notiList;
	private List<DutchBoardVO> dutchList;
	private List<CommunityVO> commuList;
	private List<CardVO> cardList;
}
