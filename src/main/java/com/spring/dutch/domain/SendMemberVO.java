package com.spring.dutch.domain;

import java.sql.Timestamp;
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
public class SendMemberVO {
	
	private String mno;
	private String nickname;
	private String bank;
	private long bankAccount;
	private String username;
	private String email;
	private String password;
	private String cellphone1;
	private String cellphone2;
	private String cellphone3;
	private Timestamp regDate;
	private Timestamp modDate;
	private int delFlag;
	private String loginType;
	private String gender;
	private String age;
	private boolean enabled;
	private List<AuthorityVO> authorityList;
	private boolean accountNonExpired;

}
