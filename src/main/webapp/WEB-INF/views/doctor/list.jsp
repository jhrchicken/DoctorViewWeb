<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/doc-list.css" />
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<h2>의사 찾기</h2>
			<h3>의사 이름과 전공으로 검색해보세요</h3>
			
			<!-- 검색 메뉴 -->
			<div class="search_menu">
				<form class="search_form" name="searchForm">
					<div class="search_keyword">
						<select class="search_field" name="searchField">
							<option value="name">--- 조건 선택 ---</option>
							<option value="name">이름</option>
							<option value="major">전공</option>
						</select>
						<input type="text" class="search_word" name="searchWord" placeholder="검색어를 입력하세요.">
						<input type="submit" class="search_btn" value="">
					</div>
				</form>
			</div>
			
			<!-- 의사 목록 -->
			<div class="doc_wrap">
				<div class="doc_list">
					<c:choose>
						<c:when test="${ empty doctorsList }">
							<div>
								<p>검색 결과가 없습니다</p>
							</div>
						</c:when>
						<c:otherwise>
							<ul class="doctor">
								<c:forEach items="${ doctorsList }" var="row" varStatus="loop">
									<li onclick="location.href='./doctor/viewDoctor.do?doc_idx=${ row.doc_idx }'">
										<!-- 의사 사진 -->
										<div class="doc_photo">
											<c:if test="${ row.photo == null }">
												<img src="/images/doctor.png" alt="">
											</c:if>
											<c:if test="${ row.photo != null }">
												<img src="/uploads/${ row.photo }" alt="">
											</c:if>
										</div>
										<!-- 의사 정보 -->
										<div class="doc_info">
											<div class="doc_name">
												<p>${ row.name }</p>
											</div>
											<div class="doc_hosp">
												<p>${ row.hospname }</p>
											</div>
											<div class="doc_major">
												<p class="sub_tit">전공</p>
												<div class="divider"></div>
												<p>${ row.major }</p>
											</div>
											<div class="doc_career">
												<p class="sub_tit">경력</p>
												<div class="divider"></div>
												<p>${ row.career }</p>
											</div>
											<div class="doc_hours">
												<p class="sub_tit">근무시간</p>
												<div class="divider"></div>
												<p>${ row.hours }</p>
											</div>
											<!-- 찜과 리뷰 -->
											<div class="info_right">
												<div class="like">
													<img src="/images/mark_full.svg" alt="">
													<p>${ row.likecount }</p>
												</div>
												<div class="review">
													<img src="/images/star.svg" alt="">
													<p>${ row.score }</p>
													<p class="count">(${ row.reviewcount })</p>
												</div>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
				
				<!-- 더보기 버튼 -->
				<div class="btn_wrap">
					<a class="more_btn" href="">
						<span>더보기</span>
					</a>
				</div>
			</div>
		</div>
	</main>



<%-- <main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="list">
				<c:choose>
					<c:otherwise>
						<ul class="doctor">
							<c:forEach items="${ doctorsList }" var="row" varStatus="loop">
								<li>
									<div class="info">
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
										<a href="./doctor/viewDoctor.do?doc_idx=${ row.doc_idx }"><span class="blind">의사 바로가기</span></a>
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
</main> --%>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>