package com.spring.dutch.dto;

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
public class CardAttachFileDTO {
	
	private String fileName ;  //원본파일이름
	private String uploadPath ; //yyyy/MM/dd 형식 경로 문자열
	private String uuid ;       //파일 이름에 추가된 UUID.toString() 값.
	private String repoPath = "C:/myupload" ;
	
	
	

}
