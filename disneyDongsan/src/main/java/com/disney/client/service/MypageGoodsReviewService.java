package com.disney.client.service;

import java.util.List;

import com.disney.vo.GoodsReviewVO;



public interface MypageGoodsReviewService {
	
	
	public List<GoodsReviewVO> myGoodsReviewList(String username);
	
	public int reviewInsert(GoodsReviewVO gvo) throws Exception;
	
	public GoodsReviewVO userReviewUpdateForm(GoodsReviewVO gvo);
	
	public int userReviewUpdate(GoodsReviewVO gvo) throws Exception;
	
	public int userReviewDelete(GoodsReviewVO gvo) throws Exception;
	
	
	public List<GoodsReviewVO> goodsReviewList(GoodsReviewVO gvo);

}
