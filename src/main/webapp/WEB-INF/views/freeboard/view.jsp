<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
	<h2>게시판 읽기(Mybatis)</h2>	
	<form name="deletePostForm">
		<input type="hidden" name="board_idx" value="${ boardDTO.board_idx }" />
	</form>
	<table border="1" width="90%">
	    <colgroup>
	        <col width="15%"/> <col width="35%"/>
	        <col width="15%"/> <col width="*"/>
	    </colgroup>	
	    <!-- 게시글 정보 -->
	    <tr>
	        <td>번호</td> <td>${ boardDTO.board_idx }</td>
	        <td>작성자</td> <td>${ boardDTO.writer_ref }</td>
	    </tr>
	    <tr>
	        <td>작성일</td> <td>${ boardDTO.postdate }</td>
	        <td>조회수</td> <td>${ boardDTO.visitcount }</td>
	    </tr>
	    <tr>
	        <td>제목</td>
	        <td colspan="3">${ boardDTO.title }</td>
	    </tr>
	    <tr>
	        <td>내용</td>
	        <td colspan="3" height="100">
	        	${ boardDTO.content }
	        </td>
	    </tr>
	    <!-- 하단 메뉴(버튼) -->
	    <tr>
	        <td colspan="4" align="center">
	            <button type="button" onclick="location.href='../freeboard/editPost.do?board_idx=${ param.board_idx }';">
	                수정하기
	            </button>
	            <button type="button" onclick="deletePost(${ param.board_idx });">
	                삭제하기
	            </button>
	            <button type="button" onclick="location.href='../freeboard.do';">
	                목록 바로가기
	            </button>
	        </td>
	    </tr>
	</table>
	
	<!-- 댓글 -->
	<form name="deleteCommentForm" method="post">
	    <input type="hidden" name="board_ref" value="" />
	    <input type="hidden" name="comm_idx" value="" />
	</form>
	<!-- 하단 메뉴 (바로가기, 글쓰기) -->
	<div>
		<div>
			<!-- 댓글 입력 폼 -->
			<form method="post" action="../freeboard/writeComment.do" onsubmit="return validateCommentForm(this);">
		  		<input type="hidden" name="board_idx" value="${ param.board_idx }" />
		  		<input type="text" name="id" placeholder="작성자 아이디를 입력하세요." />
		  		<input type="text" name="content" placeholder="댓글을 입력하세요." />
		  		<!-- 댓글 작성하기 버튼 -->
		  		<button type="submit">댓글 작성하기</button>
		  		</form>
		</div>
	</div>
	<table border="1" width="90%">
        <tr>
            <th width="15%">작성자 아이디</th>
            <th width="*">내용</th>
            <th width="15%">작성일</th>
        </tr>
<c:choose>
    <c:when test="${ empty commentsList }"> 
        <tr>
            <td colspan="5" align="center">
                댓글을 남겨보세요
            </td>
        </tr>
    </c:when> 
    <c:otherwise> 
        <c:forEach items="${ commentsList }" var="row" varStatus="loop">
        <tr align="center">
            <td>${ row.writer_ref }</td>
            <td align="left">${ row.content }</td> 
            <td>${ row.postdate }</td>
		  	<td>
				<%-- <c:if test="${ row.id == id }"> --%>
				<!-- 수정 버튼 클릭 시 댓글 내용을 모달에 표시 -->
		            <button type="button" data-bs-toggle="modal" data-bs-target="#editCommentModal"
		                    onclick="openEditModal(${ row.board_ref }, ${ row.comm_idx }, '${ row.content }')">
		                수정
		            </button>
				<button type="button" onclick="deleteComment(${ row.board_ref }, ${ row.comm_idx });">
					삭제
				</button>
				<%-- </c:if> --%>
			</td>
        </tr>
        </c:forEach>
    </c:otherwise>    
</c:choose>
    </table>
</body>

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
