<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
		<style type="text/css">
		.div1{
		  width: 1000px;
		  margin: auto;
		}
		.main1{
		  text-align: center;
		  display: block;
		
		}
		.dir{ 
		  display: flex;
		  justify-content: center;
		  margin: auto;
		}
		.dir img{
		  margin: auto;
		  width: 1000px;
		}
		ul {
		  list-style-type: none;
		}
		li{
		  padding: 10px;
		}
		.dir_span{
		  display: inline-block;
		}
		
		.dir_span span {
		  padding: 3px;
		  font-size: 20px;
		  font-weight: 600;
		  color: #F9FFFF;
		  border: 2px solid #5AD2FF;
		  background-color: #B4E5FF;
		  border-radius: 20px;
		} 
		</style>
	</head>
	<body>
		<div class="App">
			<div class="div1">
				<div class='main1'>
					<h1>오시는 길</h1>
				</div>
				<div class='dir'>
					<img src="/resources/images/map10.PNG" alt="BigCo Inc. logo" />
				</div>
				<div class='dir_span'>
					<h3>디즈니 동산(경기도 안산시 상록구 충장로 98)</h3>
					<h4>지하철 이용시</h4>
					<ul>
						<li><span>수인분당선</span> 사리역 1번 출구</li>
					</ul>
					<h4>버스 이용시</h4>
					<ul>
						<li><span>지선</span>101번, 52번, 61번, 21번</li>
						<li><span>광역</span>1007번, 1100번, 1700번</li>
					</ul>
				</div>
				<div class='dir'>
					<img src="/resources/images/map10.PNG" alt="BigCo Inc. logo" />
				</div>
				<div class='dir_span'>
					<h3>디즈니 동산(경기도 안산시 상록구 충장로 98)</h3>
					<h5>지하철 이용시<span>수인분당선</span>사리역 1번 출구</h5>
					<h4>버스 이용시</h4>
					<ul>
						<li><span>지선</span>101번, 52번, 61번, 21번</li>
						<li><span>광역</span>1007번, 1100번, 1700번</li>
					</ul>
				</div>
			</div>
		</div>
	
	</body>
</html>