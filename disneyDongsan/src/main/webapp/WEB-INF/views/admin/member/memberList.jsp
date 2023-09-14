<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/login.css">
</head>
<body>
	<div id="memberListContainer">
		<h3>회원 리스트 관리</h3>
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
								<td class="text-center">(${member.memberAddr1}) ${member.memberAddr2}&nbsp; ${member.memberAddr3}</td>
								<td class="text-center">${member.memberRegdate}</td>
								<td class="text-center">${member.memberState}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5" class="tac text-center">등록된 회원 정보가 존재하지 않습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</body>
</html>