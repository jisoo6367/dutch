package com.spring.dutch.domain;

import java.util.Date;
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
public class ParticipantsVO {
	private long pno;
    private String ptitle;
    private Date pregDate; 
    private long ppersonal;
    private int pcalculated;
    private String nickname;
	
}
