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
// 의사 삭제
function deleteDoctor(doc_idx) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		var form = document.deleteDoctorForm;
		form.method = "post";
		form.action = "/doctor/deleteDoctor.do";
		form.submit();
	}
}

// 리뷰 작성 모달창 열기
function openReviewWriteModal(doc_idx) {
	document.getElementById("review_write_doc_idx").value = doc_idx;
	document.getElementById("review_write_score").value = 1;
	// 별점 UI 업데이트 (1점을 선택된 상태로 설정)
    document.querySelectorAll('.star').forEach(function(star) {
        if (star.getAttribute('data-value') <= 1) {
            star.src = '/images/star.svg';
        } else {
            star.src = '/images/star_empty.svg';
        }
    });
}

// 리뷰 수정 모달창 열기
function openReviewEditModal(doc_ref, review_idx, score, content) {
	document.getElementById("review_edit_doc_ref").value = doc_ref;
    document.getElementById("review_edit_score").value = score;
    document.getElementById("review_edit_content").value = content;
    document.getElementById("review_edit_review_idx").value = review_idx;
 	// 별점 이미지 업데이트
    document.querySelectorAll('.star').forEach(function(star) {
        if (star.getAttribute('data-value') <= score) {
            star.src = '/images/star.svg';
        } else {
            star.src = '/images/star_empty.svg';
        }
    });
}

// 리뷰 삭제
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

// 답변 작성 모달창 열기
function openReplyWriteModal(doc_ref, review_idx) {
	document.getElementById("reply_write_doc_ref").value = doc_ref;
    document.getElementById("reply_write_review_idx").value = review_idx;
}

// 답변 수정 모달창 열기
function openReplyEditModal(doc_ref, review_idx, content) {
	document.getElementById("reply_edit_doc_ref").value = doc_ref;
    document.getElementById("reply_edit_content").value = content;
    document.getElementById("reply_edit_review_idx").value = review_idx;
}

// 답변 삭제
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

// 폼값 검증
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

// 리뷰 작성 해시태그
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('review_write_hashtags');
    let selectedHashtags = [];
    // 해시태그 버튼 클릭 시 처리
    hashtagButtons.forEach(button => {
        button.addEventListener('click', function () {
            const tag = button.textContent.trim();
            // 이미 선택된 해시태그인 경우 색상 원래대로 되돌리기
            if (selectedHashtags.includes(tag)) {
                selectedHashtags = selectedHashtags.filter(h => h !== tag);
                button.style.backgroundColor = ''; // 원래 색상으로 변경
                button.style.color = ''; // 원래 텍스트 색상으로 변경
            } else {
                // 선택되지 않은 해시태그인 경우 추가
                selectedHashtags.push(tag);
                button.style.backgroundColor = '#005ad5'; // 선택된 색상으로 변경
                button.style.color = '#fff'; // 텍스트 색상 변경
            }
            // 히든 필드에 선택된 해시태그 값을 저장
            updateHiddenInput();
        });
    });
    // 히든 필드에 선택된 해시태그 값을 저장
    function updateHiddenInput() {
        hashtagsHiddenInput.value = selectedHashtags.join(',');
    }
});

//리뷰 수정 해시태그
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('review_edit_hashtags');
    let selectedHashtags = [];
    // 해시태그 버튼 클릭 시 처리
    hashtagButtons.forEach(button => {
        button.addEventListener('click', function () {
            const tag = button.textContent.trim();
            // 이미 선택된 해시태그인 경우 색상 원래대로 되돌리기
            if (selectedHashtags.includes(tag)) {
                selectedHashtags = selectedHashtags.filter(h => h !== tag);
                button.style.backgroundColor = ''; // 원래 색상으로 변경
                button.style.color = ''; // 원래 텍스트 색상으로 변경
            } else {
                // 선택되지 않은 해시태그인 경우 추가
                selectedHashtags.push(tag);
                button.style.backgroundColor = '#005ad5'; // 선택된 색상으로 변경
                button.style.color = '#fff'; // 텍스트 색상 변경
            }
            // 히든 필드에 선택된 해시태그 값을 저장
            updateHiddenInput();
        });
    });
    // 히든 필드에 선택된 해시태그 값을 저장
    function updateHiddenInput() {
        hashtagsHiddenInput.value = selectedHashtags.join(',');
    }
});

