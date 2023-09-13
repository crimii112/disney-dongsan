<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/include/css/login.css">
<script>
	$(function(){
		$("#findIdBtn").click(function(){
			$("#findIdForm").attr({
				"method":"post",
				"action":"/member/findId"
			});
			$("#findIdForm").submit();
		});
	});
</script>
</head>
<body>
	<div id="container">
		<h3 class="text-center">FIND ID</h3>
		<form id="findIdForm">
			<div class="form-group">
				<input type="text" id="memberName" name="memberName"
					placeholder="NAME" class="form-control" />
			</div>
			<div class="form-group">
				<input type="text" id="memberPhone" name="memberPhone"
					placeholder="PHONE" class="form-control" />
			</div>
			<div class="form-group">
				<input type="button" class="form-control button" id="findIdBtn"
					value="찾기" />
			</div>

		</form>
		
	</div>
</body>
</html>