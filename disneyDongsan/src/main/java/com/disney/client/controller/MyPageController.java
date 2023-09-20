package com.disney.client.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.client.service.MypageGoodsReviewService;
import com.disney.client.service.MypageGoodsService;
import com.disney.client.service.MypageTicketService;
import com.disney.client.service.MypageUpdateService;
import com.disney.vo.GoodsReviewVO;
import com.disney.vo.GoodsVO;
import com.disney.vo.MemberVO;
import com.disney.vo.TicketVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage/*")
@Slf4j
public class MyPageController {

	@Setter(onMethod_ = @Autowired)
	private MypageUpdateService mypagePwChangeService;
	
	@Setter(onMethod_ = @Autowired)
	private MypageTicketService mypageTicketService;
	
	@Setter(onMethod_ = @Autowired)
	private MypageGoodsService mypageGoodsService;
	
	@Setter(onMethod_ = @Autowired)
	private MypageGoodsReviewService mypageGoodsReviewService;
	
	
	@GetMapping("/mypage")
	public String mypage() {
		return "client/mypage/myPage";
	}
	
	/* 비밀번호 변경 화면*/
	@GetMapping("/changPasswordForm")
    public String changPasswordForm(Model model) {
        return "client/mypage/updateinfo/userPwdChangeForm";
    }
	
	/* 비밀번호 변경 처리*/
	@PostMapping("/userPwChange" )
	public String changPassword(@ModelAttribute MemberVO mvo, RedirectAttributes ras) {
		log.info("changPassword 메소드 호출 성공");
		log.info("mvo=" + mvo);
		int result = 0;
		String url ="";
		
		result = mypagePwChangeService.changePw(mvo);
		
		if (result == 1) {
			log.info("성공");
			ras.addFlashAttribute("errorMsg", "비밀번호가 변경되었습니다. 재로그인해주세요.");
			url="/member/loginForm";
		}else {
			log.info("실패");
			ras.addFlashAttribute("errorMsg", "시스템 오류입니다. 관리자에게 문의하세요.");
			url="/mypage/changPasswordForm";
		}
		
		return "redirect:" + url;
	}
	/**************************비밀번호 변경 끝********************************/
	
	/**************************비밀번호 체크 시작********************************/
	
	/*개인정보 수정전 비밀번호 체크 화면*/
	@GetMapping("/pwdChkForm")
    public String pwdChkForm(Model model) {
        return"client/mypage/updateinfo/pwdChkForm";
    }
	
	/**************************비밀번호 체크 끝********************************/
	
	

	
	/*비밀번호 체크 (공용 사용)*/
	@ResponseBody
	@PostMapping(value = "/pwdChk", produces = "text/plain; charset=UTF-8")
	public String pwdChk(MemberVO mvo) {
		log.info("pwdChk 메서드 호출 성공");
		String value = "";
		log.info("mvo=" + mvo);
		int result = mypagePwChangeService.pwdChk(mvo);
		
		if(result == 1) {
			value ="성공";
		}else {
			value="실패";
		}
		log.info("result = " + result);
		return value;
		
	}
	
	
	
	
	
	
	@GetMapping("/userTicketList")
	public String myTiketList(Model model) {
		
		 String username = "user01";
		log.info("myTiketList 메소드 호출 성공");
		List<TicketVO> tketList = mypageTicketService.myTicketList(username);
		model.addAttribute("tketList",tketList);
		
		return"client/mypage/ticket/userTicketList";
	}
	
	@GetMapping("/userTicketDetail")
	public String myTiketDetail(@ModelAttribute TicketVO tvo, Model model ) {
		log.info("userTicketDetail() 메서드 호출 성공");
		TicketVO detail = mypageTicketService.myTicketDetail(tvo);
		log.info("detail=" + detail.toString());
		model.addAttribute("detail", detail);
		return"client/mypage/ticket/userTicketDetail";
	}
	
	@PostMapping("/userTicketDelete")
	public String myTiketDelete(@ModelAttribute TicketVO tvo) {
		log.info("myTiketDelete() 메소드 호출 성공");
		int result = 0;
		String url = "";
		
		result = mypageTicketService.myTicketDelete(tvo);
		
		log.info("result:" + result);
		if(result == 1) {
			url = "/mypage/userTicketList";
		}else {
			url = "/mypage/uerTicketDelete";
		}
		
		return "redirect:" + url;
	}
	
	
	
	
	@GetMapping("/userGoodsList")
	public String userGoodsList(Model model) {
		String username = "user01";
		log.info("userGoodsList메서드 호출 성공");
		List<GoodsVO> goodsList = mypageGoodsService.myGoodsList(username);
		log.info("goodsList = " + goodsList.toString());
		model.addAttribute("goodsList",goodsList);
		return"client/mypage/goods/userGoodsList";
	}
	
	@ResponseBody
	@PostMapping(value = "/deliveryUpdate", produces = "text/plain; charset=UTF-8")
	public String deliveryUpdate(HttpServletRequest request, @ModelAttribute GoodsVO gvo) {
		log.info("deliveryUpdate메서드 호출 성공");
		String value = "";
		String[] goodsArr = request.getParameterValues("goodsArr");
		int valueCnt = goodsArr.length;
		log.info("valueCnt:" + valueCnt);
		gvo.setGoodsArr(goodsArr);
		log.info("gvo:" + gvo.toString());
		int result = mypageGoodsService.stateUpdate(gvo);
		log.info("result:" + result);
		if(result == valueCnt) {
			value = "성공";
			
		}else {
			value = "실패";
		}
		log.info("value="+ value);
		return value;
		
	}
	
	@PostMapping("/userGoodsDetail")
	public String userGoodsDetail(@ModelAttribute GoodsVO gvo, Model model) {
		log.info("userGoodsDetail() 메서드호출 성공");
		log.info("gvodetail =" + gvo);
		List<GoodsVO> detail = mypageGoodsService.userGoodsDetail(gvo);
		model.addAttribute("detail", detail);
		return "client/mypage/goods/userGoodsDetail";
	}
	
	
	
	
	
	
	@GetMapping("/userReviewList")
	public String userReviewList(Model model) {
		String username = "user01";
		log.info("userReviewList메서드 호출 성공");
		List<GoodsReviewVO> goodsReviewList = mypageGoodsReviewService.myGoodsReviewList(username);
		log.info("goodsReviewList = " + goodsReviewList.toString());
		model.addAttribute("goodsReviewList",goodsReviewList);
		return"client/mypage/review/userReviewList";
	}
	
	@PostMapping(value = "/userReviewForm")
	public String userReviewForm() {
		log.info("userReviewForm() 메서드 호출 성공");
		return"client/mypage/review/userReviewForm";
	}
	
	@ResponseBody
	@PostMapping(value = "/userReviewInsert", produces = "text/plain; charset=UTF-8")
	public String userReviewInsert(@RequestParam("file") MultipartFile file, @ModelAttribute GoodsReviewVO gvo) throws Exception {
		log.info("userReviewInsert 메서드 호출 성공");
		String value = "";
		int result = 0;
		
		log.info("gvo = " + gvo);
		result = mypageGoodsReviewService.reviewInsert(gvo);
		log.info("insert_result = " + result);
		if( result == 1) {
			value = "성공";
		}else {
			value = "실패";
		}
		
		return value;
	}
	
	@PostMapping("/userReviewUpdateForm")
	public String userReviewUpdateForm(@ModelAttribute GoodsReviewVO gvo , Model model) {
		log.info("userReviewUpdateForm() 메서드 호출 성공");
		log.info("GoodsReviewVO = " + gvo);
		GoodsReviewVO UpdateResultData = mypageGoodsReviewService.userReviewUpdateForm(gvo);
		log.info("UpdateResultData = " + UpdateResultData);
		model.addAttribute("UpdateResultData",UpdateResultData);
		return"client/mypage/review/userReviewUpdateForm";
	}
	
	
	@PostMapping("/userReviewUpdate")
	public String userReviewUpdate(@ModelAttribute GoodsReviewVO gvo, RedirectAttributes ras)throws Exception  {
		log.info("userReviewUpdate() 메서드 호출 성공");
		log.info("userReviewUpdate = " + gvo);
		int result = 0;
		String url="";
		result= mypageGoodsReviewService.userReviewUpdate(gvo);
		
		if(result == 1) {
			url ="/mypage/userReviewList";
		}else {
			url ="/mypage/userReviewList";
		}
		return "redirect:" + url;
	}
	
	@ResponseBody
	@PostMapping(value = "/userReviewDelete", produces = "text/plain; charset=UTF-8")
	public String userReviewDelete(@ModelAttribute GoodsReviewVO gvo) throws Exception{
		log.info("userReviewDelete() 메서드 호출 성공");
		log.info("userReviewDelete = " + gvo);
		String value = "";
		
		int result= mypageGoodsReviewService.userReviewDelete(gvo);
		
		if(result == 1) {
			value = "성공";
		}else {
			value = "실패";
		}
		
		return value;
		
	}
	
	
}
