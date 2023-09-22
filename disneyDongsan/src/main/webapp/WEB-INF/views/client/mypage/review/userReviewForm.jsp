<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		 <%// URL 매개변수 "g_order_detail_id"의 값을 가져온다. //데이터를 가져오려면 상위에 존재하여야함
        	String gOrderDetailId = request.getParameter("g_order_detail_id");
		 	String member_id = request.getParameter("member_id");
		 	String g_image = request.getParameter("g_image");
		 	String g_name = request.getParameter("g_name");
    	 %>
    	 <script type="text/javascript">
		$(function(){
		    // URL 매개변수 "g_order_detail_id"의 값을 JavaScript 변수에 할당
		    let gOrderDetailId = '<%= gOrderDetailId %>';
		    let member_id = '<%= member_id %>';
		    let g_image = '<%= g_image %>';
		    let g_name = '<%= g_name %>';
		    console.log("gOrderDetailId: " + gOrderDetailId);
		    
		    $("#reviewInsertBtn").click(function(){
		    	let re_Content = $("#re_content").val();
		    	//자바스크립트 단에서 폼 데이터를 다루기 위해 FormData 객체 생성(html form 사용안함)
		        let formData = new FormData(); 
		        formData.append("file", $("#file")[0].files[0]); // FormData 객체에 업로드한 파일을 추가

		        // 보내야할 기타 데이터 formData에 저장
		        formData.append("detail_num", gOrderDetailId);
		        formData.append("re_content", re_Content);
		        formData.append("r_member_id", member_id);
		        
		        // 콘솔로 확인
		        console.log("g_order_detail_id: " + formData.g_order_detail_id);
		        console.log("re_content: " + formData.re_content);
		        console.log("r_member_id: " + formData.r_member_id);
		        console.log("file: " + formData.file);
		        if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
					//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
					if(!chkFile($("#file"))) {
						return;//이미지 파일만 업로드 가능.
					}
		        
		        $.ajax({
		            type: 'post',
		         	//processData는 data속성의 값이 콘텐츠 타입에 맞게 쿼리 문자열로 처리되게 해줌 formdata 사용으로 처리되지 않게 false로 바꿈
		         	//contentType는 ajax를 통해서 서버에 데이터를 보낼 때 데이터 유형을 결정함 formdata 사용으로 처리되지 않게 false로 바꿈
		            processData: false,
		            contentType: false,
		            url: '/mypage/userReviewInsert',
		            data: formData,
		            success: function(resultData) {
		                if (resultData == "성공") {
		                    alert('후기가 작성되었습니다.');
		                    location.replace("/mypage/userReviewList");
		                } else {
		                    alert('후기 작성에 실패했습니다.');
		                    return;
		                }
		            },
		            error: function() {
		                alert('서버와 통신 중 오류가 발생했습니다.');
		            }
		        });
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
    	<p>g_order_detail_id 값: <%= gOrderDetailId %></p>
			<table class="table table-bordered">
				<tr class="text-tr-height">
					<td colspan="2" ><img src="<%=g_image%>"/><br/><%=g_name%></td>
				</tr>
				<tr class="text-tr-height">
					<td>내용</td>
					<td colspan="2" class="text-left">
						<textarea name="re_content" id="re_content" class="form-control" rows="8"></textarea>
					</td>
				</tr>
				<tr class="text-tr-height">
					<td>사진 첨부하기</td>
					<td colspan="2" class="text-left">
						<input type="file" class="form-control" id="file" name="file" />
					</td>
				</tr>
			</table>
	</div>

	<div class="contentBtn text-right">
		<button type="button" id="reviewInsertBtn" class="btn btn-success">등록하기</button>
		<button type="button" id="reviewResetBtn" class="btn btn-success">다시쓰기</button>
		<button type="button" id="reviewListBtn" class="btn btn-success">후기목록</button>
	</div>
	
	</body>
</html>