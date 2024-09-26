<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 상담게시판</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-list.css" />
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="content_inner">
		
				<h2>상담게시판</h2>
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
							<th width="150px">작성자</th>
							<th>제목</th>
							<th width="120px">작성일</th>
							<th width="100px">좋아요</th>
							<th width="100px">댓글</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${ empty postsList }">
								<tr>
									<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ postsList }" var="row" varStatus="loop">
									<tr>
										<td class="num">${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
										<td class="name">${ row.nickname }</td>
										<td class="title">
											<a href="./qnaboard/viewPost.do?board_idx=${ row.board_idx }">
												<p>${ row.title }</p>
												<p class="intro">${ row.content }</p>
											</a>
										</td>
										<td class="date">${ row.postdate }</td>
										<td class="like">${ row.likecount }</td>
										<td class="comment">${ row.commentcount }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<!-- 로그인 한 경우에만 글쓰기 버튼 -->
				<c:if test="${ not empty sessionScope.userId }">
				    <div class="write_btn">
				        <button type="button" onclick="location.href='../qnaboard/writePost.do';">글쓰기</button>
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






