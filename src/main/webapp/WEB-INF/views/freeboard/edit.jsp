<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 자유게시판</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-edit.css" />
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="content_inner">
	    		<h2>게시글 수정하기</h2>
	   			<form name="writePostForm" method="post"
	   				action="../freeboard/editPost.do" onsubmit="return validateWriteFrom(this);">
	   				<input type="hidden" name="board_idx" value="${ boardDTO.board_idx }" />
	   				<table class="board">
	   					<tr>
	   						<td class="left">제목</td>
	   						<td colspan="3" style="padding: 0 5px"><input type="text" name="title" value="${ boardDTO.title }" /></td>
	   					</tr>
	   					<tr>
	   						<td class="left">작성자</td>
	   						<td colspan="3">
	   							${ boardDTO.nickname }
	   						</td>
	   					</tr>
	   					<tr>
	   						<td class="left">작성일</td> <td>${ boardDTO.postdate }</td>
	   						<td class="left">조회수</td> <td>${ boardDTO.visitcount }</td>
	   					</tr>
	   					<tr>
	   						<td class="left">내용</td>
	   						<td class="area board_content" colspan="3"><textarea name="content">${ boardDTO.content }</textarea></td>
	   					</tr>
	   				</table>
	   				<!-- 하단 메뉴(버튼) -->
	   				<div class="board_btn">
	   					<button type="button" onclick="location.href='../freeboard/viewPost.do?board_idx=${ boardDTO.board_idx }'">취소</button>
	   					<button type="submit">완료</button>
	   				</div>
	   			</form>
    		</div>
    	</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>