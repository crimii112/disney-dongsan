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
		<![endif]--><link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/mypageListBody.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<style>
 
  
  .file {
    width: 100px;
  }
  
.custom-btn {
  width: 150px;
  height: 40px;
  padding: 10px 25px;
  border: 2px solid #000;
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background: transparent;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  display: inline-block;
}
.btn-15 {
   background: #000;
  color: #fff;
  z-index: 1;
}
.btn-15:after {
  position: absolute;
  content: "";
  width: 0;
  height: 100%;
  top: 0;
  right: 0;
  z-index: -1;
   background: #e0e5ec;
  transition: all 0.5s ease;
}
.btn-15:hover {
  color: #000;
}
.btn-15:hover:after {
  left: 0;
  width: 100%;
}
.btn-15:active {
  top: 2px;
}
</style>
		
		<script type="text/javascript">
			
			$(function(){
				/* 리뷰가 작성된 상품에 처리할 이벤트(후기 작성을 안한것 = 수정,삭제 안보이고 후기작성 버튼만 보임, 
												후기 작성한것 = 수정,삭제 버튼만 보이고 후기 작성버튼 안보임)  */
				/*$("tr").each(function () {
			        var content_check = $(this).find(".check_hidden").text();
			        console.log("content_check=" + content_check);
			        

			        if (content_check === "작성완료") {
			            $(this).find(".reviewUpdate, .reviewDelete").css("display", "inline-block");
			            $(this).find(".reviewInsert").css("display", "none");
			            $(this).find(".check_hidden").css("display", "inline-block");
			        } else {
			            $(this).find(".reviewUpdate, .reviewDelete").css("display", "none");
			            $(this).find(".check_hidden").css("display", "none");
			        }
			    });*/
				
				
				
				/*등록버튼 클릭시 처리 이벤트*/
				$(".reviewInsert").click(function(){
					let g_order_detail_id = $(this).parent("td").parent("tr").attr("data-num");
					$("#g_order_detail_id").val(g_order_detail_id);
					
					let member_id = $(this).parent("td").parent("tr").children().eq(6).text();
					$("#member_id").val(member_id);
					
					let g_name = $(this).parent("td").parent("tr").children().eq(2).text();
					$("#g_name").val(g_name);
					
					let imageSrc = $(this).closest("tr").find(".file").attr("src");
					console.log("imageSrc=" + imageSrc);
					$("#g_image").val(imageSrc);
					
					$("#resultForm").attr({
						"method" : "post",
						"action" : "/mypage/userReviewForm"
					});
					$("#resultForm").submit();
				});
				
			    $("#completeReview").click(function(){
			    	location.href="/mypage/ReviewCompleteList";
				
			});
		});
		
		</script>
	</head>
	<body>
		<div class="container">
			
		<div class="wrap">
			<button type ="button" class="custom-btn ">리뷰 작성</button>
			<button  type ="button" class="custom-btn btn-15" id="completeReview">작성한 리뷰</button>
		</div>
			<form name="resultForm" id="resultForm">
				<input type="hidden" name="detail_num" id="detail_num"/>
				<input type="hidden" name="g_order_detail_id" id="g_order_detail_id"/>
				<input type="hidden" name="member_id" id="member_id"/>
				<input type="hidden" name="g_name" id="g_name"/>
				<input type="hidden" name="g_image" id="g_image"/>
				<input type="hidden" name="re_image" id="re_image"/>
			</form>
    			
			<div id="reviewList">
				<table summary="게시판 리스트" class = "table table-hover">
					<thead>
						<tr>
							<th class="col-md-1 text-center">No</th>
							<th class="col-md-5 text-center" colspan="2">상품정보</th>
							<th class="col-md-2 text-center">구매날짜</th>
							<th class="col-md-2 text-center">주문상태</th>
							<th class="col-md-2 text-center">후기작성</th>
							<th class="col-md-1 text-center" style= display:none></th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
					<!-- 데이터 출력 -->
						<c:choose>
						
							<c:when test="${not empty goodsReviewList}">
								<c:forEach var="ReviewList" items="${goodsReviewList}" varStatus="status">
								
									<tr class="text-center" data-num="${ReviewList.g_order_detail_id}">
										<td><c:out value="${(pageMaker.cvo.pageNum - 1) * pageMaker.cvo.amount + status.index +1}"/></td>
										<td>
											<c:if test="${not empty ReviewList.g_image}">
												<img src="/dongsanStorage/goods/${ReviewList.g_image}"class="file"/>
											</c:if> 
										</td>
										<td>${ReviewList.g_name}</td>
										<td>${ReviewList.g_order_date}</td>
										<td>${ReviewList.g_order_state}</td>
										<td>
											<button id="reviewInsert" class="reviewInsert">후기작성</button>
											<span class="check_hidden">${ReviewList.content_check}</span><br/>
										</td>
										<td style= display:none>${ReviewList.member_id}</td>
										<td style= display:none>${ReviewList.re_image}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="7" class="text-center">구매확정이 완료된 상품이 없습니다.</td>
							</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
			</div>
		</div>
	
	</body>
</html>