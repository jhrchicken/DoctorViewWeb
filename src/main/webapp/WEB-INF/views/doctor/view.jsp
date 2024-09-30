<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 의사 찾기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/doc-view.css" />
<script>
function deleteDoctor(doc_idx) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		var form = document.deleteDoctorForm;
		form.method = "post";
		form.action = "/doctor/deleteDoctor.do";
		form.submit();
	}
}
function deleteReview(doc_ref, review_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var form = document.deleteReviewForm;
		// hidden 필드에 값을 동적으로 설정
        form.doc_ref.value = doc_ref;
        form.review_idx.value = review_idx;
		form.method = "post";
		form.action = "/doctor/deleteReview.do";
		form.submit();
	}
}
function deleteReply(doc_ref, review_idx) {
	if (confirm("답변을 삭제하시겠습니까?")) {
		var form = document.deleteReplyForm;
		// hidden 필드에 값을 동적으로 설정
        form.doc_ref.value = doc_ref;
        form.review_idx.value = review_idx;
		form.method = "post";
		form.action = "/doctor/deleteReply.do";
		form.submit();
	}
}

function openReviewWriteModal(doc_idx) {
	document.getElementById("doc_idx").value = doc_idx;
}
function openReviewEditModal(doc_ref, review_idx, score, content) {
	document.getElementById("doc_ref").value = doc_ref;
    document.getElementById("score").value = score;
    document.getElementById("content").value = content;
    document.getElementById("review_idx").value = review_idx;
}
function openReplyWriteModal(doc_ref, review_idx) {
	document.getElementById("reply_doc_ref").value = doc_ref;
    document.getElementById("reply_review_idx").value = review_idx;
}
function openReplyEditModal(doc_ref, review_idx, content) {
	document.getElementById("reply_edit_doc_ref").value = doc_ref;
    document.getElementById("reply_edit_content").value = content;
    document.getElementById("reply_edit_review_idx").value = review_idx;
}
function validateReviewForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
function validateReplyForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">

			<!-- 의사 정보 -->
			<form name="deleteDoctorForm">
				<input type="hidden" name="doc_idx" value="${ doctorDTO.doc_idx }" />
			</form>
			<div class="doc_info">
				<!-- 사진 있을 때 없을 때 처리해야 함! -->
				<span class="img">
					<img src="/images/doctor.png" alt="" />
				</span>
				
				
				<div class="info">
					<div class="info_top">
						<p>${ doctorDTO.hospname }</p>
						<h3>${ doctorDTO.name }</h3>
					</div>
					<div class="detail">
						<div class="details">
							<p class="blue">전공</p>
							<p>${ doctorDTO.major }</p>
						</div>
						<div class="details">
							<p class="blue">경력</p>
							<p>${ doctorDTO.career }</p>
						</div>
						<div class="details">
							<p class="blue">근무시간</p>
							<p>${ doctorDTO.hours }</p>
						</div>
					</div>
					
					<div class="like_wrap">
						<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
						<c:if test="${ doclikecheck == 0 }">
							<button type="button" onclick="location.href='../hospital/clickHospLike.do?api_idx=${ param.api_idx }';">
								<img src="/images/mark.svg" alt="" style="width: 30px; height: 30px;" />
								${ doctorDTO.likecount }
							</button>
						</c:if>
						<!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
						<c:if test="${ doclikecheck == 1 }">
							<button type="button" onclick="location.href='../hospital/clickHospLike.do?api_idx=${ param.api_idx }';">
								<img src="/images/mark_full.svg" alt="" style="width: 30px; height: 30px;" />
								${ doctorDTO.likecount }
							</button>
						</c:if>
					</div>
					
					<!-- 하단 메뉴(버튼) -->
					<div class="board_btn">
						<button type="button" onclick="location.href='../doctor/editDoctor.do?doc_idx=${ param.doc_idx }';">수정하기</button>
						<button type="button" onclick="deleteDoctor(${ param.doc_idx });">삭제하기</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="comment_inner">
			<!-- 댓글 -->
			<form name="deleteReviewForm" method="post">
			    <input type="hidden" name="doc_ref" value="" />
			    <input type="hidden" name="review_idx" value="" />
			</form>
			<form name="deleteReplyForm" method="post">
			    <input type="hidden" name="doc_ref" value="" />
			    <input type="hidden" name="review_idx" value="" />
			</form>
			<!-- 로그인 한 경우 리뷰 작성 버튼 -->
	  		<c:if test="${ not empty sessionScope.userId }">
		  		<div class="comment_btn">
			  		<button type="button" data-bs-toggle="modal" data-bs-target="#writeReviewModal"
			  			onclick="openReviewWriteModal(${ param.doc_idx })">
		                리뷰 작성하기
		            </button>
	  			</div>
	  		</c:if>
			
			<c:choose>
				<c:when test="${ empty reviewsList }">
					<p>리뷰를 남겨보세요.</p>
				</c:when>
				<c:otherwise>
					<c:forEach items="${ reviewsList }" var="row" varStatus="loop">
						<c:if test="${ row.original_idx == row.review_idx }">
							<div class="review_wrapper">
								<div class="review_wrap">
									<img src="/images/hospital.png" alt="" />		
									<div class="review">
										<div class="review_score">
											<div class="star">
												<img src="/images/star.svg" alt="" />
												<img src="/images/star.svg" alt="" />
												<img src="/images/star.svg" alt="" />
												<img src="/images/star.svg" alt="" />
												<img src="/images/star.svg" alt="" />
											</div>
											<p>${ row.score }</p>
										</div>
										<div class="review_title">
											<p>${ row.nickname }</p>
											<p>•</p>
											<p>${ row.postdate }</p>
											<p class="edit">(${ row.rewrite })</p>
										</div>
										<div class="review_hash">
											<p>해시태그</p>
											<p>해시태그</p>
											<p>해시태그</p>
											<p>해시태그</p>
										</div>
										<div class="review_content">
											<p>${ row.content }</p>					
										</div>
										<div class="review_other">
											<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
							                <c:if test="${ reviewlikecheck == 0 }">
							                    <button class="comm_like_btn" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';">
							                    	<img src="/images/heart.svg" style="width: 24px; height: 24px;" /> ${ row.likecount }
							                	</button>
							                </c:if>
							                <!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
							                <c:if test="${ reviewlikecheck == 1 }">
							                    <button class="comm_like_btn" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';">
							                    	<img src="/images/heart_full.svg" style="width: 24px; height: 24px;" /> ${ row.likecount }
						                        </button>
							                </c:if>
											<button class="re_btn" type="button" data-bs-toggle="modal" data-bs-target="#writeReplyModal"
						                        	onclick="openReplyWriteModal(${ row.doc_ref }, ${ row.review_idx })">
						                        댓글 달기
					                        </button>
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
														<p class="edit">(${ replyRow.rewrite })</p>
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
   
