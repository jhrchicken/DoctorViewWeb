<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 예약정보 추가</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-doctor-list.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<h2>예약 정보 추가</h2>
			
			
			
			
<div class="my_doctor">
	<ul class="doctor">
		<c:if test="${ not empty reserveDetail }">
			<li>
				<!-- 예약정보 삭제용 form -->
				<form name="deleteReservationForm_${reserveDetail.app_id}" >
					<input type="hi-dden" name="app_id" value="${ reserveDetail.app_id }" />
				</form>
				
				<form name="extraInfoForm" action="/reserve/extraInfo.do" method="post">
				<div class="info">
					<input type="hi-dden" name="app_id" value="${ reserveDetail.app_id }" />
					<div class="info_top">
						<h3>${ reserveDetail.hospname }</h3>
						<div class="detail">
							<div class="details">
								<p class="blue">예약 의사</p>
								<p>${ reserveDetail.doctorname }</p>
							</div>
							<div class="details">
								<p class="blue">예약자</p>
								<p>${ reserveDetail.username }</p>
							</div>
							<div class="details">
								<p class="blue">날짜</p>
								<p>${ reserveDetail.postdate }</p>
							</div>
							<div class="details">
								<p class="blue">시간</p>
								<p>${ reserveDetail.posttime }</p>
							</div>
							<div class="details">
								<p class="blue">메모</p>
								<input type="hi-dden" name="user_memo" value="${ reserveDetail.user_memo }" />
							</div>
						</div>
					</div>
				</div>
				
				<div class="board_btn">
					<button type="submit">완료</button>
					<button type="button" onclick="deleteReservation(${ reserveDetail.app_id });">삭제</button>
				</div>
				
				</form>
			</li>
		</c:if>
	</ul>
</div>
			
			
			
			
			
		</div>
	</div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>