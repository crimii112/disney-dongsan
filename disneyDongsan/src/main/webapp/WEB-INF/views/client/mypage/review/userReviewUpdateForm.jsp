<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>Insert title here</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(function(){
			$("#reviewUpdatetBtn").click(function(){
				
				if(!chkData("#re_content","작성할 내용을")) return;
				if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
					//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
					if(!chkFile($("#file"))) {
						return;//이미지 파일만 업로드 가능.
					}
					updateChk = confirm("수정하시겠습니까?")
					if(updateChk == true){
						alert("수정이 완료되었습니다.");
						$("#updateForm").attr({
							"method" : "post",
							"enctype":"multipart/form-data",
							"action" : "/mypage/userReviewUpdate"
						});
						$("#updateForm").submit();
					}else{
						return;
					}
				}
					
			});
		});
	</script>
	</head>
	<body>
		<ul>
    		<li>작성하신 후기는 디즈니동산 이용자에게 공개됩니다. 댓글은 디즈니동산에서 확인하지 않습니다.</li>
    	</ul>
		<div class="contentTB text-center">
    	<p>g_order_detail_id 값: ${UpdateResultData.detail_num}</p>
			<table class="table table-bordered">
				<tr class="text-tr-height">
					<td>상품 정보</td>
					<td colspan="4" ><img src="${UpdateResultData.g_image}"/><br/>${UpdateResultData.g_name}</td>
				</tr>
				<tr class="text-tr-height">
					<td>현재 사진</td>
					<td colspan="4" class="text-left">
						<c:if test="${not empty UpdateResultData.re_image}">
							<img src="/dongsanStorage/goods/${UpdateResultData.re_image}"/>
						</c:if>
						<c:if test="${empty UpdateResultData.re_image}">
							<img src="/dongsanStorage/goods/no_img.png"/>
						</c:if>
					<td>
				</tr>
			</table>
				<form name="updateForm" id="updateForm">
					<input type="hidden" name="detail_num" id="detail_num" value="${UpdateResultData.detail_num}"/>
					<input type="hidden" name="re_image" id="re_image" value="${UpdateResultData.re_image}"/>
					<table class="table table-bordered">
						<tr class="text-tr-height">
							<td>내용</td>
							<td colspan="3" class="text-left">
								<textarea name="re_content" id="re_content" class="form-control" rows="8">${UpdateResultData.re_content}</textarea>
							</td>
						</tr>
						<tr class="text-tr-height">
							<td>사진 첨부하기</td>
							<td colspan="3" class="text-left">
								<input type="file" class="form-control" id="file" name="file" />
							</td>
						</tr>
					</table>
				</form>	
			
		
	</div>


	<div class="contentBtn text-right">
		<button type="button" id="reviewUpdatetBtn" class="btn btn-success">수정하기</button>
		<button type="button" id="reviewResetBtn" class="btn btn-success">다시쓰기</button>
		<button type="button" id="reviewListBtn" class="btn btn-success">후기목록</button>
	</div>
	</body>
</html>