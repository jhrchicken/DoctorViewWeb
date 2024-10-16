<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 내가 쓴 글</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-list.css" />
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="content_inner">
				<h2>내가 쓴 글</h2>
				<div class="board_top">
					<p class="board_total">
						총 <strong>${ maps.total }</strong>건의 게시글이 있습니다.
					</p>
				</div>
				
				<!-- 게시글 목록 -->
				<table class="board">
					<thead>
						<tr>
							<th width="100px">NO</th>
							<th width="150px">작성자</th>
							<th width="150px">게시판</th>
							<th>제목</th>
							<th width="120px">작성일</th>
							<th width="100px">좋아요</th>
							<th width="100px">댓글</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${ empty postList }">
								<tr>
									<td colspan="7" align="center">등록된 게시물이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ postList }" var="row" varStatus="loop">
									<tr>
										<td class="num">${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
										<td class="name">${ row.nickname }</td>
										<c:if test="${ row.boardname == 'freeboard' }">
											<td class="name">자유게시판</td>
										</c:if>
										<c:if test="${ row.boardname == 'qnaboard' }">
											<td class="name">상담게시판</td>
										</c:if>
										<td class="title">
											<c:if test="${ row.boardname == 'freeboard' }">
												<a href="../freeboard/viewPost.do?board_idx=${ row.board_idx }">
													<p>${ row.title }</p>
													<p class="intro">${ row.content }</p>
												</a>
											</c:if>
											<c:if test="${ row.boardname == 'qnaboard' }">
												<a href="../qnaboard/viewPost.do?board_idx=${ row.board_idx }">
													<p>${ row.title }</p>
													<p class="intro">${ row.content }</p>
												</a>
											</c:if>
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

				<!-- 페이지네이션 -->
				<c:if test="${ not empty postList }">
					<div class="pagination">
						<div class="pagination_inner">
							${ pagingImg }
						</div>
					</div>	
				</c:if>	
			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>

