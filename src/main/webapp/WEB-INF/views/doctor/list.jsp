<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/doc-list.css" />
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="content_inner">
				<div class="list_title">
					<h2>의사 찾기</h2>
					<p>의사 이름을 검색해보세요</p>
				</div>
				
				<div class="list_search">
					<form class="searchForm" name="searchForm">
						<select class="searchField" name="searchField">
							<option value="name">이름</option>
							<option value="major">전공</option>
						</select>
						<input name="searchWord" class="searchKeyword" type="text" placeholder="검색어를 입력하세요">
						<input type="submit" class="search_btn" value="">
					</form>
				</div>
				
				<c:choose>
					<c:when test="${ empty doctorsList }">
						<tr>
							<p>검색 결과가 없습니다</p>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${ doctorsList }" var="row" varStatus="loop">
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
											<p>${ row.hospname }</p>
											<h3>${ row.name }</h3>
											<div class="detail">
												<!--  색상 다르게 (파랑 - 검정) -->
												<p>전공</p><p>${ row.major }</p><br/>
												<p>경력</p><p>${ row.career }</p><br/>
												<p>근무시간</p><p>${ row.hours }</p>
											</div>
											<div class="info_right">
												<div class="right_down">
													<p class="like">(하트) ${ row.likecount }</p>
													<p class="comm">(리뷰) ${ row.score } ${ row.reviewcount }</p>
												</div>
											</div>
											<a href="./doctor/viewDoctor.do?doc_idx=${ row.doc_idx }"><span class="blind">의사 바로가기</span></a>
										</div>
									</div>
								</li>
							</ul>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				
				<!-- 로그인 한 경우에만 글쓰기 버튼 -->
				<!-- 추후 의사의 마이페이지로 옮길 예정 테스트용 버튼이니 CSS 작업 안하셔도 됩니다! -->
			    <div class="write_btn">
			        <button type="button" onclick="location.href='../doctor/writeDoctor.do';">의사 등록하기</button>
			    </div>
			    
			    <!-- 페이지네이션 -->
				<div class="pagination">
					${ pagingImg }
				</div>

			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>