<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>

	
	<style>
		#item-template{display:none;}
	</style>
	<script type="text/javascript">
		$(function(){
			/* 기본 덧글 목록 불러오기 */
			let g_id = ${detail.g_id};
			listAll(g_id);
		});
		
		function listAll(g_id){
			$(".reply").detach();
			let url = "/goods/all/"+g_id;
			
			$.getJSON(url, function(data){
				$(data).each(function(index){
					
					let re_id = this.re_id;
					let r_member_id = this.r_member_id;
					let re_content = this.re_content;
					let re_date = this.re_date;
					let re_image = this.re_image;
					re_content = re_content.replace(/(\r\n|\r|\n)/g, "<br />");
					
					template(re_id, r_member_id, re_content, re_date, re_image);
				});
			}).fail(function(jqXHR, textStatus, errorThrown){
				console.error("덧글 목록 불러오기 실패: " + textStatus, errorThrown);
				alert("댓글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
			});
		}
		
		function template(re_id, r_member_id, re_content, re_date, re_image){
			let $div = $('#reviewList');
			
			let $element = $('#item-template').clone().removeAttr('id');
			$element.attr("data-num", re_id);
			$element.addClass("reply");
			$element.find('.panel-heading > .panel-title > .name').html(" / " + r_member_id);
			$element.find('.panel-heading > .panel-title > .date').html(" / " + re_date);
			$element.find('.panel-heading > .panel-title > .image').html(" / " + re_image);
			$element.find('.panel-body').html(re_content);
			
			$div.append($element);
		}
	</script>
	</head>
	<body>
	
		<%-- 리스트 영역 --%>
		<div id="reviewList">
			<div id="item-template" class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<span class="name"></span>
						<span class="date"></span>
						<span class="image"></span>
					</h3>
				</div>
				<div class="panel-body"></div>
			</div>	
		</div>
		
	</body>
</html>