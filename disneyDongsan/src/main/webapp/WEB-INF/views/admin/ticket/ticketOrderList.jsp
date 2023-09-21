<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="/resources/include/css/commonList.css">

<style type="text/css">

	.choiceDeleteBtn{
		display: inline-block;
     height: 32px;
     width: 170px;
     font-weight: 600;
     font-size: 15px;
     line-height: 20px;
     margin-left: 10px;
     background-color: #c3daf7;
     float: right;
	}
	
	.choiceDeleteBtn:hover{
     border: 2px solid #c3daf7;
     background-color: white;
   }

</style>

<script type="text/javascript">
	$(function() {

		/* 검색 후 검색 대상과 검색 단어 출력 */
		let word = "<c:out value='${ticketVO.keyword}' />";
		if (word != "") {
			$("#keyword").val("<c:out value='${ticketVO.keyword}' />");
			$("#search").val("<c:out value='${ticketVO.search}' />");
			$("#visitDate").val("<c:out value='${ticketVO.visitDate}' />");
			$("#visitDateEnd")
					.val("<c:out value='${ticketVO.visitDateEnd}' />");
			$("#cancelSearch")
					.val("<c:out value='${ticketVO.cancelSearch}' />");
		}
		/* 티켓 구분 검색 */
		$("#searchData").click(function() {
			if ($("#search").val() == "all") {
				$("#keyword").val("전체티켓");
			} else if ($("#search").val() == "alldayTicket") {
				$("#keyword").val("종일권");
			} else if ($("#search").val() == "afternoonTicket") {
				$("#keyword").val("오후권");
			} else if ($("#search").val() == "packageTicket") {
				$("#keyword").val("2/3/4인권");
			} else if ($("#visitDate").val() != "") {
				$("#keyword").val("${visitDate}");
			} else if ($("#visitDateEnd").val() != "") {
				$("#keyword").val("${visitDateEnd}");
			}

			$("#pageNum").val(1); // 페이지 초기화
			goPage();
		});

		/*체크박스 전체체크와 부분체크*/
		let chkObj = document.getElementsByName("RowCheck");
		let rowCnt = chkObj.length;

		$("input[name='allCheck']").click(function() {
			let chk_listArr = $("input[name='RowCheck']");
			for (let i = 0; i < chk_listArr.length; i++) {
				chk_listArr[i].checked = this.checked;
			}
		});

		$("input[name='RowCheck']").click(function() {
			if ($("input[name='Rowcheck']:checked").length == rowCnt) {
				$("input[name='allCheck']")[0].checked = true;
			} else {
				$("input[name='allCheck']")[0].checked = false;
			}
		});

		// 체크 모두 선택하면 상단 체크
		$("input[name='RowCheck']").click(function() {
			let total = $("input[name='RowCheck']").length;
			let checked = $("input[name='RowCheck']:checked").length;

			if (total != checked)
				$("#allCheck").prop("checked", false);
			else
				$("#allCheck").prop("checked", true);
		});

		$("#cancelFormBtn").unbind("click").bind("click", function() {
			cancel();
		});

		$(".page-item a").click(
				function(e) {
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val(
							$(this).attr("href"));
					goPage();
				});

	});

	/*체크박스*/
	function cancel() {
		let url = "/admin/ticketCancel";
		let ticketArr = new Array();
		let list = $("input[name='RowCheck']");
		hasChecked = false; //체크 여부 변수

		for (let i = 0; i < list.length; i++) { //체크된 갯수 추출
			if (list[i].checked) { // 선택이 되어있으면 배열에 값을 넣는다.
				hasChecked = true; //체크된 값이 있으면 true 설정
				ticketArr.push(list[i].value); //push함수를 이용해 ticketArr에 값을 추가
				console.log("ticketArr:" + ticketArr);
			}
		}
		if (!hasChecked) {
			alert("선택된 글이 없습니다.");
			return;
		}

		console.log("ticketArr:" + ticketArr);
		if (confirm("티켓을 취소하시겠습니까? ")) {
			$.ajax({
				url : url,
				type : 'post',
				traditional : true,//traditional은 배열을 넘겨주는 옵션이다.
				dataType : "text", //가져올 값의 타입을 텍스트로 설정
				data : {
					ticketArr : ticketArr
				//보내려는 데이터 변수 선언
				},
				success : function(resultData) { //통신이 성공정으로 이루어졌을때 실행
					if (resultData == "성공") {
						alert("취소 성공하였습니다.");
						location.reload(); //페이지 새로고침
					} else {
						alert("취소 실패하였습니다.");
						return;
					}
				}
			});
		} else {
			return;
		}
	}

	/* 검색을 위한 실질적인 처리 함수 */
	function goPage() {
		if ($("#search").val() == "all") {
			$("#keyword").val("전체티켓");
		}

		$("#f_search").attr({
			"method" : "get",
			"action" : "/admin/ticketOrderList"
		});
		$("#f_search").submit();
	}
