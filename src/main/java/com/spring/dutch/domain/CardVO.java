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
	private String kno;
	private String category;
	private String kname;
	private String kcontent;
	private String kcompany;
	private int kcomment;
}
