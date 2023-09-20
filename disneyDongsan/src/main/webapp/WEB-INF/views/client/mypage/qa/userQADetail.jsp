<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>문의 상세정보</title>
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
			let ask = $("#ask").val();
			console.log(ask);
			$("#answer").css("visibility","hidden");
			
			if( ask != ""){
			$("#answer").css("visibility","visible");
			}
			/*목록 버튼 클릭 시 처리 이벤트*/
			$('#qaListBtn').click(function(){
				location.href="/mypage/userQAList"
			});
			
		
			
			$("#qaDeleteBtn").click(function(){
				if(confirm("삭제하시겠습니까?") === true){
				$("#f_data").attr({
					"method":"post",
					"action":"/mypage/qaDelete"
				});
				$("#f_data").submit();
				}
			});
			
			
		});
		</script>
	</head>
	<body>
	<div class="contentContainer container">
	<form name="f_data" id="f_data" method="post">
	<input type="hidden" name="qa_no" value="${detail.qa_no}">
	</form>
	<form>
		<input type="hidden" name="ask" id="ask" value="${detail.ask}">
	</form>
		<button type="button" id="qaDeleteBtn">삭제</button>
		<button type="button" id="qaListBtn">목록</button>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-1">아이디</td>
						<td class="col-md-3 text-left">${detail.member_id}</td>
					</tr>
					<tr>
						<td class="col-md-1">제목</td>
						<td colspan="3" class="col-md-8 text-left">${detail.title}</td>
					</tr>
					<tr>
						<td class="table-tr-height">내용</td>
						<td colspan="1" class="col-md-8 text-left">${detail.qa_content}</td>
					</tr>
					<tr id="answer">
						<td class="table-tr-height">답변 내용</td>
						<td colspan="1" class="col-md-8 text-left">${detail.ask}</td>
					</tr>

				</tbody>
			</table>
		</div>
	</div>
</body>
</html>