// 리뷰 작성 별점
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#star-rating .star');
    const scoreInput = document.getElementById('review_write_score');
    stars.forEach(star => {
        star.addEventListener('click', function () {
            const rating = this.getAttribute('data-value');
            scoreInput.value = rating; // 히든 필드에 점수 저장
            // 선택된 별의 색상 변경
            stars.forEach(s => {
                if (s.getAttribute('data-value') <= rating) {
                    s.src = '/images/star.svg'; // 선택된 별의 색상
                } else {
                    s.src = '/images/star_empty.svg'; // 선택되지 않은 별의 색상
                }
            });
        });
    });
});

// 리뷰 수정 별점
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#star-rating .star');
    const scoreInput = document.getElementById('review_edit_score');
    stars.forEach(star => {
        star.addEventListener('click', function () {
            const rating = this.getAttribute('data-value');
            scoreInput.value = rating; // 히든 필드에 점수 저장
            // 선택된 별의 색상 변경
            stars.forEach(s => {
                if (s.getAttribute('data-value') <= rating) {
                    s.src = '/images/star.svg'; // 선택된 별의 색상
                } else {
                    s.src = '/images/star_empty.svg'; // 선택되지 않은 별의 색상
                }
            });
        });
    });
});
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
				<!-- 의사 사진 -->
				<c:if test="${ doctorDTO.photo == null }">
					<span class="img">
						<img src="/images/doctor.png" alt="" />
					</span>
				</c:if>
				<c:if test="${ doctorDTO.photo != null }">
					<span class="img">
						<img src="/uploads/${ row.photo }" />
					</span>
				</c:if>
				
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
										<!-- 해시태그 -->
										<c:if test="${ not empty hashtagList }">
											<div class="review_hash">
												<ul>
													<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
														<c:if test="${ hashrow.dreview_ref == row.review_idx }">
															<li class="hash">
																<p>${ hashrow.tag }</p>
															</li>
														</c:if>
													</c:forEach>
												</ul>
											</div>
										</c:if>
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
   
<!-- 리뷰 작성 모달창 -->
<form method="post" action="../doctor/writeReview.do" onsubmit="return validateReviewForm(this);">
	<input type="hidden" id="review_write_doc_idx" name="doc_idx" value="" />
	<input type="hidden" name="hashtags" id="review_write_hashtags" />
    <input type="hidden" id="review_write_score" name="score" value="" />
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
					<!-- 해시태그 선택 -->
                    <div class="form-group mb-3">
                        <label>해시태그 선택:</label>
                        <div id="hashtag-list">
                            <!-- 해시태그 목록 -->
                            <button type="button" class="btn btn-secondary m-1">#친절해요</button>
                            <button type="button" class="btn btn-secondary m-1">#전문적이예요</button>
                            <button type="button" class="btn btn-secondary m-1">#청결해요</button>
                            <button type="button" class="btn btn-secondary m-1">#신속해요</button>
                        </div>
                    </div>
                    <!-- 별 점수 선택 -->
                    <div class="form-group mb-3">
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
					<textarea class="form-control mb-3" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
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
					<div class="form-group mb-3">
						<label>해시태그 선택:</label>
						<div id="hashtag-list">
							<!-- 해시태그 목록 -->
							<button type="button" class="btn btn-secondary m-1">#친절해요</button>
							<button type="button" class="btn btn-secondary m-1">#전문적이예요</button>
							<button type="button" class="btn btn-secondary m-1">#청결해요</button>
							<button type="button" class="btn btn-secondary m-1">#신속해요</button>
						</div>
					</div>
					<!-- 별 점수 선택 영역 -->
					<div class="form-group mb-3">
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
					<textarea class="form-control mb-3" id="review_edit_content" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
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
	<input type="hidden" id="reply_write_doc_ref" name="doc_ref" value="" />
	<input type="hidden" id="reply_write_review_idx" name="review_idx" value="" />
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