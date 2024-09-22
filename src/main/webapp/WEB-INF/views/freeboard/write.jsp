<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	// 자바스크립트에서 폼에 접근하기
	// 방법1 = document.writeFrm.name;
	// 방법2 = document.getElementById("name");
	// 방법3 = document.querySelector("#name");
	// DOM변수.type / name / value
	
	function validateForm(form) {
		if (form.name.value == '') {
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
	<h2>게시판 작성(Mybatis)</h2>
	<form name="writeFrm" method="post"
		action="../freeboard/writePost.do" onsubmit="return validateForm(this);">
	<table border="1" width="90%">
	    <tr>
	        <td>작성자</td>
	        <td>
	            <input type="text" name="writer_idx" style="width:150px;" />
	        </td>
	    </tr>
	    <tr>
	        <td>제목</td>
	        <td>
	            <input type="text" name="title" style="width:90%;" />
	        </td>
	    </tr>
	    <tr>
	        <td>내용</td>
	        <td>
	            <textarea name="content" style="width:90%;height:100px;"></textarea>
	        </td>
	    </tr>
	    <tr>
	        <td colspan="2" align="center">
	            <button type="submit">작성 완료</button>
	            <button type="reset">RESET</button>
	            <button type="button" onclick="location.href='../freeboard.do';">
	                목록 바로가기
	            </button>
	        </td>
	    </tr>
	</table>    
	</form>
</body>
</html>