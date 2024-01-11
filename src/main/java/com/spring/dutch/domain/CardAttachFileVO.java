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
public class CardAttachFileVO {
	private String uuid ;
	private String uploadPath ;
	private String fileName ;
	private String kno ;
	private String repoPath = "C:/myupload" ;
}
