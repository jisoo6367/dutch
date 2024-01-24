package com.spring.dutch.dto;

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
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DutchAndPartiListDTO {
	private DutchBoardVO dutchboard;
	private List<ParticipantsVO> partiList;
}
