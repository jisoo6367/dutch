package com.spring.dutch.domain;

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
public class AttachFileVO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private String fileType;
	private String nickname;//플젝용
//	private long qno;//개인용
	
	private String repoPath = "C:/myupload";
}
