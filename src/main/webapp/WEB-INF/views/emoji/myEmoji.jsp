<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 이모지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/member-join.css" />
</head>
<body>
	<%@ include file="../common/main_header.jsp" %>
	<main id="container">
	  <div class="content">
	    <div class="content_inner">
	      <div class="login_wrap">
	        <h2>나의 이모지</h2>
	        
	        <!-- user 정보 및 상점이동 -->
	        <div class="btn_wrap">
			    <p>${ userEmoji } ${ userId }님</p>
			    <a href="/store.do">상점으로 이동</a>
		    </div>
		    
		    <!-- 보유한 이모지 목록 -->
	        <div class="btn_wrap">
		        <c:forEach items="${ emojiDTO }" var="row" varStatus="loop">
					<form action="/emoji/editEmoji.do" method="post">
					    <input type="hidden" name="emoji_idx" value="${ row.emoji_idx }" />
					    <input type="hidden" name="user_ref" value="${ row.user_ref }" />
					    <input type="hidden" name="emoji" value="${ row.emoji }" />
					    <input type="hidden" name="title" value="${ row.title }" />
					    <input type="hidden" name="use_emoji" value="${ row.use_emoji }" />
					    <p>${ row.user_ref }</p>
					    <p>${ row.emoji }</p>
					    <p>${ row.title }</p>
					    <!-- 현재 활성화 상태 이모지 -->
					    <c:if test="${ row.use_emoji == 'T' }">
						    <button type="button">사용중</button>
				        </c:if>
				        <!-- 현재 비활성화 상태 이모지 -->
				        <c:if test="${ row.use_emoji == 'F' }">
						    <button type="submit">사용하기</button>
				        </c:if>
					</form>
				</c:forEach>
	        </div>
	        
	      </div>
	    </div>
	  </div>
	</main>
	<%@ include file="../common/main_footer.jsp" %>
</body>
</html>