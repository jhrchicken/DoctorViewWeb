<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 마이페이지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-reservation-list.css" />
<script>
function cancelReservation(app_id) {
	if (confirm("예약을 취소하시겠습니까?")) {
		var form = document.forms["cancelReservationForm_" + app_id];
		form.method = "post";
		form.action = "/reserve/cancel.do";
		form.submit();
	}
}

function hideReservation(app_id) {
	if (confirm("숨겨진 내역은 다시 되돌릴 수 없습니다. 예약내역을 숨김처리 하시겠습니까?")) {
		var form = document.forms["hideReservationForm_" + app_id];
		form.action = "/reserve/delete.do";
		form.submit();
	}
}
</script>
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
		<h2>예약 목록</h2>
			
			
			
			
<div class="my_doctor">
<c:choose>
	<c:when test="${ empty reserveInfo }">
		<div class="none">
			<p>예약 정보가 없습니다.</p>
		</div>
	</c:when>
	<c:otherwise>
		<ul class="doctor">
			<c:forEach items="${ reserveInfo }" var="row" varStatus="loop">
				
				<!-- user 회원 화면-->
				<c:if test="${ userAuth eq 'ROLE_USER' }">
					<c:if test="${ row.hide eq 'F' }">
					
					<li>
					
						<form name="cancelReservationForm_${row.app_id}">
							<input type="hidden" name="app_id" value="${ row.app_id }" />
						</form>
						<form name="hideReservationForm_${row.app_id}">
							<input type="hidden" name="app_id" value="${ row.app_id }" />
						</form>
						
						<div class="info">
							<div class="info_top">
								<h3>${ row.hospname }</h3>
								
								<div class="detail_content">
									<div class="detail">
										<div class="details">
											<p class="blue">예약 의사</p>
											<p>${ row.doctorname }</p>
		
										</div>
										<div class="details">
											<p class="blue">예약자</p>
											<p>${ row.username }</p>
										</div>
										<div class="details">
											<p class="blue">예약일</p>
											<p>${ row.postdate } ${ row.posttime }</p>
										</div>
									</div>
									<div class="detail memo">
										<div class="details">
										    <c:if test="${ not empty row.user_memo }">
												<div class="details">
													<p class="blue">메모</p>
													<p>${ row.user_memo }</p>
												</div>
			        						</c:if>
		        						</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 하단 메뉴(버튼) -->
						<div class="board_btn">
						
							<!-- 메모작성 유무에 따라 버튼 text 변경  -->
							<c:if test="${ empty row.user_memo }">
								<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">메모<br />추가</button>
							</c:if>
							<c:if test="${ not empty row.user_memo }">
								<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">메모<br />수정</button>
							</c:if>
							
							<!-- 추가 예정 -->	
<%-- 							<button type="button" onclick="location.href='/reserve/delete.do?app_id=${ row.app_id }';">내역<br />숨김</button> --%>
							<button type="button" onclick="hideReservation(${ row.app_id });">내역<br />숨김</button>
							<button type="button" onclick="cancelReservation(${ row.app_id });">예약<br />취소</button>
						</div>
						<c:if test="${ row.cancel eq 'T' }">
							<div class="cancel">
								<p>취소된 예약</p>
							</div>
						</c:if>
					</li>
					
					</c:if>
				</c:if>
				
				<!-- hosp 회원 화면-->
				<c:if test="${ userAuth eq 'ROLE_HOSP' }">
				
				<li>
					<c:if test="${ row.cancel eq 'T' }">
						<h3>취소된 예약</h3>
					</c:if>
							
					<div class="info">
						<div class="info_top">
							<div class="detail">
								<div class="details">
									<p class="blue">예약일</p>
									<p>${ row.postdate }</p>
								</div>
								<div class="details">
									<p class="blue">시간</p>
									<p>${ row.posttime }</p>
								</div>
								<div class="details">
									<p class="blue">예약 의사</p>
									<p>${ row.doctorname }</p>
								</div>
								<div class="details">
									<p class="blue">예약자명</p>
									<p>${ row.username }</p>
								</div>
								<div class="details">
									<p class="blue">예약자 전화번호</p>
									<p>${ row.tel }</p>
								</div>
								<div class="details">
									<p class="blue">예약자 주민번호</p>
									<p>${ row.rrn }</p>
								</div>
								<div class="details">
									<p class="blue">예약자 주소</p>
									<p>${ row.address }</p>
								</div>
								<div class="details">
							    <c:if test="${ not empty row.hosp_memo }">
									<div class="details">
										<p class="blue">메모</p>
										<p>${ row.hosp_memo }</p>
									</div>
        						</c:if>
        						</div>

							</div>
						</div>
					</div>
					
					<!-- 추가 예정 -->
					<!-- 하단 메뉴(버튼) -->
<!-- 					<div class="board_btn"> -->
<%-- 						<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">메모<br />추가</button> --%>
<%-- 						<button type="button" onclick="deleteReservation(${ row.app_id });">삭제</button> --%>
<!-- 					</div> -->
				</li>
				</c:if>
			</c:forEach>
			
		</ul>
		<!-- 페이지네이션 -->
		<div class="pagination">
			<div class="pagination_inner">
				${ pagingImg }
			</div>
		</div>	
	</c:otherwise>
</c:choose>
</div>
			
			
		</div>
	</div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>