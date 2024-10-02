<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 병원 예약</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/reserve-hosp.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
  <div class="content">
    <div class="content_inner">
      <h2>병원 예약 실패</h2>
      <p>예약에 실패했습니다.</p>
      
      <a href="../../hospital.do">예약할 병원찾기</a>
    
      
    </div>
  </div>
</main>
<%@include file="../common/main_footer.jsp" %>
</body>
</html>