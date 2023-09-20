<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>문의 등록</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>

		<script type="text/javascript">
			$(function(){
				
				/*저장 버튼 클릭 시 처리 이벤트*/
				$("#qaInsertBtn").click(function(){
					//입력값 체크
					if(!chkData("#title","제목을")) return;
					else if(!chkData("#qa_content","문의할 내용을")) return;
					else {
						// enctype 속성의 기본 값은 "application/x-www-form-urlcencoded".POST방식 폼 전송에 기본 값으로 사용
						$("#f_writeForm").attr({
							"method":"post",
							"action":"/mypage/userQAInsert"
						});
						$("#f_writeForm").submit();
					}
				});
				
				/*목록 버튼 클릭 시 처리 이벤트*/
				$("#qaListBtn").click(function(){
					location.href="/mypage/userQAList";
				});
			});
				</script>
	</head>
	<body>
		<div class="container">
			<!--<div class="text-center"><h3>게시판 입력화면</h3></div>-->
			<form class="form-horizontal" id="f_writeForm">
				
				<div class="form-group">
				<label for="title" class="col-sm-2 control-label">제목</label>
					<div class="col-sm-10">
					<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요." />
					</div>
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<div class="col-sm-10">
					
					<textarea class="form-control" id="qa_content" name="qa_content" rows="8" placeholder="문의할 사항을 입력하세요." ></textarea>
					</div>
				</div>
			</form>
			<div class="text-right">
				<button type="button" class="btn btn-primary" id="qaInsertBtn">등록</button>
				<button type="button" class="btn btn-primary" id="qaListBtn">돌아가기</button>
			</div>
		</div>
	
	</body>
</html>