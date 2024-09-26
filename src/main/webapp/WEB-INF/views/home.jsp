<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="common/head.jsp" %>
<script>
function chat(user_id, hosp_id) {
	window.open('/chat/index.html#/chat/talk?room=' + hosp_id + ' - ' + user_id + '&user=' + user_id,
			hosp_id + '-' + user_id, 'width=500, height=650')
}
</script>
</head>
<body>
	<%@include file="common/main_header.jsp" %>
	
	<!-- 채팅 -->
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<a href="javascript:chat('harim', 'hospital1');">채팅방 열기</a>
	
	
	 
	<%@include file="common/main_footer.jsp" %>
</body>
</html>