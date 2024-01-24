package com.spring.dutch.domain;

import java.sql.Timestamp;
import java.util.Date;

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
public class DutchReplyVO {
	
	private long rno ;
	private String nickname;
	private long pno;
	private String rcontent;
	private int rdelFlag;
	private Date rregDate;
	private Timestamp pregDate;
	private long rcno;
	
	private int lvl ;  //오라클 계층쿼리의 level 값을 저장할 필드

}
