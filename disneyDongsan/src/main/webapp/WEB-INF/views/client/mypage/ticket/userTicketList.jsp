<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<script type="text/javascript">
			$(function(){
				$(".goDetail").click(function(){
					let PAYMENT_ID = $(this).parents("tr").attr("data-num");
					$("#PAYMENT_ID").val(PAYMENT_ID);
					console.log("예매 번호:" + PAYMENT_ID);
					
					$("#detailForm").attr({
						"method" : "get",
						"action" : "/mypage/userTicketDetail"
					});
					$("#detailForm").submit();
				})
			});
		</script>
	</head>
	<body>
		<div class="container">
			
		
			<form name="detailForm" id="detailForm">
				<input type="hidden" name="PAYMENT_ID" id="PAYMENT_ID"/>
			</form>
			
			<div id="tketList">
				<table summary="게시판 리스트" class = "table">
					<thead>
						<tr>
							<th class="col-md-1 text-center">No</th>
							<th class="col-md-1 text-center">주문번호</th>
							<th class="col-md-5 text-center">구분</th>
							<th class="col-md-1 text-center">금액</th>
							<th class="col-md-1 text-center">방문예정일</th>
							<th class="col-md-1 text-center">결제날짜</th>
							<th class="col-md-1 text-center">결제상태</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
					<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty tketList}">
								<c:forEach var="tketList" items="${tketList}" varStatus="status">
									<tr class="text-center" data-num="${tketList.PAYMENT_ID}">
										<td><c:out value="${(pageMaker.cvo.pageNum - 1) * pageMaker.cvo.amount + status.index +1}"/></td>
										<td>${tketList.PAYMENT_ID}</td>
										<td class="goDetail">${tketList.t_category}</td>
										<td>${tketList.total_price}</td>
										<td>${tketList.visit_date}</td>
										<td>${tketList.pay_date}</td>
										<c:choose>
											<c:when test="${tketList.t_state eq 'Y'}">
												<td>결제완료</td>
											</c:when>
											<c:when test="${tketList.t_state eq 'N'}">
												<td>취소완료</td>
											</c:when>
										</c:choose>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="5" class="text-center">등록된 게시물이 존재하지 않습니다.</td>
							</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	
	</body>
</html>