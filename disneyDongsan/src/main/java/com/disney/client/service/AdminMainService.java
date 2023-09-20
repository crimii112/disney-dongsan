package com.disney.client.service;

import java.util.List;

import com.disney.vo.MainBenerVO;
import com.disney.vo.MainVO;

public interface AdminMainService {
	
	public List<MainVO> mainList(MainVO mvo);
	
	public List<MainBenerVO> benerList(MainBenerVO mbo);
	
	public MainVO mainUpdateForm (MainVO mvo);
	
	public int mainUpdate (MainVO mvo) throws Exception;
	
	public MainBenerVO benerupdateForm (MainBenerVO mbo);
	
	public int benerUpdate (MainBenerVO mbo) throws Exception;
	

}
