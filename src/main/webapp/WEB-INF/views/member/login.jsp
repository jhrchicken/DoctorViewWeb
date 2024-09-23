<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script>
// 	폼값 검증
	function validateForm(form) {
		if (form.id.value == '') {
			alert("아이디를 입력하세요.");
			form.id.focus();
			return false;
		}
		if (form.password.value == '') {
			alert("비밀번호를 입력하세요.");
			form.password.focus();
			return false;
		}

		return true;
	}
</script>
</head>
<body>
	<h2>로그인</h2>
	<form name="loginFrm" method="post" action="../member/login.do" onsubmit="return validateForm(this);">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" value=""/></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" value=""/></td>
		</tr>
	</table>
	<input type="submit" value="로그인"/>
	</form>
</body>
</html>