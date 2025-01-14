<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-reserve.css" />
<script src="/js/my-reserve.js"></script>
</head>

<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<h2>예약 내역</h2>
			<section class="reserve_history">
				<div class="tab">
					<ul>
						<li class="active"><a href="">전체</a></li>
						<li><a href="">다가오는 예약</a></li>
						<li><a href="">완료된 예약</a></li>
						<li><a href="">취소된 예약</a></li>
					</ul>
				</div>
				
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" var="currentDate"/>
						
				<!-- 전체 -->
				<div class="tab_content">
					<c:forEach items="${ reserveList }" var="row" varStatus="loop">
						<!-- user 회원 화면-->
						<c:if test="${ userAuth eq 'ROLE_USER' }">
							<c:if test="${ row.hide eq 'F' }">
								<form name="cancelReservationForm_${row.app_id}">
									<input type="hidden" name="app_id" value="${ row.app_id }" />
								</form>
								<form name="hideReservationForm_${row.app_id}">
									<input type="hidden" name="app_id" value="${ row.app_id }" />
								</form>
								
								<!-- 예약정보 -->
								<c:set var="reserveDate" value="${row.postdate} ${row.posttime}" />
								<div class="reserve">
									<div class="info">
										<div class="top">
											<h2>${ row.hospname }</h2>
											<div class="btn_wrap">
												<c:if test="${ row.cancel eq 'F' and reserveDate gt currentDate }">
													<a class="hide_btn" href="javascript:void(0);" onclick="cancelReservation(${ row.app_id });"><span>예약 취소</span></a>
												</c:if>
												<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
													<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
												</c:if>
												<c:if test="${ row.cancel eq 'T' }">
													<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
												</c:if>
												<a class="hide_btn" href="javascript:void(0);" onclick="hideReservation(${row.app_id});"><span>예약 숨김</span></a>
											</div>
										</div>
										<div class="bottom">
											<dl>
												<dt>예약일</dt>
												<dd>${ row.postdate } ${ row.posttime }</dd>
												<dt>담당의</dt>
												<dd>${ row.doctorname }</dd>
											</dl>
											<dl>
												<dt>예약자 이름</dt>
												<dd>${ row.username }</dd>
												<dt>전화번호</dt>
												<dd>${ row.tel }</dd>
											</dl>
											<dl>
												<dt>주민등록번호</dt>
												<dd>${ row.rrn }</dd>
												<dt>주소</dt>
												<dd>${ row.address }</dd>
											</dl>
											<dl>
												<dt>메모</dt>
												<dd class="memo_dd">
													<div class="memo">
														<c:if test="${ empty row.user_memo }">
															<span>-</span>
						        						</c:if>
														<c:if test="${ not empty row.user_memo }">
															<span>${ row.user_memo }</span>
						        						</c:if>
														<div class="memo_btn">
															<button type="button" data-bs-toggle="modal" data-bs-target="#memoModal"
																onclick="openMemoModal(${ row.app_id }, '${ row.user_memo }')">
																<span>메모변경</span>
															</button>
														</div>
													</div>
												</dd>
											</dl>
										</div>
									</div>
								</div>
							</c:if>
						</c:if>
					</c:forEach>
				</div>
				
				<!-- 다가오는 예약 -->
				<div class="tab_content">
					<c:forEach items="${ reserveList }" var="row" varStatus="loop">
						<!-- user 회원 화면-->
						<c:if test="${ userAuth eq 'ROLE_USER' }">
							<c:if test="${ row.hide eq 'F' }">
								<form name="cancelReservationForm_${row.app_id}">
									<input type="hidden" name="app_id" value="${ row.app_id }" />
								</form>
								<form name="hideReservationForm_${row.app_id}">
									<input type="hidden" name="app_id" value="${ row.app_id }" />
								</form>
								
								<!-- 예약정보 -->
	            				<c:set var="reserveDate" value="${row.postdate} ${row.posttime}" />
	            				<c:if test="${(reserveDate gt currentDate) and row.cancel eq 'F'}">
									<div class="reserve">
										<div class="info">
											<div class="top">
												<h2>${ row.hospname }</h2>
												<div class="btn_wrap">
													<c:if test="${ row.cancel eq 'F' and reserveDate gt currentDate }">
														<a class="hide_btn" href="javascript:void(0);" onclick="cancelReservation(${ row.app_id });"><span>예약 취소</span></a>
													</c:if>
													<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
														<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
													</c:if>
													<c:if test="${ row.cancel eq 'T' }">
														<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
													</c:if>
													<a class="hide_btn" href="javascript:void(0);" onclick="hideReservation(${row.app_id});"><span>예약 숨김</span></a>
												</div>
											</div>
											<div class="bottom">
												<dl>
													<dt>예약일</dt>
													<dd>${ row.postdate } ${ row.posttime }</dd>
													<dt>담당의</dt>
													<dd>${ row.doctorname }</dd>
												</dl>
												<dl>
													<dt>예약자 이름</dt>
													<dd>${ row.username }</dd>
													<dt>전화번호</dt>
													<dd>${ row.tel }</dd>
												</dl>
												<dl>
													<dt>주민등록번호</dt>
													<dd>${ row.rrn }</dd>
													<dt>주소</dt>
													<dd>${ row.address }</dd>
												</dl>
												<dl>
													<dt>메모</dt>
													<dd class="memo_dd">
														<div class="memo">
															<c:if test="${ empty row.user_memo }">
																<span>-</span>
							        						</c:if>
															<c:if test="${ not empty row.user_memo }">
																<span>${ row.user_memo }</span>
							        						</c:if>
															<div class="memo_btn">
																<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">
																	<span>메모변경</span>
																</button>
															</div>
														</div>
													</dd>
												</dl>
											</div>
										</div>
									</div>
								</c:if>
							</c:if>
						</c:if>
					</c:forEach>
				</div>
				
				<!-- 완료된 예약 -->
				<div class="tab_content">
					<c:forEach items="${ reserveList }" var="row" varStatus="loop">
						<!-- user 회원 화면-->
						<c:if test="${ userAuth eq 'ROLE_USER' }">
							<c:if test="${ row.hide eq 'F' }">
								<form name="cancelReservationForm_${row.app_id}">
									<input type="hidden" name="app_id" value="${ row.app_id }" />
								</form>
								<form name="hideReservationForm_${row.app_id}">
									<input type="hidden" name="app_id" value="${ row.app_id }" />
								</form>
								
								<!-- 예약정보 -->
								<c:set var="reserveDate" value="${row.postdate} ${row.posttime}" />
	            				<c:if test="${reserveDate lt currentDate and row.cancel eq 'F'}">
									<div class="reserve">
										<div class="info">
											<div class="top">
												<h2>${ row.hospname }</h2>
												<div class="btn_wrap">
													<c:if test="${ row.cancel eq 'F' and reserveDate gt currentDate }">
														<a class="hide_btn" href="javascript:void(0);" onclick="cancelReservation(${ row.app_id });"><span>예약 취소</span></a>
													</c:if>
													<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
														<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
													</c:if>
													<c:if test="${ row.cancel eq 'T' }">
														<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
													</c:if>
													<a class="hide_btn" href="javascript:void(0);" onclick="hideReservation(${row.app_id});"><span>예약 숨김</span></a>
												</div>
											</div>
											<div class="bottom">
												<dl>
													<dt>예약일</dt>
													<dd>${ row.postdate } ${ row.posttime }</dd>
													<dt>담당의</dt>
													<dd>${ row.doctorname }</dd>
												</dl>
												<dl>
													<dt>예약자 이름</dt>
													<dd>${ row.username }</dd>
													<dt>전화번호</dt>
													<dd>${ row.tel }</dd>
												</dl>
												<dl>
													<dt>주민등록번호</dt>
													<dd>${ row.rrn }</dd>
													<dt>주소</dt>
													<dd>${ row.address }</dd>
												</dl>
												<dl>
													<dt>메모</dt>
													<dd class="memo_dd">
														<div class="memo">
															<c:if test="${ empty row.user_memo }">
																<span>-</span>
							        						</c:if>
															<c:if test="${ not empty row.user_memo }">
																<span>${ row.user_memo }</span>
							        						</c:if>
															<div class="memo_btn">
																<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">
																	<span>메모변경</span>
																</button>
															</div>
														</div>
													</dd>
												</dl>
											</div>
										</div>
									</div>
								</c:if>
							</c:if>
						</c:if>
					</c:forEach>
				</div>
				
				<!-- 취소된 예약 -->
				<div class="tab_content">
					<c:forEach items="${ reserveList }" var="row" varStatus="loop">
						<!-- user 회원 화면-->
						<c:if test="${ userAuth eq 'ROLE_USER' }">
							<c:if test="${ row.hide eq 'F' }">
								<form name="cancelReservationForm_${row.app_id}">
									<input type="hidden" name="app_id" value="${ row.app_id }" />
								</form>
								<form name="hideReservationForm_${row.app_id}">
									<input type="hidden" name="app_id" value="${ row.app_id }" />
								</form>
								
								<!-- 예약정보 -->
	            				<c:if test="${row.cancel eq 'T'}">
									<div class="reserve">
										<div class="info">
											<div class="top">
												<h2>${ row.hospname }</h2>
												<div class="btn_wrap">
													<c:if test="${ row.cancel eq 'F' and reserveDate gt currentDate }">
														<a class="hide_btn" href="javascript:void(0);" onclick="cancelReservation(${ row.app_id });"><span>예약 취소</span></a>
													</c:if>
													<c:if test="${ row.cancel eq 'F' and reserveDate lt currentDate }">
														<a class="done_btn" href="javascript:void(0);"><span>완료된 예약</span></a>
													</c:if>
													<c:if test="${ row.cancel eq 'T' }">
														<a class="cancel_btn" href="javascript:void(0);"><span>취소된 예약</span></a>
													</c:if>
													<a class="hide_btn" href="javascript:void(0);" onclick="hideReservation(${row.app_id});"><span>예약 숨김</span></a>
												</div>
											</div>
											<div class="bottom">
												<dl>
													<dt>예약일</dt>
													<dd>${ row.postdate } ${ row.posttime }</dd>
													<dt>담당의</dt>
													<dd>${ row.doctorname }</dd>
												</dl>
												<dl>
													<dt>예약자 이름</dt>
													<dd>${ row.username }</dd>
													<dt>전화번호</dt>
													<dd>${ row.tel }</dd>
												</dl>
												<dl>
													<dt>주민등록번호</dt>
													<dd>${ row.rrn }</dd>
													<dt>주소</dt>
													<dd>${ row.address }</dd>
												</dl>
												<dl>
													<dt>메모</dt>
													<dd class="memo_dd">
														<div class="memo">
															<c:if test="${ empty row.user_memo }">
																<span>-</span>
							        						</c:if>
															<c:if test="${ not empty row.user_memo }">
																<span>${ row.user_memo }</span>
							        						</c:if>
															<div class="memo_btn">
																<button type="button" data-bs-toggle="modal" data-bs-target="#memoModal"
																	onclick="openMemoModal(${ row.app_id }, '${ row.user_memo }')">
																	<span>메모변경</span>
																</button>
																<%-- <button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">
																	<span>메모변경</span>
																</button> --%>
															</div>
														</div>
													</dd>
												</dl>
											</div>
										</div>
									</div>
								</c:if>
							</c:if>
						</c:if>
					</c:forEach>
				</div>
			</section>
		</div>
	</main>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<%-- 
	<main id="container">
		<div class="content">
			<div class="content_inner">
			<h2>예약 목록</h2>
				
				
				
				
	<div class="my_doctor">
	<c:choose>
		<c:when test="${ empty reserveInfo }">
			<div class="none">
				<p>예약 정보가 없습니다.</p>
			</div>
		</c:when>
		<c:otherwise>
			<ul class="doctor">
				<c:forEach items="${ reserveInfo }" var="row" varStatus="loop">
					
					<!-- user 회원 화면-->
					<c:if test="${ userAuth eq 'ROLE_USER' }">
						<c:if test="${ row.hide eq 'F' }">
						
						<li>
						
							<form name="cancelReservationForm_${row.app_id}">
								<input type="hidden" name="app_id" value="${ row.app_id }" />
							</form>
							<form name="hideReservationForm_${row.app_id}">
								<input type="hidden" name="app_id" value="${ row.app_id }" />
							</form>
							
							<div class="info">
								<div class="info_top">
									<h3>${ row.hospname }</h3>
									
									<div class="detail_content">
										<div class="detail">
											<div class="details">
												<p class="blue">예약 의사</p>
												<p>${ row.doctorname }</p>
			
											</div>
											<div class="details">
												<p class="blue">예약자</p>
												<p>${ row.username }</p>
											</div>
											<div class="details">
												<p class="blue">예약일</p>
												<p>${ row.postdate } ${ row.posttime }</p>
											</div>
										</div>
										<div class="detail memo">
											<div class="details">
											    <c:if test="${ not empty row.user_memo }">
													<div class="details">
														<p class="blue">메모</p>
														<p>${ row.user_memo }</p>
													</div>
				        						</c:if>
			        						</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 하단 메뉴(버튼) -->
							<div class="board_btn">
							
								<!-- 메모작성 유무에 따라 버튼 text 변경  -->
								<c:if test="${ empty row.user_memo }">
									<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">메모<br />추가</button>
								</c:if>
								<c:if test="${ not empty row.user_memo }">
									<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">메모<br />수정</button>
								</c:if>
								
								<!-- 추가 예정 -->	
								<button type="button" onclick="location.href='/reserve/delete.do?app_id=${ row.app_id }';">내역<br />숨김</button>
								<button type="button" onclick="hideReservation(${ row.app_id });">내역<br />숨김</button>
								<button type="button" onclick="cancelReservation(${ row.app_id });">예약<br />취소</button>
							</div>
							<c:if test="${ row.cancel eq 'T' }">
								<div class="cancel">
									<p>취소된 예약</p>
								</div>
							</c:if>
						</li>
						
						</c:if>
					</c:if>
					
					<!-- hosp 회원 화면-->
					<c:if test="${ userAuth eq 'ROLE_HOSP' }">
					
						<c:if test="${ row.user_ref ne 'admin' }">
						<li>
	
							<div class="info">
								<div class="info_top">
									<div class="detail_hosp">
										<div class="detail_left">
											<div class="details">
												<p class="blue">예약자</p>
												<p>${ row.username }</p>
											</div>
											<div class="details">
												<p class="blue">전화번호</p>
												<p>${ row.tel }</p>
											</div>
											<div class="details">
												<p class="blue">주민번호</p>
												<p>${ row.rrn }</p>
											</div>
											<div class="details">
												<p class="blue">주소</p>
												<p>${ row.address }</p>
											</div>
										</div>
										<div class="detail_right">
											<div class="details">
												<p class="blue">예약일</p>
												<p>${ row.postdate } ${ row.posttime }</p>
											</div>
											<div class="details">
												<p class="blue">예약 의사</p>
												<p>${ row.doctorname }</p>
											</div>
										<c:if test="${ not empty row.hosp_memo }">
											<div class="details">
												<div class="details">
													<p class="blue">메모</p>
													<p>${ row.hosp_memo }</p>
												</div>
			        						</div>
	        							</c:if>
										</div>
									</div>
								</div>
							</div>
							
							<c:if test="${ row.cancel eq 'T' }">
								<div class="cancel">
									<p>취소된 예약</p>
								</div>
							</c:if>
							
							<!-- 추가 예정 -->
							<!-- 하단 메뉴(버튼) -->
	<!-- 					<div class="board_btn"> -->
							<button type="button" onclick="location.href='/reserve/extraInfo.do?app_id=${ row.app_id }';">메모<br />추가</button>
							<button type="button" onclick="deleteReservation(${ row.app_id });">삭제</button>
	<!-- 					</div> -->
						</li>
						
						
						
						</c:if>
						
					</c:if>
				</c:forEach>
				
			</ul>
			<!-- 페이지네이션 -->
			<div class="pagination">
				<div class="pagination_inner">
					${ pagingImg }
				</div>
			</div>	
		</c:otherwise>
	</c:choose>
	</div>
				
				
			</div>
		</div>
	</main>
	 --%>
	<%@include file="../common/main_footer.jsp" %>
	
	
	<!-- == 메모 모달창 == -->
	<form id="memoForm" method="post" action="../mypage/editMemo.do" onsubmit="return validateMemoForm(this);">
		<input type="hidden" id="memo_app_id" name="app_id" value="">
		<div class="modal" id="memoModal" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">메모</h4>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<div class="modal-body">
						<textarea class="form-control" id="memo_content" name="user_memo" style="height: 100px;"></textarea>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">작성하기</button>
						<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>