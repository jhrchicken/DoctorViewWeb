<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 이모지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/emoji-my.css" />
</head>
<body>
<%@ include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
    	<div class="content_inner">
    		
    		<h2>나의 이모지</h2>
        	<div class="user_wrap">
		        <!-- user 정보 및 상점이동 -->
		        <div class="user">
				    <p class="user_emoji">${ userEmoji }</p>
				    <div class="user_info">
					    <div class="user_name">
				        	<p>${ userId }님</p>
					    </div>
					    <div class="user_point">
					    	<p>보유 포인트</p>
							<c:if test="${ not empty memberDTO.point }">
							    <p class="point">${ memberDTO.point }</p>
							</c:if>
							<c:if test="${ empty memberDTO.point }">
							    <p class="point">0</p>
							</c:if>
					    </div>
					    <a href="/store.do">상점으로<br />이동</a>
				    </div>
		    	</div>
        	</div>
			 
			
			<h3>보유 이모티콘</h3>
		    <!-- 보유한 이모지 목록 -->
	        <div class="my_emoji">
		        <c:forEach items="${ emojiDTO }" var="row" varStatus="loop">
					<div class="have">
						<form action="/emoji/editEmoji.do" method="post">
						    <input type="hidden" name="emoji_idx" value="${ row.emoji_idx }" />
						    <input type="hidden" name="user_ref" value="${ row.user_ref }" />
						    <input type="hidden" name="emoji" value="${ row.emoji }" />
						    <input type="hidden" name="title" value="${ row.title }" />
						    <input type="hidden" name="use_emoji" value="${ row.use_emoji }" />
						    
						    <div class="emoji">
							    <p>${ row.emoji }</p>
						    </div>
						    <div class="emoji_name">
						 	    <p>- ${ row.title } -</p>
						    </div>
						    <div class="emoji_btn">
							    <!-- 현재 활성화 상태 이모지 -->
							    <c:if test="${ row.use_emoji == 'T' }">
								    <button class="used" type="button">사용중</button>
						        </c:if>
						        <!-- 현재 비활성화 상태 이모지 -->
						        <c:if test="${ row.use_emoji == 'F' }">
								    <button type="submit">사용하기</button>
						        </c:if>
						    </div>
						</form>
					</div>
				</c:forEach>
        	</div>
      	</div>
    </div>
</main>

<%@ include file="../common/main_footer.jsp" %>
</body>
</html>