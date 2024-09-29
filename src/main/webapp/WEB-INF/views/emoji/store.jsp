<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이모지 상점</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/member-join.css" />
</head>
<body>
	<%@ include file="../common/main_header.jsp" %>
	<main id="container">
	  <div class="content">
	    <div class="content_inner">
	      <div class="login_wrap">
	        <h2>이모지 상점</h2>
	        <p>이모지를 구매해보세욧</p>
	        
			<!--     emoji 출력  -->
			<c:forEach items="${ storeDTO }" var="row" varStatus="loop">
			<c:choose>
			    <c:when test="${ not empty userId }">
				<!-- 회원인 경우 : 구매하기 -->
			        <form action="/store/buy.do" method="post">
			            <p>${ row.store_idx }
			                <input type="hidden" name="store_idx" value="${ row.store_idx }">
			            </p>
			            <p>${ row.emoji }
			                <input type="hidden" name="emoji" value="${ row.emoji }">
			            </p>
			            <p>${ row.title }
			                <input type="hidden" name="title" value="${ row.title }">
			            </p>
			            <p>${ row.price }
			                <input type="hidden" name="price" value="${ row.price }">
			            </p>
			            <button type="submit">구매하기</button>
			        </form>
			    </c:when>
			    <c:otherwise>
			    <!-- 회원이 아닌 경우 : 로그인페이지로 이동 -->
			        <form action="/member/login.do">
			            <p>${ row.store_idx }</p>
			            <p>${ row.emoji }</p>
			            <p>${ row.title }</p>
			            <p>${ row.price }</p>
			            <button type="submit">구매하기</button>
			        </form>
			    </c:otherwise>
			</c:choose>
			<p>===============================================================</p>
			</c:forEach>
	        
	        
	        
	        
		
	      </div>
	    </div>
	  </div>
	</main>
	<%@ include file="../common/main_footer.jsp" %>
</body>
</html>