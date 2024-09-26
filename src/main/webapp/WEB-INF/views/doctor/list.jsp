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
<link rel="stylesheet" href="/css/board-list.css" />
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<h2>의사 찾기</h2>
			<div class="board_inner">
				<div class="board_top">
					<p class="board_total">
						총 <strong>${ maps.total }</strong>건의 게시글이 있습니다.
					</p>
					<!-- 검색 폼 -->
					<div class="board_search">
						<form class="searchForm" method="get" name="searchForm">
							<select class="searchField" name="searchField">
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
							<input class="searchWord" type="text" name="searchWord" placeholder="검색어를 입력하세요" />
							<input class="search_btn" type="submit" value=''>
						</form>
					</div>
				</div>
				
				<!-- 게시글 목록 -->
				<table class="board">
					<thead>
						<tr>
							<th width="100px">NO</th>
							<th>사진</th>
							<th width="200px">의사이름</th>
							<th width="200px">소속병원</th>
							<th width="200px">전공</th>
							<th width="200px">진료시간</th>
							<th width="200px">좋아요수</th>
							<th width="100px">별점</th>
							<th width="100px">리뷰수</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${ empty doctorsList }">
								<tr>
									<td colspan="5" align="center">등록된 의사가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ doctorsList }" var="row" varStatus="loop">
									<tr>
										<td class="num">${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
										<!-- 여기에 조건문 추가 필요 -->
										<c:if test="${ row.photo == null }">
											<td class="photo"><img src="/images/account.svg" alt="의사사진"></img></td>
										</c:if>
										<c:if test="${ row.photo != null }">
											<td class="photo">${ row.photo }</td>
										</c:if>
										<td class="name"><a href="./doctor/viewDoctor.do?doc_idx=${ row.doc_idx }">${ row.name }</a></td>
										<td class="hospname">${ row.hospname }</td>
										<td class="major">${ row.major }</td>
										<td class="hours">${ row.hours }</td>
 										<td class="like">${ row.likecount }</td>
 										
										<td class="score">${ row.score }</td>
										<td class="review">${ row.reviewcount }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<!-- 로그인 한 경우에만 글쓰기 버튼 -->
				<c:if test="${ not empty sessionScope.userId }">
				    <div class="write_btn">
				        <button type="button" onclick="location.href='../doctor/writeDoctor.do';">의사 등록하기</button>
				    </div>
				</c:if>
				
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






