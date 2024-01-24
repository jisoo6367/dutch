package com.spring.dutch.service;

import org.springframework.stereotype.Service;

import com.spring.dutch.dto.HomeDTO;
import com.spring.dutch.mapper.HomeMapper;

@Service
public class HomeServiceImpl implements HomeService{
	private HomeMapper homeMapper;
	
	public HomeServiceImpl(HomeMapper homeMapper) {
		this.homeMapper = homeMapper;
	}
	
	@Override
	public HomeDTO takeLists() {
		
		return new HomeDTO(homeMapper.selectNoti(), homeMapper.selectDutch(),
							homeMapper.selectCommu(), homeMapper.selectCard());
	}
	
}
