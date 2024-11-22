<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/emoji-my.css" />


</head>
<body>
<%@ include file="../common/main_header.jsp" %>



<main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="user_info">
				<h2>이모지 상점</h2>
					<p>
						<c:if test="${ not empty sessionScope.loginMember }">
							<span>${ sessionScope.loginMember.nickname } ${ sessionScope.loginMember.emoji }</span> 님의 포인트는 
							<c:if test="${ not empty sessionScope.loginMember.point }">
							    <span>${ sessionScope.loginMember.point } point</span>
							</c:if>
							<c:if test="${ empty sessionScope.loginMember.point }">
							    <span>0 point</span>
							</c:if>
							입니다.<br/>
						</c:if>
						<c:if test="${ empty sessionScope.loginMember }">
							<p>로그인 후 이용 가능합니다</p>
						</c:if>
						포인트로 귀여운 이모지를 구매해보세요!
					</p>
			</div>
			
			<div class="emoji_list">
				<ul>
					<c:forEach items="${ emojiList }" var="row" varStatus="loop">
						<li>
							<form action="/emoji/editEmoji.do" method="post">
						    
								<div class="emoji">
									<p>${ row.emoji }</p>
									<input type="hidden" name="emoji" value="${ row.emoji }">
								</div>
								<div class="tit">
									<strong>${ row.title }</strong>
								</div>
								<span class="sub">${ row.descr }</span>
								<div class="price">
									<span>${ row.price } point</span>
								</div>
								<div class="emoji_btn">
					                <!-- 이모지 사용 여부에 따라 버튼 표시 -->
					                <c:choose>
					                    <c:when test="${ row.emoji == sessionScope.loginMember.emoji }">
					                        <button type="submit" class="used_btn"><span>해제하기</span></button>
					                        <input type="hidden" name="state" value="disable">
					                    </c:when>
					                    <c:otherwise>
					                        <button type="submit" class="change_btn"><span>사용하기</span></button>
					                        <input type="hidden" name="state" value="enable">
					                    </c:otherwise>
					                </c:choose>
								</div>
							</form>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</main>








<%-- <main id="container">

	<div class="content">
    	<div class="content_inner">
    		
    		<h2>나의 이모지</h2>
	        <!-- user 정보 및 상점이동 -->
	        <div class="user">
				<p class="now_emoji user_emoji">${ userEmoji }</p>
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
			    </div>
			    <a href="/store.do">상점으로<br />이동</a>
	    	</div>
			 
			
			<h2>보유 이모티콘</h2>
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
</main> --%>

<%@ include file="../common/main_footer.jsp" %>
</body>
</html>