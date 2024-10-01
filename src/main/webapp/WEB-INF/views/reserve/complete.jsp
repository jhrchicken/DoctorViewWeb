<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 예약성공</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/reserve-hosp.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
  <div class="content">
    <div class="content_inner">
      <h2>병원 예약 성공</h2>
      <p>예약성공했습니다</p>
    
		<a href="../../reserve/list.do">예약관리 페이지로 이동</a>
      
    </div>
  </div>
</main>
<%@include file="../common/main_footer.jsp" %>
</body>
</html>