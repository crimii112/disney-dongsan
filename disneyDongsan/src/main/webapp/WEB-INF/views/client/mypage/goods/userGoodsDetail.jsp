<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>Insert title here</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
			<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<style>
		.file{
			width : 100px;
		}
		</style>
		<script type="text/javascript">
	
			
		
		function goodsList(){
			location.href="/mypage/userGoodsList";
		}
			
		
		</script>
	</head>
	<body>
		<div class="container">
			
		
			<form name="detailForm" id="detailForm">
				<input type="hidden" name="g_order_detail_id" id="g_order_detail_id"/>
			</form>
			
			<div id="tketList" >
				
				<table summary="게시판 리스트" class = "table">
					<thead>
						
						
						<tr>
							<th class="col-md-2 text-center">상품 이미지</th>
							<th class="col-md-1 text-center">상품명</th>
							<th class="col-md-1 text-center">수량</th>
							<th class="col-md-1 text-center">가격</th>
							<th class="col-md-1 text-center">주문날짜</th>
							<th class="col-md-2 text-center">배송지</th>
							<th class="col-md-2 text-center">주문상태</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
					<!-- 데이터 출력 -->
						
						<c:choose>
							<c:when test="${not empty detail}">
								<c:forEach var="detail" items="${detail}" varStatus="status">
									<tr class="text-center" data-num="${detail.g_order_id}">
										<td>
										<c:if test="${not empty detail.g_image}">
											<img src="/dongsanStorage/goods/${detail.g_image}"class="file"/>
										</c:if>
										</td>
										<td class="goDetail">${detail.g_name}</td>
										<td>${detail.g_count}개</td>
										<td>
											<fmt:formatNumber type="number" value="${detail.g_price}" pattern="#,##0" />원
										</td>
										<td>${detail.g_order_date}</td>
										<td>${detail.member_addr}</td>
										<td>${detail.g_order_state}</td>
									</tr>
									
								</c:forEach>
								 <c:set var="firstDetail" value="${detail[0]}" />
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="5" class="text-center">결제된 상품이 존재하지 않습니다.</td>
							</tr>
							</c:otherwise>
						</c:choose>
						
					</tbody>
				</table>
				<div class="text-right">
					<input type="button" value="목록" onclick="goodsList();"/>
				</div>
				<ul>
					<li><label>총합 가격:&nbsp;</label>
					<span class="item_price"></span></li>
					<li><label>주문 날짜: &nbsp;</label>${firstDetail.g_order_date}</li>
					<li><label>배송지:&nbsp;</label>${firstDetail.member_addr}</li>
					<li><label>주문상태:&nbsp;</label>${firstDetail.g_order_state}</li>
				</ul>
			</div>
		</div>
	
	</body>
</html>