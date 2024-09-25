<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-write.css" />
<script>
	function validateWriteForm(form) {
		if (form.writer_idx.value == '') {
			alert("작성자를 입력하세요.");
			form.name.focus();
			return false;
		}
		if (form.title.value == '') {
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if (form.content.value == '') {
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<h2>글쓰기</h2>
			<div class="board_inner">
				<form name="writeFrm" method="post"
					action="../qnaboard/writePost.do" onsubmit="return validateWriteForm(this);">
					<table class="board">
						<tr>
							<td class="left">제목</td>
							<td><input type="text" name="title" /></td>
						</tr>
						<tr>
							<td class="left">내용</td>
							<td class="area"><textarea name="content"></textarea></td>
						</tr>
					</table>    
					<div class="board_btn">
						<button type="button" onclick="location.href='../qnaboard.do';">취소</button>
						<button type="submit">완료</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<%-- <%@include file="../common/main_footer.jsp" %> --%>
</body>
</html>










