package com.spring.dutch.dto;


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
public class AdminDTO {
	
	private String reg_date;
	private long register_cnt;

	private long p_cnt;
	private long t_cnt;
	
}
