<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 찜한 병원</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-heart.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>
<main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="list_title">
				<h2>찜한 병원</h2>
			</div>
			
			<div class="list">
				<c:choose>
					<c:when test="${ empty hospList }">
						<div class="none">
							<p>검색 결과가 없습니다</p>
						</div>
					</c:when>
					<c:otherwise>
						<ul class="hospital">
							<c:forEach items="${ hospList }" var="row" varStatus="loop">
								<li>
									<span class="img">
										<c:if test="${ row.photo == null }">
											<img src="/images/hospital.png" alt=""></img>
										</c:if>
										<c:if test="${ row.photo != null }">
											<img src="/uploads/${ row.photo }">
										</c:if>
									</span>
									<div class="info">
										<div class="info">
											<div class="info_top">
												<div class="hosp_name">
													<h3>${ row.name }</h3>
													<!-- 입점한 병원 인증마크 표시 -->
													<c:if test="${ row.enter == 'T' }">
														<span class="approve"></span>
													</c:if>
												</div>
												<div class="depdis">
													<p>${ row.department }</p>
													<!-- 거리 정보가 있을 때만 쩜 나오게 처리해주세욧!!!!!!!!! -->
													<%-- <p>•</p>
													<p>${ row.distance }</p> --%>
												</div>
											</div>
											<div class="detail">
												<div class="details">
													<p class="blue">전화</p>
													<p>${ row.tel }</p>
												</div>
												<div class="details">
													<p class="blue">주소</p>
													<p class="address">${ row.address }</p>
												</div>
											</div>
											<!-- 입점한 병원 좋아요 리뷰 수 표시 -->
											<c:if test="${ row.enter == 'T' }">
												<div class="info_right">
													<p class="like">${ row.likecount }</p>
													<p class="star">${ row.score } (${ row.reviewcount })</p>
												</div>
												
												<!-- 해시태그 -->
												<c:if test="${ not empty hashtagList }">
													<div class="hashtag">
														<ul>
															<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
																<c:if test="${ hashrow.hosp_ref == row.id }">
																	<li class="hash">
																		<p>${ hashrow.tag }</p>
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</div>
												</c:if>
											</c:if>
											<div class="info_right">
												<p class="like">${ row.likecount }</p>
												<p class="star">${ row.score } (${ row.reviewcount })</p>
											</div>
											
										</div>
									</div>
									<a href="../hospital/viewHosp.do?api_idx=${ row.api_idx }"><span class="blind">병원 바로가기</span></a>
								</li>
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