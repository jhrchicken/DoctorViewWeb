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
	
	<!-- 이모지 구매 실패 알림 -->
	<c:if test="${not empty emojiBuyError}">
        <script>
            alert("${emojiBuyError}");
        </script>
    </c:if>
	
	<%@ include file="../common/main_header.jsp" %>
	<main id="container">
	  <div class="content">
	    <div class="content_inner">
	      <div class="login_wrap">
	        <h2>이모지 상점</h2>
	        <p>이모지를 구매해보세욧</p> 
	        <c:if test="${ not empty userId }">
		        <p>${ userEmoji }${ userId }님의 보유 포인트: ${ memberDTO.point }p</p>
	        </c:if>
		    
	        <div class="btn_wrap">
		        <c:forEach items="${ storeDTO }" var="row" varStatus="loop">
			<c:choose>
			    <c:when test="${ not empty userId }">
					<!-- 회원인 경우 : 구매하기버튼 출력-->
			        <form action="/store/buy.do" method="post">
		                <input type="hidden" name="store_idx" value="${ row.store_idx }">
			            <p>${ row.emoji }
			                <input type="hidden" name="emoji" value="${ row.emoji }">
			            </p>
			            <p>${ row.title }
			                <input type="hidden" name="title" value="${ row.title }">
			            </p>
			            <p>${ row.price }
			                <input type="hidden" name="price" value="${ row.price }">p
			            </p>
			            
		 				<!-- 회원이 보유한 이모지인지 확인 -->
		                <c:set var="hasEmoji" value="false"/>
		                <c:forEach items="${ emojiDTO }" var="userEmoji">
		                    <c:if test="${ userEmoji.emoji == row.emoji }">
		                        <c:set var="hasEmoji" value="true"/>
		                    </c:if>
		                </c:forEach>
		
		                <!-- 이모지 보유 여부에 따라 버튼 표시 -->
		                <c:choose>
		                    <c:when test="${ hasEmoji }">
		                        <button type="button" >보유 중</button>
		                    </c:when>
		                    <c:otherwise>
		                        <button type="submit">구매하기</button>
		                    </c:otherwise>
		                </c:choose>
		                
			        </form>
			    </c:when>
			    <c:otherwise>
			    <!-- 회원이 아닌 경우: 구매하기 버튼 클릭 시 로그인 이동 -->
			        <form action="/member/login.do">
			            <p>${ row.emoji }</p>
			            <p>${ row.title }</p>
			            <p>${ row.price }</p>
			            <button type="submit">구매하기</button>
			        </form>
			    </c:otherwise>
			</c:choose>
			</c:forEach>
	        </div>
	        
	      </div>
	    </div>
	  </div>
	</main>
	<%@ include file="../common/main_footer.jsp" %>
</body>
</html>