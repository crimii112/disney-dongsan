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
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(function(){
			
			let tState = "${detail.t_state}";
			/*목록 버튼 클릭 시 처리 이벤트*/
			$('#tkListBtn').click(function(){
				location.href="/mypage/userTicketList"
			});
				
					$("#tkDeleteBtn").click(function(){
						tiketCancel = confirm("티켓을 취소하시겠습니까?");
						if(tiketCancel === true){
							if(tState === '취소완료'){
								alert("이미 취소가 완료된 티켓입니다.");
							}else{
								alert("취소가 완료되었습니다.");
								$("#tk_data").attr({
									"method":"post",
									"action":"/mypage/userTicketDelete"
								});
								$("#tk_data").submit();
							}
						}else{return;}
					});
		
		});
		</script>
	</head>
	<body>
	<body>
	<div class="contentContainer container">
		<form name="tk_data" id="tk_data" method="post">
			<input type="hidden" name="PAYMENT_ID" value="${detail.PAYMENT_ID}">
		</form>
		<button type="button" id="tkDeleteBtn">취소</button>
		<button type="button" id="tkListBtn">목록</button>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-1">주문번호</td>
						<td class="col-md-3 text-left">${detail.PAYMENT_ID}</td>
					</tr>
					<tr>
						<td class="col-md-1">구분</td>
						<td colspan="3" class="col-md-8 text-left">${detail.t_category}</td>
					</tr>
					<tr>
						<td class="table-tr-height">금액</td>
						<td colspan="1" class="col-md-8 text-left">${detail.total_price}</td>
					</tr>
					<tr id="answer">
						<td class="table-tr-height">방문 예정일</td>
						<td colspan="1" class="col-md-8 text-left">${detail.visit_date}</td>
					</tr>
					<tr id="t_state">
						<td class="table-tr-height">티켓 상태</td>
						<c:choose>
							<c:when test="${detail.t_state eq 'Y'}">
								<td>결제완료</td>
							</c:when>
							<c:when test="${detail.t_state eq 'N'}">
								<td>취소완료</td>
							</c:when>
						</c:choose>
					</tr>

				</tbody>
			</table>
		</div>
	</div>
</body>
	
	</body>
</html>