</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<form name="updateForm" id="updateForm">
			<input type="hidden" name="PAYMENT_ID" id="PAYMENT_ID" />
		</form>
		<div class="pagetitle">
			<h1>티켓 예매 목록</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div id="ticketSearch" class="text-right">
								<form id="f_search" name="f_search" class="form-inline">
									<input type="hidden" name="pageNum" id="pageNum"
										value="${pageMaker.cvo.pageNum}"> <input type="hidden"
										name="amount" id="amount" value="${pageMaker.cvo.amount}">
									<div class="form-group">
										<label>티켓 구분</label> <select id="search" name="search" >
											<option value="all">전체 티켓 조회</option>
											<option value="alldayTicket">종일권</option>
											<option value="afternoonTicket">오후권</option>
											<option value="packageTicket">2/3/4인권</option>
										</select> <input type="hidden" name="keyword" id="keyword" />
									

										<label>티켓 상태</label> <select id="cancelSearch" name="cancelSearch">
											<option value="all">전체 티켓 조회</option>
											<option value="cancelTicket">취소티켓조회</option>
											<option value="notcancelTicket">정상티켓조회</option>
										</select>
									

										<label>날짜 선택</label> 
										<input type="date" name="visitDate" id="visitDate" />~ 
										<input type="date" name="visitDateEnd" id="visitDateEnd" />
											
										<button type="button" id="searchData" class="btn search_btn">검색</button>
									</div>
									
								</form>

								
							</div>

							<div class="text-left">
								<%-- <label>게시물 수 :</label><input type="text" id="countTicket" name="countTicket" value="${ticketListCnt}" readonly="readonly" /> --%>
								티켓 수 : ${ticketListCnt}
								<input type="button" id="cancelFormBtn" class="btn choiceDeleteBtn" value="선택한 티켓 예매 취소" />
							</div>

							<div id="ticketOrderList" class="table-height">
								<table summary="결제 리스트" class="table table-hover admin_table">
									<thead>
										<tr>
											<th class="order text-center col-md-1">번호</th>
											<th>결제번호</th>
											<th class="text-center col-md-1">방문예정일</th>
											<th>티켓구분</th>
											<th>대인</th>
											<th>청소년</th>
											<th>소인</th>
											<th>2/3/4인권</th>
											<th>오후권</th>
											<th>제휴카드</th>
											<th>할인 전 금액</th>
											<th>최종금액</th>
											<th>결제날짜</th>
											<th>회원 아이디</th>
											<th>티켓 상태</th>
											<th><input type="checkbox" id="allCheck" name="allCheck" />
											</th>
										</tr>
									</thead>
									<tbody id="list" class="table-striped">
										<!-- 데이터 출력 -->
										<c:choose>
											<c:when test="${not empty ticketOrderList}">
												<c:forEach var="ticket" items="${ticketOrderList}"
													varStatus="status">
													<tr class="text-center" data-num="${ticket.PAYMENT_ID}">
														<%-- <td>${status.count}</td> --%>
														<td><c:out value="${(pageMaker.cvo.pageNum - 1) * pageMaker.cvo.amount + status.index +1}"/></td>
														<td>${ticket.PAYMENT_ID}</td>
														<td>${ticket.visit_date}</td>
														<td class="ticketCategory text-center">${ticket.t_category}</td>
														<td class="text-center">${ticket.t_adult}</td>
														<td class="text-center">${ticket.t_student}</td>
														<td class="text-center">${ticket.t_child}</td>
														<td class="text-center">${ticket.t_multi}</td>
														<td class="text-center">${ticket.t_afternoon}</td>
														<td>${ticket.card_company}</td>
														<td>${ticket.allday_price}</td>
														<td>${ticket.total_price}</td>
														<td>${ticket.pay_date}</td>
														<td>${ticket.t_member_id}</td>
														<%-- <td><input name="RowCheck" type="checkbox" value="${ticket.PAYMENT_ID}"/></td> --%>
														<c:choose>
															<c:when test="${ticket.t_state eq 'Y'}">
																<td>정상</td>
															</c:when>
															<c:when test="${ticket.t_state eq 'N'}">
																<td>취소된 티켓</td>
															</c:when>
														</c:choose>
														<c:choose>
															<c:when test="${ticket.t_state eq 'Y'}">
																<td><input name="RowCheck" type="checkbox"
																	value="${ticket.PAYMENT_ID}" /></td>
															</c:when>
															<c:when test="${ticket.t_state eq 'N'}">
																<td><input type="checkbox" disabled /></td>
															</c:when>
														</c:choose>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="6" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							<%-- =============== 페이징 출력 시작 ============== --%>
							<div class="text-center">
								<ul class="pagination justify-content-center">
									<!-- 이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인 -->
									<c:if test="${pageMaker.prev}">
										<li class="page-item previous"><a class="page-link" 
											href="${pageMaker.startPage - 1}">Previous</a></li>
									</c:if>

									<!-- 바로가기 번호 출력 -->
									<c:forEach var="num" begin="${pageMaker.startPage}"
										end="${pageMaker.endPage}">
										<li class="page-item ${pageMaker.cvo.pageNum == num ? 'active':''}">
											<a class="page-link" href="${num}">${num}</a>
										</li>
									</c:forEach>

									<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인 -->
									<c:if test="${pageMaker.next}">
										<li class="page-item next"><a class="page-link" 
											href="${pageMaker.endPage + 1}">Next</a></li>
									</c:if>
								</ul>
							</div>
							<%-- =============== 페이징 출력 종료 ============== --%>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<%@ include file="/WEB-INF/views/admin-template/footer.jsp"%>

	<script type="text/javascript"
		src="/resources/include/js/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script
		src="/resources/include/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script
		src="/resources/include/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/include/assets/vendor/chart.js/chart.umd.js"></script>
	<script src="/resources/include/assets/vendor/echarts/echarts.min.js"></script>
	<script src="/resources/include/assets/vendor/quill/quill.min.js"></script>
	<script
		src="/resources/include/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="/resources/include/assets/vendor/tinymce/tinymce.min.js"></script>
	<script
		src="/resources/include/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="/resources/include/assets/js/main.js"></script>

</body>
</html>