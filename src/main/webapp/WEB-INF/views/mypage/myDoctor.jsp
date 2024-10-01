<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 찜한 의사</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/doc-list.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="list_title">
				<h2>찜한 의사</h2>
			</div>
			
			<div class="list">
				<c:choose>
					<c:when test="${ empty doctorList }">
						<tr>
							<p>검색 결과가 없습니다</p>
						</tr>
					</c:when>
					<c:otherwise>
						<ul class="doctor">
							<c:forEach items="${ doctorList }" var="row" varStatus="loop">
								<li>
									<span class="img">
										<c:if test="${ row.photo == 'NULL' }">
											<img src="/images/doctor.png" alt="" />
										</c:if>
										<c:if test="${ row.photo != 'NULL' }">
											<img src="/uploads/${ row.photo }" />
										</c:if>
									</span>
									<div class="info">
										<div class="info_top">
											<h3>${ row.name }</h3>
											<p>${ row.hospname }</p>
										</div>
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
										<div class="info_right">
											<p class="like">${ row.likecount }</p>
											<p class="star">${ row.score } (${ row.reviewcount })</p>
										</div>
										<a href="../doctor/viewDoctor.do?doc_idx=${ row.doc_idx }"><span class="blind">의사 바로가기</span></a>
									</div>
								</li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
			
			<!-- 페이지네이션 -->
			<div class="pagination">
				<div class="pagination_inner">
					${ pagingImg }
				</div>
			</div>	
		</div>
	</div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>