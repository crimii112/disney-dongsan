<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style type="text/css">
		.contentContainer{margin-bottom: 60px;}
		.good img{

			width: 50px;
		}
		.good{
			position: relative;
			text-align: right;
		}
		td img{
			width: 400px;
		}
	</style>

   
   <script type="text/javascript">
      //let buttonCheck = 0;   // 수정버튼과 삭제버튼을 구별하기 위한 변수

      $(function(){
    	  	let routeNo = ${detail.routeNo};
        	let idVelue = '${detail.memberId}';
          	let idSessen = '${Member.memberId}';
          	
          	console.log(idSessen);

             if(idSessen != idVelue){
            	 $("#deleteBtn").css("visibility","hidden");
            	 $("#updateFormBtn").css("visibility","hidden");
             }
         //$("#pwdChk").css("visibility","hidden"); // visibility: 화면에 보이지 않으나 공간을 그대로 유지
      
         /* 수정 버튼 클릭 시 처리 이벤트 */
         $("#updateFormBtn").click(function(){
        	 goUrl = "/route/routeUpdateForm";
        	 $("#f_data").attr("action",goUrl);
             $("#f_data").submit();
         });

         /* 삭제 버튼 클릭 시 처리 이벤트 */
         $("#deleteBtn").click(function(){
             $.ajax({
             	url:"/route/routeReplyCnt",
             	type: "post",
             	data: "routeNo="+$("#routeNo").val(),
             	dataType:"text",
             	error:function(){
             		alert('시스템 오류. 관리자에게 문의 하세요');
             	},
             	success:function(resultData){
             		if(resultData==="0"){//댓글이 존재하지 않을 경우
                        if(confirm("정말 삭제하시겠습니까?")){
                       	 actionProcess("post", "/route/routeDelete");
                        }
             		}else{//댓글이 존재 존재하는 경우
             			//alert("댓글 존재시 게시물 작성할 수가 없습니다.\n 댓글 삭제 후 다시 확인해 주세요.");
             			//return;	
             			deleteReply(routeNo);
             		}
            	 }
          	});
         });
        	

         /* 목록 버튼 클릭 시 처리 이벤트 */
         $("#listBtn").click(function(){
            location.href = "/route/routeList";
         });
             
      });   // $ 종료문
      function divBtn() {
    	    $.ajax({
    	        type: 'GET',  // 또는 'POST', 서버로 전송할 HTTP 메서드 선택
    	        url: '/route/routeGoodcntUpdate?routeNo=${detail.routeNo}', // 좋아요 업데이트를 처리하는 서버의 URL
    	        success: function(response) {
    	            alert('좋아요를 눌렀습니다.');
    	            location.href = "/route/routeDetail?routeNo=${detail.routeNo}";
    	        },
    	        error: function() {
    	            alert('좋아요 업데이트에 실패했습니다.');
    	        }
    	    });
    	}

      

      function actionProcess(method, goUrl){
    	  method==="get"? $("#routeImage").remove():"";
    	  $("#f_data").attr({
    		  "method":method,
    		  "action":goUrl
    	  });
    	  $("#f_data").submit();
      }
      function deleteReply(routeNo){
    	    if (confirm("정말 삭제하시겠습니까?")) {
    	        $.ajax({
    	            url: "/route/replies/all/" + routeNo,
    	            type: "delete",
    	            headers: {
    	                "X-HTTP-Method-Override": "DELETE"
    	            },
    	            dataType: "text",
    	            error: function () {
    	                alert("시스템 오류. 관리자에게 문의 하세요");
    	            },
    	            success: function (result) {
    	                if (result === "SUCCESS") {
    	                    alert("게시물 삭제가 완료되었습니다.");
    	                    actionProcess("post", "/route/routeDelete");
    	                    listAll(routeNo);
    	                }
    	            }
    	        });
    	    }
    	};
      

      
   </script>
   
   </head>
   <body>
      <div class="contentContainer container">
      <!-- <div class="contentTit page-header"><h3 class="text-center">게시판 상세보기</h3></div> -->
      
      <form name="f_data" id="f_data" method="get">
         <input type="hidden" name="routeNo" value="${detail.routeNo}" />
         <input type="hidden" name="routeImage" id="routeImage" value="${detail.routeImage}" />
      </form>
	      <%-- =============== 삭제 및 수정 버튼 추가 시작 =============== --%>
	      <div id="boardPwdBut" class="row test-center">
	         <div class="btnArea col-md-12 text-right">
	         	<input type="hidden" name="routeNo" id="routeNo" value="${detail.routeNo}" />
	            <input type="button" value="글수정" id="updateFormBtn" class="btn btn-success" />
	            <input type="button" value="글삭제" id="deleteBtn" class="btn btn-success" />
	            <%--<input type="button" value="글쓰기" id="insertFormBtn" class="btn btn-success" />--%>
	            <input type="button" value="목록" id="listBtn" class="btn btn-success" />
	         </div>
	      </div>
	      <%-- =============== 삭제 및 수정 버튼 추가 종료 =============== --%>
	      
	      <%-- =============== 상세 정보 보여주기 시작 =============== --%>
	      <div class="contentTB text-center">
	         <table class="table table-bordered">
	            <tbody>
	               <tr>
	                  <td class="col-md-2">작성자</td>
	                  <td class="col-md-2 text-left" id="id">${detail.memberId}</td>
	                  <td class="col-md-2">작성일</td>
	                  <td class="col-md-2 text-left">${detail.routeDate}</td>
	                  <td>(조회수: ${detail.routeHits})</td>
	               </tr>
	               <tr>
	                  <td class="col-md-2">글제목</td>
	                  <td colspan="4" class="col-md-8 text-left">${detail.routeTitle}</td>
	               </tr>
	               <tr class="table-tr-height">
	                  <td class="col-md-2">글내용</td>
	                  <td colspan="4" class="col-md-8 text-center">${detail.routeContent}</td>
	               </tr>
	               <c:if test="${not empty detail.routeImage}">
		               <tr>
		                  <td class="col-md-2">이미지</td>
		                  <td colspan="4" class="col-md-8 text-left">
		                  	<img alt="이미지 파일" src="/uploadStorage/route/${detail.routeImage}" />
		                  </td>
		               </tr>
	               </c:if>
	            </tbody>
	         </table>
	      </div>
	    <div class="good" onclick='divBtn()'>
      		<img alt="/" src="/resources/image/good.PNG" /><span id="goodBtn"  style="font-size: 20px">${detail.routeGood}</span>
      	</div>
      	<%--===================상세 정보 보여주기 종료 ==================== --%>
      	<jsp:include page="routeReply.jsp" />
      </div>
   </body>
</html>