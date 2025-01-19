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
<link rel="stylesheet" href="/css/hosp-list.css" />
<script src="/js/hospital.js"></script>
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<h2>병원 찾기</h2>
			<h3>병원명, 지역명, 해시태그 등으로 검색해보세요</h3>
			
			<!-- 검색 메뉴 -->
			<div class="search_menu">
				<form class="search_form" name="searchForm">
					<!-- 지역 선택 -->
					<div class="search_region">
						<select class="search_field" id="sido" name="searchSido">
							<option value="">-- 시/도 선택 --</option>
							<c:forEach items="${ sidoLists }"> var="sido">
								<option value="${ sido.sido }">${ sido.sido }</option>
							</c:forEach>
						</select>
						<select id="gugun" name="searchGugun" class="search_field">
							<option value="">-- 시/군/구 선택 --</option>
						</select>
						<select id="dong" name="searchDong" class="search_field">
							<option value="">-- 읍/면/동 선택 --</option>
						</select>
					</div>
					
					<!-- 키워드 검색 -->
					<div class="search_keyword">
						<select class="search_field" name="searchField">
							<option value="name">-- 검색 조건 선택 --</option>
							<option value="name">병원명</option>
							<option value="department">진료과목</option>
							<option value="hashtag">해시태그</option>
						</select>
						<input type="text" class="search_word" name="searchWord" placeholder="검색어를 입력하세요.">
						<button type="submit" class="search_btn" onclick="searchHosp(event)"></button>
					</div>
					
					<!-- 검색 필터 -->
					<div class="search_filter">
						<button type="button" class="filter-button" data-filter="parking" data-default-text="주차 가능">주차</button>
						<button type="button" class="filter-button" data-filter="pcr" data-default-text="PCR 검사 가능">PCR 검사</button>
						<button type="button" class="filter-button" data-filter="hospitalize" data-default-text="입원 가능">입원</button>
						<button type="button" class="filter-button" data-filter="system" data-default-text="예약 가능">예약</button>
						<button type="button" class="filter-button" data-filter="night" data-default-text="예약 가능">야간진료</button>
						<button type="button" class="filter-button" data-filter="weekend" data-default-text="예약 가능">주말진료</button>
					</div>
					<input type="hidden" name="filters" id="filters" value="">
				</form>
			</div>
			
			<!--  병원 목록 -->
			<div class="hosp_wrap">
				<div class="hosp_list">
					<c:choose>
						<c:when test="${ empty hospList }">
							<div>
								<p>검색 결과가 없습니다</p>
							</div>
						</c:when>
						<c:otherwise>
							<ul class="hosp">
								<c:forEach items="${ hospList }" var="row" varStatus="loop">
									<li onclick="location.href='./hospital/viewHosp.do?api_idx=${ row.api_idx }'">
										<!-- 병원 사진 -->
										<div class="hosp_photo">
											<c:if test="${ row.photo == null }">
												<!-- <img src="/images/hosp.png" alt=""> -->
											</c:if>
											<c:if test="${ row.photo != null }">
												<img src="/uploads/${ row.photo }" alt="">
											</c:if>
										</div>
										<!-- 병원 정보 -->
										<div class="hosp_info">
											<div class="hosp_name">
												<p>${ row.name }</p>
												<c:if test="${ row.enter == 'T' }">
													<span class="hosp_mark"></span>
												</c:if>
											</div>
											<div class="hosp_dept">
												<p>${ row.department }</p>
											</div>
											<div class="hosp_tel">
												<p class="sub_tit">전화</p>
												<div class="divider"></div>
												<p>${ row.tel }</p>
											</div>
											<div class="hosp_addr">
												<p class="sub_tit">주소</p>
												<div class="divider"></div>
												<p>${ row.address }</p>
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
											<!-- 해시태그 -->
											<c:if test="${ row.enter == 'T' }">
												<c:if test="${ not empty hashtagList }">
													<div class="hosp_hashtag">
														<ul>
															<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
																<c:if test="${ hashrow.hosp_ref == row.id }">
																	<li class="tag">
																		<p># ${ hashrow.tag }
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</div>
												</c:if>
											</c:if>
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
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>