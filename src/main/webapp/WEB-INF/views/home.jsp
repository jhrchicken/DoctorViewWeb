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
<script src="/js/home.js"></script>
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
							<p>가까운 병원부터 전문 분야에 강점이 있는 의사까지!<br/>쉽고 빠른 검색으로 건강한 일상을 시작하세요</p>
						</div>
						<form class="search_form" name="searchForm" onSubmit="return searchHosp();">
							<select class="search_field" name="searchField">
								<option value="hospital" selected>병원</option>
								<option value="doctor">의사</option>
							</select>
							<input class="search_word" type="text" name="searchWord" placeholder="검색어를 입력해주세요." />
							<input class="search_btn" type="submit" value="" />
						</form>
						<div class="img1"></div>
						<div class="img2"></div>
						<div class="img3"></div>
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
		
		
		
			<!-- 베스트메뉴 섹션 -->
			<section class="best_menu">
				<div class="hd">
					<h2>이달의 BEST</h2>
					<div class="tab">
						<ul>
							<li class="active"><a href="">베스트 병원</a></li>
							<li><a href="">베스트 의사</a></li>
							<li><a href="">베스트 게시글</a></li>
						</ul>
					</div>
				</div>
				<div class="best_menu_wrap">
					<!-- 베스트병원 -->
					<ul>
						<li>
							<a href="">
								<div class="wrap">
									<div class="img">
										<img src="/images/home/test1.jpg" alt="">
									</div>
									<strong>강동경희대학교병원</strong>
									<p>강동경희대학교병원은 강동구 유일한 대학병원으로서, 숙련된 전문 의료진이 항상 환자의 편에서 최상의 의료서비스를 제공하기 위해 노력하고 있습니다</p>
								</div>
							</a>
						</li>
						<li>
							<a href="">
								<div class="wrap">
									<div class="img">
										<img src="/images/home/test2.svg" alt="">
									</div>
									<strong>아주대학교의료원</strong>
									<p>우리는 항상 당신 곁에 있으며, 당신의 아픔을 치유하기 위하여 끊임없이 헌신합니다</p>
								</div>
							</a>
						</li>
						<li>
							<a href="">
								<div class="wrap">
									<div class="img">
										<img src="/images/home/test3.svg" alt="">
									</div>
									<strong>건국대학교병원</strong>
									<p>환자와 직원이 건강한 병원, 건강은 건국!</p>
								</div>
							</a>
						</li>
						<li>
							<a href="">
								<div class="wrap">
									<div class="img">
										<img src="/images/home/test4.jpg" alt="">
									</div>
									<strong>경희의료원</strong>
									<p>‘경희가족정신’ 을 바탕으로 언제나 환자 곁에서, 환자 편에서 생각하고 행동하는 경희의료원</p>
								</div>
							</a>
						</li>
					</ul>
					<!-- 베스트 의사 -->
					<ul>
						<li>
							<a href="">
								<div class="wrap">
									<div class="img">
										<img src="/images/home/test1.jpg" alt="">
									</div>
									<strong>아잠만의사</strong>
									<p>나 최고임</p>
								</div>
							</a>
						</li>
					</ul>
					<!-- 베스트게시글 -->
					<ul>
						<li>
							<a href="">
								<div class="wrap">
									<div class="img">
										<img src="/images/home/test1.jpg" alt="">
									</div>
									<strong>강동경희대학교병원</strong>
									<p>강동경희대학교병원은 강동구 유일한 대학병원으로서, 숙련된 전문 의료진이 항상 환자의 편에서 최상의 의료서비스를 제공하기 위해 노력하고 있습니다</p>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</section>
			
			
			
			<!-- 접근메뉴 섹션 -->
			<section class="contact_menu">
				<div class="content_top">
					<div class="cm1">
						<p>근처 병원을<br/>지도로 빠르게!</p>
						<a class="btn" href="/hospital/map.do">
							<span>지도로 병원 찾기&nbsp;&nbsp;></span>
						</a>
					</div>
					<div class="cm2">
						<p>의료진에게<br/>의료 상담을 받아보세요!</p>
						<a class="btn" href="/qnaboard.do">
							<span>상담게시판 바로가기&nbsp;&nbsp;></span>
						</a>
					</div>
					<div class="cm3">
						<p>새로운 이모지를<br/>만나보세요!</p>
						<a class="btn" href="/store.do">
							<span>이모지상점 바로가기&nbsp;&nbsp;></span>
						</a>
					</div>
				</div>
				<div class="content_bottom">
					<div class="news">
						<div class="hd">
							<h2>신분증 지참 필수</h2>
							<p>병원 접수 및 진료 시<br/>신분증 지참 필수입니다</p>
						</div>
						<div class="news_wrap">
							<p>
								<strong>의료기관 본인확인 의무화</strong><br/>
								국민건강보호법 개정(제12조4항 신설)에 따라 2024년 5월 20일부터 본인확인 의무화 제도 시행<br/><br/>
								<strong>본인 확인 방법</strong><br/>
								신분증 / 모바일 신분증 / 운전면허증 / 건강보험증 / 모바일건강보험증앱 / 여권 등<br/>
								※ 증명서 또는 서류에 유효기간이 적혀있는 경우에는 유효기간이 지나지 않아야 하며 실물 신분증만 가능<br/>
								&nbsp;&nbsp;&nbsp;(사본, 사진으로 찍은 신분증 불가)<br/>
								※ 19세미만, 응급환자 등은 주민등록번호로 본인확인 가능<br/>
								※ 신분증 미지참시 전액본인부담으로 진료받은 후 14일이내 신분증과 진료비 영수증 지참하여 건강보험 적용된 금액으로 정산
							</p>
						</div>
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