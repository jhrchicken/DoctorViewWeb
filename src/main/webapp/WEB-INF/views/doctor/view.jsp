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
		<%@include file="../common/head.jsp" %>
		<link rel="stylesheet" href="/css/doc-view.css" />
		<script src="/js/doctor-view.js"></script>
	</head>
	
	<body>
		<%@include file="../common/main_header.jsp" %>
		<main id="container">
			<div class="content">
				<div class="doc_wrap">
					<!-- 의사 프로필 -->
					<form name="deleteDoctorForm">
						<input type="hidden" name="doc_idx" value="${ doctorDTO.doc_idx }" />
					</form>
					<div class="doc_profile">
						<!-- 의사 사진 -->
						<c:if test="${ doctorDTO.photo == null }">
							<span class="doc_photo">
								<img src="/images/doctor.png" alt="" />
							</span>
						</c:if>
						<c:if test="${ doctorDTO.photo != null }">
							<span class="doc_photo">
								<img src="/uploads/${ row.photo }" />
							</span>
						</c:if>
						<!-- 의사 정보 -->
						<div class="doc_info">
							<div class="doc_name">
								<p>${ doctorDTO.name }</p>
							</div>
							<div class="doc_hosp">
								<p>${ doctorDTO.hospname }</p>
							</div>
							<div class="doc_major">
								<p class="sub_tit">전공</p>
								<div class="divider"></div>
								<p>${ doctorDTO.major }</p>
							</div>
							<div class="doc_career">
								<p class="sub_tit">경력</p>
								<div class="divider"></div>
								<p>${ doctorDTO.career }</p>
							</div>
							<div class="doc_hours">
								<p class="sub_tit">근무시간</p>
								<div class="divider"></div>
								<p>${ doctorDTO.hours }</p>
							</div>

							<!-- 찜 -->
							<div class="info_right">
								<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
								<c:if test="${ doclikecheck == 0 }">
									<a class="save_btn" href="../doctor/clickDocLike.do?doc_idx=${ param.doc_idx }">
										<span>
											<img src="/images/mark.svg" alt="">
											${ doctorDTO.likecount }
										</span>
									</a>
								</c:if>
								<!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
								<c:if test="${ doclikecheck == 1 }">
									<a class="save_btn" href="../doctor/clickDocLike.do?doc_idx=${ param.doc_idx }">
										<span>
											<img src="/images/mark_full.svg" alt="">
											${ doctorDTO.likecount }
										</span>
									</a>
								</c:if>
							</div>

							<!-- 하단 메뉴(버튼) -->
							<c:if test="${ sessionScope.userAuth == 'ROLE_HOSP' }">
								<div class="board_btn">
									<button type="button" onclick="location.href='../doctor/editDoctor.do?doc_idx=${ param.doc_idx }';">수정하기</button>
									<button type="button" onclick="deleteDoctor(${ param.doc_idx });">삭제하기</button>
								</div>
							</c:if>
						</div>
					</div>
				</div>
				
				<div class="review_wrap">
					<div class="review_list">
						<!-- 댓글 -->
						<form name="deleteReviewForm" method="post">
							<input type="hidden" name="doc_ref" value="" />
							<input type="hidden" name="review_idx" value="" />
						</form>
						<form name="deleteReplyForm" method="post">
							<input type="hidden" name="doc_ref" value="" />
							<input type="hidden" name="review_idx" value="" />
						</form>
						
						<c:choose>
							<c:when test="${ empty reviewsList }">
								<p>리뷰가 없습니다</p>
							</c:when>
							<c:otherwise>
								<ul class="review">
									<c:forEach items="${ reviewsList }" var="row" varStatus="loop">
										<li>
											<!-- 작성자 아이콘 -->
											<div class="review_icon">
											</div>
											<!-- 리뷰 정보 -->
											<div class="review_info">
												<!-- 닉네임 -->
												<div class="review_nickname">
													<p>${ row.nickname }</p>
												</div>
												<!-- 날짜 및 수정 여부 -->
												<div class="info_right">
													<div class="review_date">
														<p>${ row.postdate }</p>
														<%-- <c:if test="${ row.rewrite == 'T' }"> --%>
															<p>•</p>
															<p class="edit">수정됨</p>
														<%-- </c:if> --%>
													</div>
												</div>
												<!-- 별점 -->
												<div class="review_score">
													<div class="star">
														<c:forEach var="i" begin="0" end="${row.score - 1}">
															<img src="/images/star.svg" alt="" />
														</c:forEach>
														<c:forEach var="i" begin="${row.score}" end="4">
															<img src="/images/star_empty.svg" alt="" />
														</c:forEach>
													</div>
													<p>${ row.score }</p>
												</div>
												<!-- 해시태그 -->
												<c:if test="${ not empty hashtagList }">
													<ul class="review_hash">
														<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
															<c:if test="${ hashrow.dreview_ref == row.review_idx }">
																<li class="hash">
																	<p>${ hashrow.tag }</p>
																</li>
															</c:if>
														</c:forEach>
													</ul>
												</c:if>
												<!-- 내용 -->
												<div class="review_content">
													<p>${ row.content }</p>
												</div>
												
												<div class="review_other">
													<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
													<c:if test="${ row.likecheck == 0 }">
														<button class="comm_like_btn" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';">
															<img src="/images/heart.svg" style="width: 24px; height: 24px;" /> ${ row.likecount }
														</button>
													</c:if>
													<!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
													<c:if test="${ row.likecheck == 1 }">
														<button class="comm_like_btn" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';">
															<img src="/images/heart_full.svg" style="width: 24px; height: 24px;" /> ${ row.likecount }
														</button>
													</c:if>
													<c:if test="${ doctorDTO.hosp_ref == sessionScope.loginMember.id }">
														<button class="re_btn" type="button" data-bs-toggle="modal" data-bs-target="#writeReplyModal"
															onclick="openReplyWriteModal(${ row.doc_ref }, ${ row.review_idx })">
															댓글 달기
														</button>
													</c:if>
												</div>
												
												
											</div>
										</li>
									</c:forEach>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="comment_inner">

					<c:choose>
						<c:when test="${ empty reviewsList }">
							<p>리뷰를 남겨보세요.</p>
						</c:when>
						<c:otherwise>
							<c:forEach items="${ reviewsList }" var="row" varStatus="loop">
								<c:if test="${ row.original_idx == row.review_idx }">
									<div class="review_wrap">
										<div class="review_list">   
											<div class="review">
												
												<div class="review_other">
													<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
													<c:if test="${ row.likecheck == 0 }">
														<button class="comm_like_btn" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';">
															<img src="/images/heart.svg" style="width: 24px; height: 24px;" /> ${ row.likecount }
														</button>
													</c:if>
													<!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
													<c:if test="${ row.likecheck == 1 }">
														<button class="comm_like_btn" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';">
															<img src="/images/heart_full.svg" style="width: 24px; height: 24px;" /> ${ row.likecount }
														</button>
													</c:if>
													<c:if test="${ doctorDTO.hosp_ref == sessionScope.loginMember.id }">
														<button class="re_btn" type="button" data-bs-toggle="modal" data-bs-target="#writeReplyModal"
															onclick="openReplyWriteModal(${ row.doc_ref }, ${ row.review_idx })">
															댓글 달기
														</button>
													</c:if>
												</div>
											</div>
											<!-- 로그인 사용자와 댓글 작성자가 일치하는 경우 수정 삭제 버튼 -->
											<c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
												<div class="manage">
													<button type="button" data-bs-toggle="modal" data-bs-target="#editReviewModal"
														onclick="openReviewEditModal(${ row.doc_ref }, ${ row.review_idx }, ${ row.score }, '${ row.content }')">
														수정하기
													</button>
													<button type="button" onclick="deleteReview(${ row.doc_ref }, ${ row.review_idx });">
													삭제하기
													</button>
												</div>
											</c:if>
										</div>
										
										<!-- 리뷰에 대한 답변 출력 -->
										<c:forEach items="${ reviewsList }" var="replyRow">
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
																		onclick="openReplyEditModal(${ replyRow.doc_ref }, ${ replyRow.review_idx }, '${ replyRow.content }')">
																		수정
																	</button>
																	<button type="button"  onclick="deleteReply(${ replyRow.doc_ref }, ${ replyRow.review_idx });">
																		삭제
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
		<form method="post" action="../doctor/editReview.do" onsubmit="return validateReviewForm(this);">
		   <input type="hidden" id="review_edit_doc_ref" name="doc_ref" value="" />
		   <input type="hidden" id="review_edit_hashtags" name="hashtags" />
		    <input type="hidden" id="review_edit_score" name="score" value="" />
		   <div class="modal" id="editReviewModal" >
		      <div class="modal-dialog">
		         <div class="modal-content">
		            <!-- Modal Header -->
		            <div class="modal-header">
		               <h4 class="modal-title">의사 리뷰 수정</h4>
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
		               <!-- 폼 입력 -->
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
		<form method="post" action="../doctor/writeReply.do" onsubmit="return validateReplyForm(this);">
		   <input type="hidden" id="reply_write_doc_ref" name="doc_ref" value="" />
		   <input type="hidden" id="reply_write_review_idx" name="review_idx" value="" />
		   <div class="modal" id="writeReplyModal" >
		      <div class="modal-dialog">
		         <div class="modal-content">
		            <div class="modal-header">
		               <h4 class="modal-title">답변을 작성합니다</h4>
		               <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <div class="modal-body">
		               <textarea class="form-control" name="content" style="height: 100px;" placeholder="내용을 입력하세요"></textarea>
		            </div>
		            <div class="modal-footer">
		               <button type="submit" class="btn btn-primary">작성하기</button>
		               <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
		            </div>
		         </div>
		      </div>
		   </div>
		</form>
		
		<!-- == 답변 수정 모달창 == -->
		<form method="post" action="../doctor/editReply.do" onsubmit="return validateReplyForm(this);">
		   <input type="hidden" id="reply_edit_doc_ref" name="doc_ref" value="" />
		   <div class="modal" id="editReplyModal" >
		      <div class="modal-dialog">
		         <div class="modal-content">
		            <div class="modal-header">
		               <h4 class="modal-title">의사 답변 수정</h4>
		               <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		            </div>
		            <div class="modal-body">
		               <input type="hidden" id="reply_edit_review_idx" name="review_idx" value="">
		               <textarea class="form-control" id="reply_edit_content" name="content" style="height: 100px;"></textarea>
		            </div>
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