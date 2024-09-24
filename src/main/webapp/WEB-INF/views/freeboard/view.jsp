<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-view.css" />
<script>
function deletePost(board_idx) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		var form = document.deletePostForm;
		form.method = "post";
		form.action = "/freeboard/deletePost.do";
		form.submit();
	}
}
function deleteComment(board_ref, comm_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var form = document.deleteCommentForm;
		// hidden 필드에 값을 동적으로 설정
        form.board_ref.value = board_ref;
        form.comm_idx.value = comm_idx;
		form.method = "post";
		form.action = "/freeboard/deleteComment.do";
		form.submit();
	}
}
function openWriteModal(board_idx) {
	document.getElementById("board_idx").value = board_idx;
}
function openEditModal(board_ref, comm_idx, content) {
	document.getElementById("board_ref").value = board_ref;
    document.getElementById("content").value = content;
    document.getElementById("comm_idx").value = comm_idx;
}
function validateCommentForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	
	<main id="container">
		<div class="content">
			<!-- 게시글 -->
			<h2>게시글 상세보기</h2>	
			<div class="board_inner">
				<form name="deletePostForm">
					<input type="hidden" name="board_idx" value="${ boardDTO.board_idx }" />
				</form>
				
				<table class="board">
					<!-- 게시글 정보 -->
					<tr>
						<td class="left">제목</td>
						<td colspan="3">${ boardDTO.title }</td>
					</tr>
					<tr>
						<td class="left">작성자</td>
						<td colspan="3">${ boardDTO.nickname }</td>
					</tr>
					<tr>
						<td class="left">작성일</td> <td>${ boardDTO.postdate }</td>
						<td class="left">조회수</td> <td>${ boardDTO.visitcount }</td>
					</tr>
					<tr>
						<td class="left">내용</td>
						<td class="board_content" colspan="3">${ boardDTO.content }</td>
					</tr>
					<!-- 하단 메뉴(버튼) -->
				</table>
				<div class="board_btn">
					<button type="button" onclick="location.href='../freeboard.do';">뒤로가기</button>
					<!-- 로그인 사용자와 글 작성자가 일치하는 경우 수정 삭제 버튼 -->
					<c:if test="${ boardDTO.writer_ref == sessionScope.userId }">
						<button type="button" onclick="location.href='../freeboard/editPost.do?board_idx=${ param.board_idx }';">수정하기</button>
						<button type="button" onclick="deletePost(${ param.board_idx });">삭제하기</button>
					</c:if>
				</div>
				
				<div class="like_btn">
					<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
					<c:if test="${ likecheck == 0 }">
						<button type="button" onclick="location.href='../freeboard/clickLike.do?board_idx=${ param.board_idx }';">
							<p class="like"></p>
							<span>${ likecount }</span>
						</button>
					</c:if>
					<!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
					<c:if test="${ likecheck == 1 }">
						<button class="push" type="button" onclick="location.href='../freeboard/clickLike.do?board_idx=${ param.board_idx }';">
							<p class="like"></p>
							<span>${ likecount }</span>
						</button>
					</c:if>
					<!-- 로그인 한 사용자가 신고를 누르지 않은 경우 -->
					<c:if test="${ reportcount == 0 }">
						<button type="button" onclick="location.href='../freeboard/clickReport.do?board_idx=${ param.board_idx }';">
							<p class="dislike"></p>
							<span>${ reportcount }</span>
						</button>
					</c:if>
					<!-- 로그인 한 사용자가 신고를 누른 경우 -->
					<c:if test="${ reportcount == 1 }">
						<button class="push" type="button" onclick="location.href='../freeboard/clickReport.do?board_idx=${ param.board_idx }';">
							<p class="dislike"></p>
							<span>${ reportcount }</span>
						</button>
					</c:if>
				</div>
			
				<form name="deleteCommentForm" method="post">
				    <input type="hidden" name="board_ref" value="" />
				    <input type="hidden" name="comm_idx" value="" />
				</form>
				<div>
					<!-- 로그인 한 경우 댓글 작성 버튼 -->
			  		<c:if test="${ not empty sessionScope.userId }">
				  		<div class="comment_btn">
					  		<button type="button" data-bs-toggle="modal" data-bs-target="#writeCommentModal"
					  			onclick="openWriteModal(${ param.board_idx })">
				                댓글 작성하기
				            </button>
			  			</div>
			  		</c:if>
				</div>
				<table class="comment">
					<thead align="center">
						<th width="150px">작성자</th>
						<th width="*">내용</th>
						<th width="150px">작성일</th>
						<th width="150px">수정 / 삭제</th>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${ empty commentsList }">
								<tr>
									<td colspan="4" align="center">
										댓글을 남겨보세요
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ commentsList }" var="row" varStatus="loop">
									<tr align="center">
							            <td class="writer">${ row.nickname }</td>
							            <td class="comm_content" align="left">${ row.content }</td> 
							            <td class="postdate">${ row.postdate }</td>
									  	<td class="comm_btn">
									  		<!-- 로그인 사용자와 댓글 작성자가 일치하는 경우 수정 삭제 버튼 -->
											<c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
									            <button type="button" data-bs-toggle="modal" data-bs-target="#editCommentModal"
									                    onclick="openEditModal(${ row.board_ref }, ${ row.comm_idx }, '${ row.content }')">
									                수정
									            </button>
												<button type="button" onclick="deleteComment(${ row.board_ref }, ${ row.comm_idx });">
													삭제
												</button>
											</c:if>
										</td>
							        </tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>		
	</main>
    <%-- <%@include file="../common/main_footer.jsp" %> --%>
    
    <!-- 댓글 작성 모달창 -->
	<form method="post" action="../freeboard/writeComment.do" onsubmit="return validateCommentForm(this);">
		<input type="hidden" id="board_idx" name="board_idx" value="" />
		<div class="modal" id="writeCommentModal" >
			<div class="modal-dialog">
				<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">댓글 작성</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<textarea class="form-control" name="content" style="height: 100px;" placeholder="내용을 입력하세요"></textarea>
				</div>
				<!-- Modal Footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">작성하기</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
				</div>
			</div>
		</div>
	</form>

	<!-- 댓글 수정 모달창 -->
	<form method="post" action="../freeboard/editComment.do" onsubmit="return validateCommentForm(this);">
		<input type="hidden" id="board_ref" name="board_ref" value="" />
		<div class="modal" id="editCommentModal" >
			<div class="modal-dialog">
				<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">댓글 수정</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<input type="hidden" id="comm_idx" name="comm_idx" value="">
					<textarea class="form-control" id="content" name="content" style="height: 100px;"></textarea>
				</div>
				<!-- Modal Footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">수정하기</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
				</div>
			</div>
		</div>
	</form>
</body>   
</html>