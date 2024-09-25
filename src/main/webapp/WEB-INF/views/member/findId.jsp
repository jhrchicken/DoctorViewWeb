<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<script>
	function validateForm(form) {
		if (!form.email.value) {
			alert("이메일을 입력하세요.");
			form.email.focus();
			return false;
		}
		if (!form.password.value) {
			alert("비밀번호를 입력하세요.");
			form.password.focus();
			return false;
		}
	}
</script>
</head>
<body>
	${ foundId }
	${ notfountId }
	<h2>아이디찾기</h2>
	<form name="findIdFrm" method="post" action="../member/findId.do" onsubmit="return validateForm(this);">
	<table border="1">
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" /></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password" value=""/></td>
		</tr>
	</table>
	<input type="submit" value="아이디 찾기"/>
	</form>

	
</body>
</html>