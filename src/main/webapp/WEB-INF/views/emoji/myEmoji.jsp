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
			<h2>나의 이모지</h2>
			<h3>이모지를 변경해보세요</h3>
			<div class="profile">
				<div class="emoji">
					<c:if test="${ not empty sessionScope.loginMember.emoji }">
					    <span>${ sessionScope.loginMember.emoji }</span>
					</c:if>
					<c:if test="${ empty sessionScope.loginMember.emoji }">
					    <p></p>
					</c:if>
				</div>
				<div class="info">
					<div class="name">
						<p>${ sessionScope.loginMember.nickname }</p>
					</div>
					<div class="point">
					<c:if test="${ not empty sessionScope.loginMember.point }">
					    <span>${ sessionScope.loginMember.point } point</span>
					</c:if>
					<c:if test="${ empty sessionScope.loginMember.point }">
					    <span>0 point</span>
					</c:if>
					</div>
					<a class="btn" href="/qnaboard.do">
						<span>이모지 구매하기&nbsp;&nbsp;></span>
					</a>
				</div>
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

<%@ include file="../common/main_footer.jsp" %>
</body>
</html>