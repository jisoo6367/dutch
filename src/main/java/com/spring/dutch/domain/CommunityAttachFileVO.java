package com.spring.dutch.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class CommunityAttachFileVO {

	private String uuid ;
	private String uploadPath ;
	private String fileName ;
	private String fileType ;
	private Long tno ;
	private String repoPath = "C:/myupload" ;
	
}
