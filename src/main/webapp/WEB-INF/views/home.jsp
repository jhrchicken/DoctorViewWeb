<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>스프링 부트 프로젝트</h2>
	<ul>
		<li><a href="/">루트</a></li>
	</ul>
	
	<h2>자유게시판</h2>
	<ul>
<!-- 		<li><a href="./freeboard.do">게시판목록</a></li> -->
	</ul>
	
	<h2>회원관리</h2>
	<ul>
		<c:if test="${ empty userId }">
	    	<li><a href="../member/join.do">회원가입</a></li>
			<li><a href="../member/login.do">로그인</a></li>
		</c:if>
		<c:if test="${ not empty userId }">
			<li><a href="../member/logout.do">로그아웃</a></li>
			<p><strong>${ userName }</strong>님</p>
		</c:if>
	</ul>
	
	
	
</body>
</html>