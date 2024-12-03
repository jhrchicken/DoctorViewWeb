<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="./head.jsp" %>
<link rel="stylesheet" href="/css/release.css" />
</head>
<body>
	<%@include file="./main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="hd">
				<h2>닥터뷰 릴리즈 노트</h2>
				<p>다음 릴리즈 노트는 어쩌구 <br/>더 자세한 어쩌구</p>
			</div>
			
			<div class="release">
				<!--v1.0.0 -->
				 <h2 class="version">v1.0.0</h2>
				 <strong class="date">October 23, 2024</strong>
				 <div class="new">
				 	<p>
				 		<strong>최초 배포</strong><br/>
				 		지역기반 의료시스템 매칭 플랫폼 닥터뷰 최초 배포
				 	</p>
				 </div>
				 
				 <!--v1.0.1 -->
				 <h2 class="version">v1.0.1</h2>
				 <strong class="date">November 11, 2024</strong>
				 <div class="fixed">
				 	<p>
				 		<strong>게시판 댓글 작성 버그 수정 및 성능 개선</strong><br/>
				 		게시판 첫 댓글 작성 시 문구가 잘못 표시되는 에러를 수정하였습니다.<br/>
				 		또한 게시판에 댓글을 작성하고 새로고침 후 정렬 순서가 역순으로 변경되는 에러를 수정하였습니다.
				 	</p>
				 	<p>
				 		<strong>게시판 댓글 수정/삭제 버그 수정 및 성능 개선</strong><br/>
				 		게시판 마지막 댓글 삭제 시 문구가 잘못 표시되는 에러를 수정하였습니다<br/>
				 		게시판에 댓글을 작성한 후 새로고침 이전에 수정/삭제 시 발생하는 에러를 수정하였습니다.
				 	</p>
				 	<p>
				 		<strong>게시판 좋아요/신고 버그 수정</strong><br/>
				 		게시판에서 좋아요와 신고가 중복으로 선택되는 버그를 수정하였습니다. 좋아요 선택 시 신고는 해제되고, 반대의 경우도 동일하게 동작합니다.
				 	</p>
				 </div>
				 
				 <!--v1.1.0 -->
				 <h2 class="version">v1.1.0</h2>
				 <strong class="date">November 18, 2024</strong>
				 <div class="changed">
				 	<p>
				 		<strong>메인페이지 디자인 전면 수정</strong><br/>
				 		메인페이지의 메인베너, 기능 바로가기 메뉴, 신분증 지참 알림, 퀵메뉴의 디자인을 수정하였습니다.
				 	</p>
				 	<p>
				 		<strong>푸터 디자인 및 문구 수정</strong><br/>
				 		푸터의 디자인을 변경하고, 디자인 출처를 명확하게 표기하였습니다.
				 	</p>
				 </div>
				 <div class="feature">
				 	<p>
				 		<strong>메인페이지 베스트메뉴 기능 추가</strong><br/>
				 		~~~
				 	</p>
				 </div>
				 
				 <!--v1.2.0 -->
				 <h2 class="version">v1.2.0</h2>
				 <strong class="date">November 22, 2024</strong>
				 <div class="fixed">
				 	<p>
				 		<strong>이모지 해제 버그 수정 및 성능 개선</strong><br/>
				 		이모지 설정 후에 이모지를 해제할 수 없는 버그를 수정하였습니다.
				 	</p>
				 </div>
				 <div class="feature">
				 	<p>
				 		<strong>이모지 상점 라벨 기능 추가</strong><br/>
				 		이모지에 라벨을 표시하고 라벨로 구분할 수 있는 기능을 추가하였습니다.
				 	</p>
				 	<p>
				 		<strong>이모지 상점 설명 표시 기능 추가</strong><br/>
				 		이모지에 설명을 추가하였습니다.
				 	</p>
				 </div>
				 <div class="changed">
				 	<p>
				 		<strong>이모지 상점 디자인 전면 수정</strong><br/>
				 		이모지 상점의 디자인을 전면 수정하였습니다.
				 	</p>
				 </div>
				 
				 <!--v1.3.0 -->
				 <h2 class="version">v1.3.0</h2>
				 <strong class="date">November 29, 2024</strong>
				 <div class="feature">
				 	<p>
				 		<strong>마이페이지 예약 내역 진행상태 구분 기능 추가</strong><br/>
				 		마이페이지의 예약 내역에서 선택한 진행 상태에 따른 예약 내역만 확인할 수 있는 기능을 추가하였습니다.
				 	</p>
				 </div>
				 <div class="changed">
				 	<p>
				 		<strong>마이페이지 예약 내역 디자인 전면 수정</strong><br/>
				 		마이페이지의 예약 내역 디자인을 전면 수정하였습니다.
				 	</p>
				 </div>
				 
				 <!--v1.3.1 -->
				 <h2 class="version">v1.3.1</h2>
				 <strong class="date">December 2, 2024</strong>
				 <div class="fixed">
				 	<p>
				 		<strong>마이페이지 예약 내역 버그 수정 및 성능 개선</strong><br/>
				 		이미 완료된 예약을 취소할 수 있는 버그를 수정하였습니다.
				 	</p>
				 </div>
				 <div class="changed">
				 	<p>
				 		<strong>마이페이지 예약 내역 순서 변경</strong><br/>
				 		예약 내역 순서를 변경하였습니다. 가장 최근 예약이 최상단에 표시됩니다.
				 	</p>
				 	<p>
				 		<strong>마이페이지 예약 내역 주민등록번호 마스킹 처리</strong><br/>
				 		주민등록번호의 뒷 번호가 노출되지 않도록 마스킹 처리하였습니다.
				 	</p>
				 	<p>
				 		<strong>마이페이지 예약 내역 메모 작성 성능 개선</strong><br/>
				 		예약 내역의 메모 작성 방식을 모달창으로 변경하였습니다.
				 	</p>
				 </div>
			</div>
		</div>
	</main>
	<%@include file="./main_footer.jsp" %>
</body>
</html>