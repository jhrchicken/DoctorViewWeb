<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 마이페이지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-doctor-list.css" />

</head>
<body>
<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="content_inner">
				<h2>의사 목록</h2>
				
				<c:choose>
					<c:when test="${ empty doctorDTO }">
						<tr>
							<p>등록된 의사가 없습니다.</p>
						</tr>
					</c:when>
					<c:otherwise>
						<ul class="doctor">
							<c:forEach items="${ doctorDTO }" var="row" varStatus="loop">
								<li>
									<span class="img">
										<c:if test="${ row.photo == 'null' }">
											<img src="/images/doctor.png" alt="" />
										</c:if>
										<c:if test="${ row.photo != 'null' }">
											<img src="/uploads/${ row.photo }" alt="" />
										</c:if>
									</span>
									<div class="info">
										<div class="info_top">
											<h3>${ row.doctorname }</h3>
											<div class="detail">
												<div class="details">
													<p class="blue">전공</p>
													<p>${ row.major }</p>
												</div>
												<div class="details">
													<p class="blue">경력</p>
													<p>${ row.career }</p>
												</div>
												<div class="details">
													<p class="blue">근무시간</p>
													<p>${ row.hours }</p>
												</div>
											</div>
										</div>
										
										<!-- 찐 요청명 -->
										<a href="/doctor/viewDoctor.do?doc_idx=${ row.doc_idx }"><span class="blind">의사 바로가기</span></a>
									</div>
									
									<!-- 하단 메뉴(버튼) -->
									<div class="board_btn">
										<button type="button">수정</button>
										<button type="button">삭제</button>
									</div>
								</li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
				
			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>