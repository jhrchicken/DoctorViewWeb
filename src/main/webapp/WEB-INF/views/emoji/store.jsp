<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 이모지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/emoji-store.css" />
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
    	
    	<h2>나의 정보</h2>
        <c:if test="${ not empty userId }">
	        <!-- user 정보 및 상점이동 -->
	        <div class="user">
	        	<c:if test="${ empty emojiDTO }">
	        		<p class="now_emoji none">없음</p>
	        	</c:if>
	        	<c:if test="${ not empty emojiDTO }">
				    <p class="now_emoji user_emoji">${ userEmoji }</p>
	        	</c:if>
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
				    <a href="/myEmoji.do">나의 이모지<br />확인</a>
			    </div>
	    	</div>
        </c:if>
        <c:if test="${ empty userId }">
        	<div class="user">
        		<p class="no_login">로그인 후 이용해주세요.</p>
        	</div>
        </c:if>
	    
	    <h2>이모지 상점</h2>
        <div class="my_emoji">
	        <c:forEach items="${ storeDTO }" var="row" varStatus="loop">
				<c:choose>
		    		<c:when test="${ not empty userId }">
		    			<div class="have">
							<!-- 회원인 경우 : 구매하기 버튼 출력-->
					        <form action="/store/buy.do" method="post">
				                <input type="hidden" name="store_idx" value="${ row.store_idx }">
					            
					            <div class="emoji">
						            <p>
						            	${ row.emoji }
						                <input type="hidden" name="emoji" value="${ row.emoji }">
						            </p>
					            </div>
					            <div class="emoji_name">
						            <p>
						            	- ${ row.title } -
						                <input type="hidden" name="title" value="${ row.title }">
						            </p>
					            </div>
					            <div class="price">
						            <p>
						            	${ row.price }
						                <input type="hidden" name="price" value="${ row.price }">p
						            </p>
					            </div>
					            
				 				<!-- 회원이 보유한 이모지인지 확인 -->
				                <c:set var="hasEmoji" value="false"/>
				                <c:forEach items="${ emojiDTO }" var="userEmoji">
				                    <c:if test="${ userEmoji.emoji == row.emoji }">
				                        <c:set var="hasEmoji" value="true"/>
				                    </c:if>
				                </c:forEach>
				
								<div class="emoji_btn">
					                <!-- 이모지 보유 여부에 따라 버튼 표시 -->
					                <c:choose>
					                    <c:when test="${ hasEmoji }">
					                        <button class="used" type="button" >보유 중</button>
					                    </c:when>
					                    <c:otherwise>
					                        <button type="submit">구매하기</button>
					                    </c:otherwise>
					                </c:choose>
								</div>
					        </form>
		    			</div>
		    		</c:when>
		    		<c:otherwise>
		    			<div class="have">
		    				<!-- 회원이 아닌 경우: 구매하기 버튼 클릭 시 로그인 이동 -->
			        		<form action="/member/login.do">
			        			<div class="emoji">
						            <p>${ row.emoji }</p>
			        			</div>
			        			<div class="emoji_name">
						            <p>- ${ row.title } -</p>
			        			</div>
			        			<div class="price">
						            <p>${ row.price }</p>
			        			</div>
			        			<div class="emoji_btn">
						            <button type="submit">구매하기</button>
			        			</div>
					        </form>
		    			</div>
		    		</c:otherwise>
				</c:choose>
			</c:forEach>
        </div>
    </div>
  </div>
</main>

<%@ include file="../common/main_footer.jsp" %>
</body>
</html>