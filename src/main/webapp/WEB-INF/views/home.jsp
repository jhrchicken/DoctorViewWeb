<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="common/head.jsp" %>
<link rel="stylesheet" href="/css/home.css" />
<script src="/js/freeboard.js"></script>
</head>
<body>

<!-- 회원탈퇴 알림 -->
<c:if test="${ not empty withdraw }">
	<script>
		alert("${withdraw}");
	</script>
</c:if>

<%@include file="common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
		
			<!-- 병원/의사 찾기 섹션 -->
			<div class="search">
				<div class="search_wrap">
					<div class="search_form_wrap">
						<div class="title">
							<p class="tip">병원과 의사를 검색해보세요</p>
							<p>검색 결과는 좋아요 순으로 출력됩니다. (이거 문구랑 디자인 변경하기)</p>
						</div>
						<form class="search_form" name="searchForm" onSubmit="return searchHosp();">
							<select class="search_field" name="searchField">
								<option value="hospital" selected>병원</option>
								<option value="doctor">의사</option>
							</select>
							<input class="search_word" type="text" name="searchWord" placeholder="검색어를 입력해주세요." />
							<input class="search_btn" type="submit" value="" />
						</form>
					</div>
				</div>
				<div class="quick_link">
					<div class="quick_link_content">
						<div class="hospital">
							<a href="/hospital.do">
								<strong>병원찾기</strong>
							</a>
						</div>
						<div class="doctor">
							<a href="/doctor.do">
								<strong>의사찾기</strong>
							</a>
						</div>
					</div>
				</div>
			</div>
			
			
			<!-- 해시태그 섹션 -->
<!-- 			<section class="tag">
			
			
			</section> -->
		
		
			<!-- 바로가기 섹션 -->
			<section class="shortcut_menu">
				<div class="title">
					<h2>바로가기</h2>
				</div>
				<div class="shortcut_menu_wrap">
					<ul>
						<li>
							<a href="/hospital/map.do">
								<div class="wrap">
									<div class="img">
										<img src="/images/sandwich.jpg" alt="">
									</div>
									<strong>서울병원</strong>
									<p>근처 병원을 지도로 빠르게<br/>검색하세요</p>
								</div>
							</a>
						</li>
						<li>
							<a href="/freeboard.do">
								<div class="wrap">
									<div class="img">
										<img src="/images/sandwich.jpg" alt="">
									</div>
									<strong>자유게시판</strong>
									<p>자유게시판에서 자유롭게<br/>소통하세요</p>
								</div>
							</a>
						</li>
						<li>
							<a href="/qnaboard.do">
								<div class="wrap">
									<div class="img">
										<img src="/images/sandwich.jpg" alt="">
									</div>
									<strong>상담게시판</strong>
									<p>상담게시판에서 의료진에게<br/>의료 정보를 물어보세요</p>
								</div>
							</a>
						</li>
						<li>
							<a href="/myEmoji.do">
								<div class="wrap">
									<div class="img">
										<img src="/images/sandwich.jpg" alt="">
									</div>
									<strong>이모지 상점</strong>
									<p>귀엽고 멋진 이모지로<br/>닉네임을 꾸며보세요</p>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</section>
			
			
			
			
			<section class="notice">
				<div class="notice_wrap">
					<div class="news">
						<h2>2024년 5월 20일부터 병원 접수, 진료 시 신분증 지참 필수입니다!</h2>
						<strong>[의료기관 본인확인 의무화]</strong>
						<p>국민건강보호법 개정(제12조4항 신설)에 따라 2024년 5월 20일부터 본인확인 의무화 제도 시행</p>
						<br />
						<strong>[본인 확인 방법]</strong>
						<p>신분증 / 모바일 신분증 / 운전면허증 / 건강보험증 / 모바일건강보험증앱 / 여권 등
						<br />
						※ 증명서 또는 서류에 유효기간이 적혀있는 경우에는 유효기간이 지나지 않아야 하며 실물 신분증만 가능 <span>(사본, 사진으로 찍은 신분증 불가)</span>
						<br />
						※ 19세미만, 응급환자 등은 주민등록번호로 본인확인 가능
						<br />
						※ 신분증 미지참시 전액본인부담으로 진료받은 후 14일이내 신분증과 진료비영수증
						<br />
						지참하여 건강보험 적용된 금액으로 정산</p>
						</div>
				</div>
			</section>
			
			
			
			<!-- 퀵 메뉴 -->
			<section class="quick_menu">
				<ul>
					<li class="qm1">
						<a href="">
							<div class="icon"></div>
							<strong>프랜차이즈</strong>
							<span>개설절차/투자비용 정보</span>
						</a>
					</li>
					<li class="qm2">
						<a href="">
							<div class="icon"></div>
							<strong>지사안내</strong>
							<span>수도권/지방 지사정보</span>
						</a>
					</li>
					<li class="qm3">
						<a href="">
							<div class="icon"></div>
							<strong>광고영상</strong>
							<span>TV광고/동영상</span>
						</a>
					</li>
					<li class="qm4">
						<a href="">
							<div class="icon"></div>
							<strong>고객문의</strong>
							<span>자주하는 질문/1:1문의</span>
						</a>
					</li>
				
				</ul>
			</section>

		</div>
	</div>
</main>
<%@include file="common/main_footer.jsp" %>
</body>
</html>