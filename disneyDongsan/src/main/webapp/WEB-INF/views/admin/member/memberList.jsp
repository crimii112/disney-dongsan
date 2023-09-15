<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/login.css">
<script>
	$(function(){
		/* 페이지 버튼 클릭 시 이벤트*/
        $(".paginate_button a").click(function(e){
       	e.preventDefault();
       	$("#m_search").find("input[name='pageNum']").val($(this).attr("href"));
        	goPage();
        });
	});
	
	/* 검색을 위한 실질적인 처리 함수 */
    function goPage(){
       $("#m_search").attr({
          "method":"get",
          "action":"/admin/member/memberList"
       });
       $("#m_search").submit();
    }
</script>
</head>
<body>
	<div id="memberListContainer">
		<h3>회원 리스트 관리</h3>
		<div>
			<form id="m_search" name="m_search">
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
		    	<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}">
			</form>
		</div>
		<div id="memberList">
			<table class="table">
				<thead>
					<tr>
						<th class="text-center">번호</th>
						<th class="text-center">아이디</th>
						<th class="text-center">이름</th>
						<th class="text-center">전화번호</th>
						<th class="text-center">이메일</th>
						<th class="text-center">주소</th>
						<th class="text-center">가입일</th>
						<th class="text-center">탈퇴</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty memberList}">
							<c:forEach var="member" items="${memberList}" varStatus="status">
								<tr class="text-center" data-num="${status.count}">
									<td class="text-center">${status.count}</td>
									<td class="text-center">${member.memberId}</td>
									<td class="text-center">${member.memberName}</td>
									<td class="text-center">${member.memberPhone}</td>
									<td class="text-center">${member.memberEmail}</td>
									<td class="text-center">(${member.memberAddr1})
										${member.memberAddr2}&nbsp; ${member.memberAddr3}</td>
									<td class="text-center">${member.memberRegdate}</td>
									<td class="text-center">${member.memberState}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5" class="tac text-center">등록된 회원 정보가 존재하지
									않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>


		<%-- ===================== 페이징 출력 시작 ===================== --%>
		<div class="text-center">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage - 1}">Previous</a></li>
				</c:if>

				<!-- 바로가기 번호 출력 -->
				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li
						class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active' : ''}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인 -->
				<c:if test="${pageMaker.next}">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage + 1}">Next</a></li>
				</c:if>
			</ul>
		</div>
		<%-- ===================== 페이징 출력 종료 ===================== --%>
	</div>
</body>
</html>