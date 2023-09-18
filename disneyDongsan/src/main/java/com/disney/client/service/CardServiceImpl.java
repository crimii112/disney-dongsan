package com.disney.client.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.CardDAO;
import com.disney.vo.CardVO;

import lombok.Setter;

@Service
public class CardServiceImpl implements CardService {

	@Setter(onMethod_ = @Autowired)
	private CardDAO cardDAO;
	
	@Override
	public int getCardDiscount(CardVO cvo) {
		int discountRate = 0;
		discountRate = cardDAO.getCardDiscount(cvo);
		return discountRate;
	}

}
