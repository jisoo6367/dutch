package com.spring.dutch.domain;

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
public class CardVO {
	private long kno;
	private String categoty;
	private String kname;
	private String kcontent;
	private String kcompany;
	private String kcomment;
}
