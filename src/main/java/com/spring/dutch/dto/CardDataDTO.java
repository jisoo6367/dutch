package com.spring.dutch.dto;

import java.util.List;

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
public class CardDataDTO {
	private String kno;
	private String category;
	private String kname;
	private String kcontent;
	private String kcompany;
	private int kcomment;
	private String uuid ;
	private String uploadPath ;
	private String fileName ;
	private String repoPath = "C:/myupload" ;
}
