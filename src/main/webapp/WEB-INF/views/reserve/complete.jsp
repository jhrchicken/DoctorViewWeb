<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 병원 예약</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/reserve-alert.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
  <div class="content">
    <div class="content_inner">
      	
      	<div class="complete_wrap">
	      	<div class="complete">
	      		<img src="/images/complete.svg" alt="" />
	      		<div class="message">
	      		
	      			<div class="details">
	      				<p class="blue">병원: ${ reserveDTO.hospname }</p>
	      				<p class="blue">날짜 및 시간: ${ reserveDTO.postdate }, ${ reserveDTO.posttime }</p>
	      				<p class="blue">방문자: ${ reserveDTO.username }</p>
					</div>
								
					<p>예약이 완료되었습니다.</p>
					<p>방문 시 신분증을 꼭 지참해주세요!</p>
	      		</div>
				<a href="../../reserve.do">예약관리 페이지로 이동</a>
	      	</div>
      	</div>
            
    </div>
  </div>
</main>
<%@include file="../common/main_footer.jsp" %>
</body>
</html>