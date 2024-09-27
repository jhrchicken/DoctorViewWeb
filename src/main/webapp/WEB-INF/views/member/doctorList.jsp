<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료진 관리</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/edit-user.css" />

</head>
<body>
<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="content_inner">
				<div class="list_title">
					<h2>의료진 목록</h2>
				</div>
				
				<c:choose>
					<c:when test="${ empty doctorDTO }">
						<tr>
							<p>의사정보가 없습니다</p>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${ doctorDTO }" var="row" varStatus="loop">
							<ul class="hospital">
								<li>
									<span class="img">
										<c:if test="${ row.photo == null }">
											<img src="/images/account.svg" alt=""></img>
										</c:if>
										<c:if test="${ row.photo != null }">
											${ row.photo }
										</c:if>
									
									</span>
									<div class="info">
										<div class="info_top">
											<!-- 소속병원 -->
											<p>${ hospname }</p>
											<h3>${ row.doctorname }</h3>
											<div class="detail">
												<!--  색상 다르게 (파랑 - 검정) -->
												<p>전공</p><p>${ row.major }</p><br/>
												<p>경력</p><p>${ row.career }</p><br/>
												<p>근무시간</p><p>${ row.hours }</p>
											</div>
											<!-- 찐 요청명 -->
											<a href="/doctor/viewDoctor.do?doc_idx=${ row.doc_idx }"><span>의사 바로가기</span></a>
											<!-- 테스트용 요청명 -->
<%-- 											<a href="/member/viewDoctor.do?doc_idx=${ row.doc_idx }"><span>의사 바로가기</span></a> --%>
										</div>
									</div>
								</li>
							</ul>
						<p>-------------------------------------------------</p>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				
			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>