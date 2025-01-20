<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>닥터뷰</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
		<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
		<%@include file="../common/head.jsp" %>
		<link rel="stylesheet" href="/css/hosp-view.css" />
		<script src="/js/hospital-view.js"></script>
	</head>
	
	<body>
		<%@include file="../common/main_header.jsp" %>
		<main id="container">
			<div class="content">
				
				<!-- 병원 소개 -->
				<div class="content_inner">
					<!-- 병원 정보 -->
					<div class="hosp_info">
						<div class="img_wrap">
							<!-- 병원 사진 -->
							<c:if test="${ hospitalDTO.photo == null }">
								<span class="img">
									<img src="/images/hospital.png" alt="" style="width: 100%; height: 100%;" />
								</span>
							</c:if>
							<c:if test="${ hospitalDTO.photo != null }">
								<span class="img">
									<img src="/uploads/${ row.photo }" style="width: 100%; height: 100%;" ><br/>
								</span>
							</c:if>
						</div>
					
						<div class="info">
							<div class="info_top">
								<p>${ hospitalDTO.department }</p>
								<div class="hosp_name">
									<h3>${ hospitalDTO.name }</h3>
									<!-- 입점한 병원 인증마크 표시 -->
									<c:if test="${ hospitalDTO.enter == 'T' }">
										<span class="approve"></span>
									</c:if>
								</div>
							</div>
							<div class="detail">
								<div class="details">
									<p class="blue">전화</p>
									<p>${ hospitalDTO.tel }</p>
								</div>
								<div class="details">
									<p class="blue">주소</p>
									<p>${ hospitalDTO.address }</p>
								</div>
								<div class="details">
									<%-- <div class="detail_flex">
										<p class="blue">교통편</p>
										<c:if test="${ hospitalDTO.parking == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.parking == 'F' }">
											<p>불가능</p>
										</c:if>
									</div> --%>
									<div class="detail_flex">
										<p class="blue">주차</p>
										<c:if test="${ hospitalDTO.parking == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.parking == 'F' }">
											<p>불가능</p>
										</c:if>
									</div>
									<div class="detail_flex">
										<p class="blue">예약제</p>
										<c:if test="${ hospitalDTO.system == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.system == 'F' }">
											<p>불가능</p>
										</c:if>
									</div>
									<div class="detail_flex">
										<p class="blue">입원</p>
										<c:if test="${ hospitalDTO.hospitalize == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.hospitalize == 'F' }">
											<p>불가능</p>
										</c:if>
									</div>
									<div class="detail_flex">
										<p class="blue">PCR 검사</p>
										<c:if test="${ hospitalDTO.pcr == 'T' }">
											<p>가능</p>
										</c:if>
										<c:if test="${ hospitalDTO.pcr == 'F' }">
											<p>불가능</p>
										</c:if>
									</div>
								</div>
							</div>
							<!-- 해시태그 -->
							<c:if test="${ not empty hospHashtagList }">
							<div class="hashtag">
								<ul>
									<c:forEach items="${ hospHashtagList }" var="hashrow" varStatus="loop">
										<li class="hash">
											<p>${ hashrow.tag }</p>
										</li>
									</c:forEach>
								</ul>
							</div>
							</c:if>
						</div>
						
						<div class="other_wrap">
							<div class="like_wrap">
								<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
								<c:if test="${ hosplikecheck == 0 }">
									<button type="button" onclick="location.href='../hospital/clickHospLike.do?api_idx=${ param.api_idx }';">
										<img src="/images/mark.svg" alt="" style="width: 27px; height: 27px;" />
										${ hospitalDTO.likecount }
									</button>
								</c:if>
								<!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
								<c:if test="${ hosplikecheck == 1 }">
									<button type="button" onclick="location.href='../hospital/clickHospLike.do?api_idx=${ param.api_idx }';">
										<img src="/images/mark_full.svg" alt="" style="width: 27px; height: 27px;" />
										${ hospitalDTO.likecount }
									</button>
								</c:if>
							</div>
							
							<div class="btn_wrap">
								<!-- 사용자가 로그인 했고 임점한 병원인 경우에만 예약 가능 -->
								<c:if test="${ hospitalDTO.enter == 'T' && sessionScope.userName != null && sessionScope.userAuth != 'ROLE_HOSP' }">
									<button type="button" onclick="location.href='/reserve/proceed.do?api_idx=${ param.api_idx }';">예약하기</button>
								</c:if>
									
								<!-- 사용자가 로그인 했고 입점한 병원인 경우에만 채팅 가능 -->
								<c:if test="${ hospitalDTO.enter == 'T' && sessionScope.userName != null && sessionScope.userAuth != 'ROLE_HOSP' }">
								    <button onclick="openChatRoom('${ sessionScope.userName }', '${ hospitalDTO.name }');">채팅하기</button>
								</c:if>
							</div>
						
						</div>
					</div>
					
					<!-- 의사 정보 -->
					<div class="doctor_info">
						
						<c:choose> 
							<c:when test="${ empty doctorList }">
								<div class="doctor_none">
									<p>의료진 정보가 존재하지 않습니다.</p>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ doctorList }" var="row" varStatus="loop">
							    	<div class="doctor">
							            <a href="../doctor/viewDoctor.do?doc_idx=${ row.doc_idx }">
							                <div class="doc_wrap">
							                    <div class="doc_img">
							                        <c:if test="${ row.photo == null }">
							                            <img src="/images/doctor.png" alt="" />
							                        </c:if>
							                        <c:if test="${ row.photo != null }">
							                            <img src="/uploads/${ row.photo }" />
							                        </c:if>
							                    </div>
							                    <div class="doc_content">
							                        <div class="doc_title">
							                            <h3>${ row.name }</h3>
							                            <p class="etc">${ row.major }</p>
							                        </div>
							                        <div class="doc_detail">
							                            <p class="blue">경력</p>
							                            <p class="etc">${ row.career }</p>
							                        </div>
							                        <div class="doc_detail">
							                            <p class="blue">진료 요일</p>
							                            <p class="etc">${ row.hours }</p>
							                        </div>
							                    </div>
							                </div>
							            </a>
							    	</div>
						        </c:forEach>
							</c:otherwise>
						</c:choose>
						
					
				        
					</div>
		
					<!-- 시간 정보 -->
					<div class="time_info">
					
						<c:forEach items="${ hourList }" var="row" varStatus="loop"> 
								<c:if test="${ row.starttime != '00:00' }">
									<div class="time">
										<p class="day">${ row.week }</p>
										<div class="time_detail">
											<p class="blue">영업시간</p>
											<p class="etc">${ row.starttime }-${ row.endtime }</p>
										</div>
										<c:if test="${ row.startbreak != '00:00' }">
											<div class="time_detail">
												<p class="blue">휴게시간</p>
												<p class="etc">${ row.startbreak }-${ row.endbreak }</p>
											</div>
										</c:if>
										<div class="time_detail">
											<p class="blue">접수마감</p>
											<p class="etc">${ row.deadline }</p>
										</div>
									</div>
								</c:if>
						</c:forEach>	
				        
					</div>
					
				</div>
				
				<!-- 댓글 -->
				<div class="comment_inner">
					<!-- 댓글 -->
					<form name="deleteReviewForm" method="post">
					    <input type="hidden" name="api_ref" value="" />
					    <input type="hidden" name="review_idx" value="" />
					</form>
					<form name="deleteReplyForm" method="post">
					    <input type="hidden" name="api_ref" value="" />
					    <input type="hidden" name="review_idx" value="" />
					</form>
			  		<c:choose>
						<c:when test="${ empty reviewList }">
							<p>리뷰를 남겨보세요.</p>
						</c:when>
						<c:otherwise>
							<c:forEach items="${ reviewList }" var="row" varStatus="loop">
								<c:if test="${ row.original_idx == row.review_idx }">
									<div class="review_wrapper">
										<div class="review_wrap">
											<div class="comment_etc">
												<img src="/images/hospital.png" alt="" />	
												<c:if test="${ row.writer_ref.equals(sessionScope.userId) }"> 
													<div class="manage">
														<button type="button" data-bs-toggle="modal" data-bs-target="#editReviewModal"
															    onclick="openReviewEditModal(${ row.api_ref }, ${ row.review_idx }, ${ row.score }, '${ row.content }', '${ row.cost }', '${ row.treat }', '${ row.doctor }')">
															    수정하기
														</button>
														<button type="button" onclick="deleteReview(${ row.api_ref }, ${ row.review_idx });">
															삭제하기
														</button>
													</div>
												</c:if>	
											</div>
											<div class="review">
												<div class="review_score">
													<div class="star">
														<c:forEach var="i" begin="0" end="${row.score - 1}">
														    <img src="/images/star.svg" alt="Star" />
														</c:forEach>
														<c:forEach var="i" begin="${row.score}" end="4">
														    <img src="/images/star_empty.svg" alt="Empty Star" />
														</c:forEach>
													</div>
													<p>${ row.score }</p>
												</div>
												<div class="review_title">
													<p>${ row.nickname }</p>
													<p>•</p>
													<p>${ row.postdate }</p>
													<!-- 수정 여부 -->
													<c:if test="${ row.rewrite == 'T' }">
														<p class="edit">(수정됨)</p>
													</c:if>
												</div>
												<div class="extra_wrap">
													<div class="review_extra">
														<c:if test="${ row.doctor != null }">
															<div class="extra_detail">
																<p class="blue">담당의</p>
																<p>${ row.doctor }</p>
															</div>
														</c:if>
														<c:if test="${ row.treat != null }">
															<div class="extra_detail">
																<p class="blue">치료내용</p>
																<p>${ row.treat }</p>			
															</div>
														</c:if>
														<c:if test="${ row.cost != null }">
															<div class="extra_detail">
																<p class="blue">비용</p>
																<p>${ row.cost }원</p>					
															</div>
														</c:if>
													</div>	
													<!-- 해시태그 -->
													<c:if test="${ not empty hashtagList }">
														<ul class="review_hash">
															<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
																<c:if test="${ hashrow.hreview_ref == row.review_idx }">
																	<li>
																		<p>${ hashrow.tag }</p>
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</c:if>
												</div>
												<div class="review_content">
													<p>${ row.content }</p>	
												</div>
												<div class="review_other">
													<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
									                <c:if test="${ row.likecheck == 0 }">
									                    <button class="comm_like_btn" type="button" onclick="location.href='../hospital/clickReviewLike.do?api_ref=${ row.api_ref }&review_idx=${ row.review_idx }';">
									                    	<img src="/images/heart.svg" style="width: 20px; height: 20px;" /> ${ row.likecount }
									                	</button>
									                </c:if>
									                <!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
									                <c:if test="${ row.likecheck == 1 }">
									                    <button class="comm_like_btn" type="button" onclick="location.href='../hospital/clickReviewLike.do?api_ref=${ row.api_ref }&review_idx=${ row.review_idx }';">
									                    	<img src="/images/heart_full.svg" style="width: 20px; height: 20px;" /> ${ row.likecount }
								                        </button>
									                </c:if>
									                <c:if test="${ (sessionScope.userId).equals(hospitalDTO.id) }">
														<button class="re_btn" type="button" data-bs-toggle="modal" data-bs-target="#writeReplyModal"
									                        	onclick="openReplyWriteModal(${ row.api_ref }, ${ row.review_idx })">
									                        답변 작성하기
								                        </button>
								                    </c:if>
												</div>
											</div>
										</div>
										
										<!-- 리뷰에 대한 답변 출력 -->
									    <c:forEach items="${ reviewList }" var="replyRow">
									    	<c:if test="${ replyRow.original_idx == row.review_idx and replyRow.review_idx != replyRow.original_idx }">
												<div class="recomm">
													<div class="recomm_wrap">
														<div class="recomm_title_wrap">
															<div class="recomm_title">
																<p>${ replyRow.nickname }</p>
																<p>•</p>
																<p>${ replyRow.postdate }</p>
																<!-- 수정 여부 -->
																<c:if test="${ replyRow.rewrite == 'T' }">
																	<p class="edit">(수정됨)</p>
																</c:if>
															</div>
															
															<!-- 로그인 사용자와 답변 작성자가 일치하는 경우 수정 삭제 버튼 -->
										                    <c:if test="${ replyRow.writer_ref.equals(sessionScope.userId) }">
																<div class="recomm_btn">
																	<button type="button" data-bs-toggle="modal" data-bs-target="#editReplyModal"
										                                	onclick="openReplyEditModal(${ replyRow.api_ref }, ${ replyRow.review_idx }, '${ replyRow.content }')">
									                                	수정하기
								                                	</button>
																	<button type="button" onclick="deleteReply(${ replyRow.api_ref }, ${ replyRow.review_idx });">
																		삭제하기
																	</button>
																</div>
															</c:if>
														</div>
														<div class="recomm_content">
															<p>${ replyRow.content }</p>
														</div>
													</div>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>	
		</main>
		<%@include file="../common/main_footer.jsp" %>

	
		<!-- == 리뷰 수정 모달창 == -->
		<form method="post" action="../hospital/editReview.do" onsubmit="return validateReviewForm(this);">
			<input type="hidden" id="review_edit_api_ref" name="api_ref" value="" />
			<input type="hidden" name="hashtags" id="review_edit_hashtags" />
		    <input type="hidden" id="review_edit_score" name="score" value="" />
			<div class="modal" id="editReviewModal">
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">병원 리뷰 수정</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<!-- Modal Body -->
						<div class="modal-body">
							<input type="hidden" id="review_edit_review_idx" name="review_idx" value="">
							<!-- 해시태그 선택 영역 -->
							<div class="form-group">
								<label>해시태그 선택:</label>
								<div id="hashtag-list">
									<!-- 해시태그 목록 -->
									<button type="button" class="btn btn-secondary">친절해요</button>
									<button type="button" class="btn btn-secondary">전문적이예요</button>
									<button type="button" class="btn btn-secondary">청결해요</button>
									<button type="button" class="btn btn-secondary">신속해요</button>
								</div>
							</div>
							<!-- 별 점수 선택 영역 -->
							<div class="form-group">
								<label>점수 선택:</label>
								<div id="star-rating" style="cursor: pointer;">
									<!-- 별 아이콘 -->
									<img src="/images/star_empty.svg" class="star" data-value="1" />
									<img src="/images/star_empty.svg" class="star" data-value="2" />
									<img src="/images/star_empty.svg" class="star" data-value="3" />
									<img src="/images/star_empty.svg" class="star" data-value="4" />
									<img src="/images/star_empty.svg" class="star" data-value="5" />
								</div>
							</div>
							<!-- 댓글 내용 -->
		                    <textarea class="form-control" id="review_edit_doctor"  name="doctor" style="height: 20px;" placeholder="담당 의사를 입력해주세요"></textarea>
		                    <textarea class="form-control" id="review_edit_treat" name="treat" style="height: 20px;" placeholder="치료 내용을 입력해주세요"></textarea>
		                    <textarea class="form-control" id="review_edit_cost" name="cost" style="height: 20px;" placeholder="비용을 입력해주세요"></textarea>
							<textarea class="form-control" id="review_edit_content" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
						</div>
						<!-- Modal Footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">수정하기</button>
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		
		<!-- == 답변 작성 모달창 == -->
		<form method="post" action="../hospital/writeReply.do" onsubmit="return validateReplyForm(this);">
			<input type="hidden" id="reply_write_api_ref" name="api_ref" value="" />
			<input type="hidden" id="reply_write_review_idx" name="review_idx" value="" />
			<div class="modal" id="writeReplyModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">답변 작성</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<!-- Modal Body -->
						<div class="modal-body">
							<textarea class="form-control" name="content" style="height: 100px;" placeholder="내용을 입력하세요"></textarea>
						</div>
						<!-- Modal Footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">작성하기</button>
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		
		<!-- ==  답변 수정 모달창 == -->
		<form method="post" action="../hospital/editReply.do" onsubmit="return validateReplyForm(this);">
			<input type="hidden" id="reply_edit_api_ref" name="api_ref" value="" />
			<div class="modal" id="editReplyModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">답변 수정</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
						</div>
						<!-- Modal Body -->
						<div class="modal-body">
							<input type="hidden" id="reply_edit_review_idx" name="review_idx" value="">
							<textarea class="form-control" id="reply_edit_content" name="content" style="height: 100px;"></textarea>
						</div>
						<!-- Modal Footer -->
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">수정하기</button>
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</body>   

</html>