<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 마이페이지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-reservation-memo.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<h2>메모 추가</h2>
			
			
<div class="my_doctor">
	<div class="doctor">
		<c:if test="${ not empty reserveDetail }">
				<!-- 예약정보 삭제용 form -->
				<form name="deleteReservationForm_${reserveDetail.app_id}" >
					<input type="hidden" name="app_id" value="${ reserveDetail.app_id }" />
				</form>
				
				<form name="extraInfoForm" action="/reserve/extraInfo.do" method="post">
				<div class="info">
					<input type="hidden" name="app_id" value="${ reserveDetail.app_id }" />
					<div class="info_top">
						<h3>${ reserveDetail.hospname }</h3>
						<div class="detail_content">
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
									<p class="blue">예약일</p>
									<p>${ reserveDetail.postdate } ${ reserveDetail.posttime }</p>
								</div>
							</div>
							<div class="detail memo">
								<div class="details">
									<p class="blue">메모</p>
									<input type="text" name="user_memo" value="${ reserveDetail.user_memo }" />
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="board_btn">
					<button type="submit">완료</button>
				</div>
				
				</form>
		</c:if>
</div>
			
			
			
			
			
		</div>
	</div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>