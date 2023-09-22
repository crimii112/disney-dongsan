<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page trimDirectiveWhitespaces="true"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link rel="stylesheet" href="/resources/include/css/header.css">

<script src="/resources/include/jquery/jquery-3.7.1.min.js"></script>
<script src="/resources/include/jquery/jquery.test.js"></script>
</head>
<body>
	<header>
	   <div id="container">
	      <div class="row">
	         <div class="col"></div>
	         <div class="col-8 text-center">
	            <a href="/"><img src="/resources/img/disneyLogo2.png" height="80px"></a>
	         </div>
	         <div class="col">
	            <a class="nav-icon-user" href="#"><img src="/resources/img/user.png" height="20px"></a> 
	               <a class="nav-icon" href="#"><img src="/resources/img/basket.png" height="20px"></a> 
	               <a class="nav-icon-logout" href="#"><img src="/resources/img/logout.png" height="20px"></a>
	         </div>
	      </div>
	      
	   </div>
	   <div class="header">
	      <div class="topMenu">
	         <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0 menu01">
	            <li><span>&nbsp;</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>티켓예매</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/ticket/allDayTicketView" class="nav-link px-2">예매하기</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">제휴카드</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>굿즈몰</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/goods/goodsList" class="nav-link px-2">굿즈판매</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>               
	            <li><span>시설안내</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/route/routeList" class="nav-link px-2">추천동선</a></li>
	                  <li class="nop"><a href="/facilityInfo/rideList" class="nav-link px-2">어트랙션</a></li>
	                  <li class="nop"><a href="/facilityInfo/restaurantList" class="nav-link px-2">레스토랑</a></li>
	               </ul></li>
	            <li><span>이벤트</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="#" class="nav-link px-2">이벤트</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>이용정보</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/facilityInfo/waytocome" class="nav-link px-2">오시는길</a></li>
	                  <li class="nop"><a href="/facilityInfo/operatingHours" class="nav-link px-2">이용시간</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>고객센터</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/mypage/userQAList" class="nav-link px-2">1:1문의</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">공지사항</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>&nbsp;</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	         </ul>
	      </div>
	   </div>
	</header>
	
	
<%-- 	<div>
		<div class="right">
			<div class="login_div">
				<c:if test="${empty Member}">
					<a href="/member/loginForm" class="login_div_a" id="login">로그인</a>
					<a href="/member/signupTos" class="login_div_a" id="signup">회원가입</a> 
				</c:if>
				<c:if test="${not empty Member}">
					<a href="/member/logout" class="login_div_a" id="logout">로그아웃</a> 
				</c:if>
				
				<a href="/mypage/mypage" class="login_div_a" id="mypage">마이페이지</a>
				<a href="/goods/basketList" class="login_div_a" id="basket">장바구니</a>
			</div>
		</div>
		<div class="logo_background">
			<div class="logo">
				<a href="/" title="홈으로"><img id="logoImg"
					src="/resources/include/img/disney_dongsan.png" /></a>
			</div>
		</div>
		<div class="dropdown-bar">
			<div class="dropdowun_body">
	
				<div class="dropdowun_main">
					<ul class="list">
						<li class="item"><a href="/ticket/allDayTicketView" class="link">예매</a>
							<div class="dropdown_div">
								<ul class="dropdown-content">
									<li><a href="/ticket/allDayTicketView">예매하기</a></li>
									<li><a href="#">제휴카드</a></li>
								</ul>
							</div></li>
						<li class="item"><a href="#" class="link">즐길거리</a>
							<div class="dropdown_div">
								<ul class="dropdown-content">
									<li><a href="/route/routeList">추천동선</a></li>
									<li><a href="/facilityInfo/rideList">어트랙션</a></li>
									<li><a href="/facilityInfo/restaurantList">레스토랑</a></li>
								</ul>
							</div></li>
						<li class="item"><a href="#" class="link">굿즈몰</a>
							<div class="dropdown_div">
								<ul class="dropdown-content">
									<li><a href="/goods/goodsList">굿즈판매</a></li>
								</ul>
							</div></li>
						<li class="item"><a href="#" class="link">이벤트</a>
							<div class="dropdown_div">
								<ul class="dropdown-content">
									<li><a href="#">이벤트</a></li>
								</ul>
							</div></li>
						<li class="item"><a href="#" class="link">이용정보</a>
							<div class="dropdown_div">
								<ul class="dropdown-content">
									<li><a href="/facilityInfo/waytocome">오시는 길</a></li>
									<li><a href="/facilityInfo/operatingHours">이용시간</a></li>
								</ul>
							</div></li>
						<li class="item"><a href="#" class="link">고객센터</a>
							<div class="dropdown_div">
								<ul class="dropdown-content">
									<li><a href="/mypage/userQAList">1:1문의</a></li>
									<li><a href="#">FAQ</a></li>
								</ul>
							</div></li>
					</ul>
				</div>
	
			</div>
		</div>
	</div> --%>
</body>
</html>
