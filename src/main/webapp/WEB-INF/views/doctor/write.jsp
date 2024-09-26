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
		if (form.name.value == '') {
			alert("이름을 입력하세요.");
			form.name.focus();
			return false;
		}
		if (form.major.value == '') {
			alert("전공을 입력하세요.");
			form.major.focus();
			return false;
		}
		if (form.career.value == '') {
			alert("경력을 입력하세요.");
			form.career.focus();
			return false;
		}
		if (form.hours.value == '') {
			alert("진료 요일 및 시간을 입력하세요.");
			form.hours.focus();
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
					action="../doctor/writeDoctor.do" onsubmit="return validateWriteForm(this);">
					<table class="board">
						<tr>
							<td class="left">이름</td>
							<td><input type="text" name="name" /></td>
						</tr>
						<tr>
							<td class="left">전공</td>
							<td><input type="text" name="major" /></td>
						</tr>
						<tr>
							<td class="left">경력</td>
							<td><input type="text" name="career" /></td>
						</tr>
						<tr>
							<td class="left">사진</td>
							<td><input type="text" name="photo" /></td>
						</tr>
						<tr>
							<td class="left">진료 요일 및 시간</td>
							<td><input type="text" name="hours" /></td>
						</tr>
					</table>    
					<div class="board_btn">
						<button type="button" onclick="location.href='../doctor.do';">취소</button>
						<button type="submit">완료</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>










