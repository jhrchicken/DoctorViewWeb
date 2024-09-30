<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header id="header">
	<div class="inner">
		<h1 class="logo">
			<a href="/"><span class="blind">닥터뷰</span></a>
		</h1>
		<nav class="gnb_wrap">
			<ul class="gnb">
				<li>
					<a href="#">병원/의사 찾기</a>
					<div class="depth2">
						<ul>
							<li><a href="${pageContext.request.contextPath}/hospital.do">병원 찾기</a></li>
							<li><a href="${pageContext.request.contextPath}/doctor.do">의사 찾기</a></li>
							<li><a href="#">지도로 찾기</a></li>
						</ul>
					</div>
				</li>
				<li>
					<a href="#">게시판</a>
					<div class="depth2">
						<ul>
							<li><a href="${pageContext.request.contextPath}/freeboard.do">자유게시판</a></li>
							<li><a href="${pageContext.request.contextPath}/qnaboard.do">상담게시판</a></li>
							<li><a href="${pageContext.request.contextPath}/board/bestPost.do">베스트게시판</a></li>
							<li><a href="${pageContext.request.contextPath}/board/myPost.do">내가 쓴 글</a></li>
							<li><a href="${pageContext.request.contextPath}/board/myComment.do">댓글 단 글</a></li>
							<li><a href="${pageContext.request.contextPath}/board/waitComment.do">댓글을 기다리는 글</a></li>
						</ul>
					</div>
				</li>
				<li>
					<a href="#">이모지</a>
					<div class="depth2">
						<ul>
							<li><a href="/myEmoji.do">나의 이모지</a></li>
							<li><a href="/store.do">이모지 상점</a></li>  
						</ul>
					</div>
				</li>
				<li>
					<a href="#">마이페이지</a>
					<div class="depth2">
						<ul>
							<!-- 일반 회원이 로그인한 경우 -->
							<li><a href="${pageContext.request.contextPath}/member/checkMember.do">개인정보 수정</a></li>
							<li><a href="#">예약 관리</a></li>
							<li><a href="${pageContext.request.contextPath}/mypage/myHosp.do">찜한 병원</a></li>
							<li><a href="${pageContext.request.contextPath}/mypage/myDoctor.do">찜한 의사</a></li>
							<li><a href="#">작성한 리뷰</a></li>
							<li><a href="/mypage/attend.do">출석체크</a></li>
							<!-- 일반 회원이 로그인한 경우 -->
							
							<!-- 병원 회원이 로그인한 경우 -->
							<li><a href="#">개인정보 수정</a></li>
							<li><a href="/member/doctorInfo.do">의사 관리</a></li>
							<li><a href="#">예약 관리</a></li>
							<!-- 병원 회원이 로그인한 경우 -->
						</ul>
					</div>
				</li>
			</ul>
		</nav>
		<div class="login_wrap">
			<ul>
				<!-- 로그인 하지 않은 상태 -->
				<c:if test="${ empty sessionScope.userId }">
					<li><a href="${pageContext.request.contextPath}/member/login.do">로그인</a></li>
					<li><a href="${pageContext.request.contextPath}/member/join.do">회원가입</a></li>
				</c:if>
				<!-- 로그인 한 상태 -->
				<c:if test="${ not empty sessionScope.userId }">
					<li><a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></li>
					<li><a href="#">나의 예약</a></li>
				</c:if>
				<div class="btn_wrap">
					<!-- 로그인 하지 않은 상태 -->
					<c:if test="${ empty sessionScope.userId }">
						<img src="${pageContext.request.contextPath}/images/global.svg" alt="아이콘">
					</c:if>
					<!-- 로그인 한 상태 -->
					<c:if test="${ not empty sessionScope.userId }">
						<li><button class="chat_btn" type="button"><span class="blind">채팅</span></button></li>
						<li><button class="my_btn" type="button"><span class="blind">마이</span></button></li>
					</c:if>
				</div>
			</ul>
		</div>
	</div>
	<div class="depth2_color"></div>
</header>