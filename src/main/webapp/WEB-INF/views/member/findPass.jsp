<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<script>
	function validateForm(form) {
		if (!form.id.value) {
			alert("아이디를 입력하세요.");
			form.id.focus();
			return false;
		}
		if (!form.email.value) {
			alert("이메일을 입력하세요.");
			form.email.focus();
			return false;
		}
	}
</script>
</head>
<body>
	${ passInfo }
	${ notfountPass }
	<h2>비밀번호찾기</h2>
	<form name="findPassFrm" method="post" action="../member/findPass.do" onsubmit="return validateForm(this);">
		<table border="1">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id" /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="email" name="email" value=""/></td>
			</tr>
		</table>
		<input type="submit" value="비밀번호 찾기"/>
	</form>
	
</body>
</html>