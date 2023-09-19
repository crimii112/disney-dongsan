<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
    <!-- CKEditor 스크립트 URL 수정 -->
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
		<script type="text/javascript">
		$(function(){
			//저장 버튼 클릭 시 처리 이벤트
			$("#insertBtn").click(function() {
				if(!chkData("#routeTitle", "제목을")) return;
				else if (fn_valiChk()) return;
				else{
 					if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
						//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
						if(!chkFile($("#file"))) return;//이미지 파일만 업로드 가능.
					} 
					// enctype 속성의 기본 값은 "application/x-www-form-urlcencoded". POST방식 폼 전송에 기본 값으로 사용
					$("#f_writeForm").attr({
						"method":"post",
						"enctype":"multipart/form-data",
						"action":"/route/routeInsert"
					});
					$("#f_writeForm").submit();
				}
			});
			//취소 버튼 클릭 시 처리 이벤트
			$("#cancelBtn").click(function(){
				$("#f_writeForm").each(function(){
					this.reset();
				});
				CKEDITOR.instances.routeContent.setData("");
			});
			
			//목록 버튼 클릭 시 처리 이벤트
			$("#listBtn").click(function(){
				location.href="/route/routeList";
			});
			
		});
		
        function fn_valiChk() {
            var routeContent = CKEDITOR.instances.routeContent.getData(); 

             if (routeContent == null || routeContent.trim() === '') {
                 alert("내용을 입력하세요."); 
                 CKEDITOR.instances.routeContent.focus();
                 return true;
             }
             
             return false;
         }

	
		</script>
	</head>
	<body>
		<div class="container">
			<div class="text-center">
				<form class="form-horizontal" id="f_writeForm" name="f_writeForm">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr>
								<td>작성자</td>
								<td class="text-left" id="memberId" name="memberId">${Member.memberId}
								<!--  <input type="text" class="form-control" id="memberId" name="memberId" value="${routeVO.memberId}" maxlength="10" />--></td>
							</tr>
							<tr>
								<td>글제목</td>
								<td class="text-left"><input type="text" class="form-control" id="routeTitle" name="routeTitle"
									placeholder="글 제목 입력" maxlength="33" /></td>
							</tr>
							<tr>
								<td>글내용</td>
								<td class="text-left">
									<textarea name="routeContent" id="routeContent"></textarea>
									<script>
		                                CKEDITOR.replace("routeContent", {
		                                    resize_enabled: false,
		                                    enterMode: CKEDITOR.ENTER_BR,
		                                    shiftEnterMode: CKEDITOR.ENTER_P,
		                                    filebrowserUploadUrl: "/route/ckeditorUpload"
		                                });
		                            </script>
								</td>
							</tr>
							<!--<tr>
								<td>비밀번호</td>
								<td class="text-left"><input type="password"
									class="form-control" id="routePasswd" name="routePasswd" placeholder="비밀번호 입력" maxlength="20" /></td>
							</tr>-->
 							<tr>
								<td>파일 업로드</td>
								<td class="text-left"><input type="file" name="file" id="file" /></td>
							</tr>
						</tbody>
					</table>
					<div class="text-right">
						<button type="button" id="insertBtn" class="btn btn-success">글쓰기</button>
						<button type="button" id="cancelBtn" class="btn btn-success">취소</button>
						<button type="button" id="listBtn" class="btn btn-success">목록</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>