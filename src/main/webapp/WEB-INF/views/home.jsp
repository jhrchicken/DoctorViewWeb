<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="common/head.jsp" %>
<link rel="stylesheet" href="/css/main.css" />
</head>
<body>
<%@include file="common/main_header.jsp" %>
<main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="main_content">
				<section class="search">
					
				</section>
				
				
				<section class="hashtag">
					<h2>빠른 검색</h2>
					<ul>
						<li><a href="#"># 감기/몸살</a></li>
						<li><a href="#"># 코로나</a></li>
						<li><a href="#"># 소아과</a></li>
					</ul>
				</section>
				
				
				<section class="link">
					<h2>바로가기</h2>
					<ul>
						<li><a href="#">커뮤니티</a></li>
						<li><a href="#">실시간 의료 상담</a></li>
					</ul>
				</section>
				
				
				<section class="notify">
					<div>
						<p>2024년 5월 20일부터 병원 접수, 진료 시 신분증 지참 필수입니다!</p>
						
						<br />
						
						<strong>[의료기관 본인확인 의무화]</strong>
						<p>국민건강보호법 개정(제12조4항 신설)에 따라 2024년 5월 20일부터 본인확인 의무화 제도 시행</p>
						
						<br />
						
						<strong>[본인 확인 방법]</strong>
						<p>신분증 / 모바일 신분증 / 운전면허증 / 건강보험증 /모바일건강보험증앱 / 여권 등<br />
						※ 증명서 또는 서류에 유효기간이 적혀있는 경우에는 유효기간이 지나지 않아야 하며 실물 신분증만 가능(사본, 사진으로 찍은 신분증 불가)<br />
						※ 19세미만, 응급환자 등은 주민등록번호로 본인확인 가능<br />
						※ 신분증 미지참시 전액본인부담으로 진료받은 후 14일이내 신분증과 진료비영수증<br />
						지참하여 건강보험 적용된 금액으로 정산</p>
					</div>
				</section>
			</div>
		</div>
	</div>
</main>	 
<%@include file="common/main_footer.jsp" %>
</body>
</html>