<!-- 리뷰 작성 모달창 -->
<form method="post" action="../doctor/writeReview.do" onsubmit="return validateReviewForm(this);">
	<input type="hidden" id="doc_idx" name="doc_idx" value="" />
	<div class="modal" id="writeReviewModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">의사 리뷰 작성</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
	
					<textarea class="form-control mb-3" name="score" style="height: 20px;" placeholder="점수를 입력하세요 (1~5)"></textarea>
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

<!-- 리뷰 수정 모달창 -->
<form method="post" action="../doctor/editReview.do" onsubmit="return validateReviewForm(this);">
	<input type="hidden" id="doc_ref" name="doc_ref" value="" />
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
					<input type="hidden" id="review_idx" name="review_idx" value="">
					<textarea class="form-control mb-3" id="score" name="score" style="height: 20px;"></textarea>
					<textarea class="form-control" id="content" name="content" style="height: 100px;"></textarea>
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

<!-- 답변 작성 모달창 -->
<form method="post" action="../doctor/writeReply.do" onsubmit="return validateReplyForm(this);">
	<input type="hidden" id="reply_doc_ref" name="doc_ref" value="" />
	<input type="hidden" id="reply_review_idx" name="review_idx" value="" />
	<div class="modal" id="writeReplyModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">답변을 작성합니다</h4>
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

<!-- 답변 수정 모달창 -->
<form method="post" action="../doctor/editReply.do" onsubmit="return validateReplyForm(this);">
	<input type="hidden" id="reply_edit_doc_ref" name="doc_ref" value="" />
	<div class="modal" id="editReplyModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">의사 답변 수정</h4>
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