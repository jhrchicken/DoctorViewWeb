<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 작성한 리뷰</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/my-review.css" />

<script>
// 병원 리뷰 수정 모달창 열기
function openHreviewEditModal(api_ref, review_idx, score, content, cost, treat, doctor) {
    document.getElementById("hreview_edit_api_ref").value = api_ref;
    document.getElementById("hreview_edit_score").value = score;
    document.getElementById("hreview_edit_content").value = content;
    document.getElementById("hreview_edit_cost").value = cost;
    document.getElementById("hreview_edit_treat").value = treat;
    document.getElementById("hreview_edit_doctor").value = doctor;
    document.getElementById("hreview_edit_hreview_idx").value = review_idx;
    // 별점 이미지 업데이트
    document.querySelectorAll('.star').forEach(function(star) {
        if (star.getAttribute('data-value') <= score) {
            star.src = '/images/star.svg';
        } else {
            star.src = '/images/star_empty.svg';
        }
    });
}

// 병원 리뷰 삭제
function deleteHreview(api_ref, review_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var form = document.deleteHreviewForm;
		// hidden 필드에 값을 동적으로 설정
        form.api_ref.value = api_ref;
        form.hreview_idx.value = review_idx;
		form.method = "post";
		form.action = "/mypage/deleteHreview.do";
		form.submit();
	}
}

//폼값 검증
function validateReviewForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}

// 병원 리뷰 수정 해시태그
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('hreview_edit_hashtags');
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
                button.style.border = '';
            } else {
                // 선택되지 않은 해시태그인 경우 추가
                selectedHashtags.push(tag);
                button.style.backgroundColor = '#005ad5'; // 선택된 색상으로 변경
                button.style.color = '#fff'; // 텍스트 색상 변경
                button.style.border = '1px solid #005ad5';
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

// 병원 리뷰 수정 별점
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#star-rating .star');
    const scoreInput = document.getElementById('hreview_edit_score');
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

// 의사 리뷰 수정 모달창 열기
function openDreviewEditModal(doc_ref, review_idx, score, content) {
   document.getElementById("dreview_edit_doc_ref").value = doc_ref;
    document.getElementById("dreview_edit_score").value = score;
    document.getElementById("dreview_edit_content").value = content;
    document.getElementById("dreview_edit_dreview_idx").value = review_idx;
    // 별점 이미지 업데이트
    document.querySelectorAll('.star').forEach(function(star) {
        if (star.getAttribute('data-value') <= score) {
            star.src = '/images/star.svg';
        } else {
            star.src = '/images/star_empty.svg';
        }
    });
}

// 의사 리뷰 삭제
function deleteDreview(doc_ref, review_idx) {
   if (confirm("댓글을 삭제하시겠습니까?")) {
      var form = document.deleteDreviewForm;
      // hidden 필드에 값을 동적으로 설정
      form.doc_ref.value = doc_ref;
      form.dreview_idx.value = review_idx;
      form.method = "post";
      form.action = "/mypage/deleteDreview.do";
      form.submit();
   }
}

// 의사 리뷰 수정 해시태그
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('dreview_edit_hashtags');
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


// 의사 리뷰 수정 별점
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#star-rating .star');
    const scoreInput = document.getElementById('dreview_edit_score');
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
      <h2>작성한 리뷰</h2>
      
		<!-- 삭제를 위한 폼 -->
		<form name="deleteHreviewForm" method="post">
			<input type="hidden" name="api_ref" value="" />
			<input type="hidden" name="hreview_idx" value="" />
		</form>
        <form name="deleteDreviewForm" method="post">
             <input type="hidden" name="doc_ref" value="" />
             <input type="hidden" name="dreview_idx" value="" />
         </form>
         
		<c:choose>
			<c:when test="${ empty hreviewList && empty dreviewList }">
				<p>작성한 리뷰가 없습니다</p>
			</c:when>
			<c:otherwise>
				<ul class="my">
					<!-- 작성한 병원 리뷰 -->
					<c:forEach items="${ hreviewList }" var="row" varStatus="loop">
						<li>
				          <div class="info">
				            <div class="info_right">
				                <div class="info_top">
				                  <h4>${ row.hosp_name }</h4>
				                  <p>${ row.hosp_department }</p>
				                </div>
				            </div>
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
				            <div class="taginfo">
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
				              <div class="review_title">
				                <p>${ row.postdate }</p>
				                <c:if test="${ row.rewrite == 'T' }">
				                	<p class="edit">수정됨</p>
				                </c:if>
				              </div>
				            </div>
				            <c:if test="${ row.doctor != null }">
					            <div class="review_content">
					              <p>의료진 ${ row.doctor }</p>					
					            </div>
					        </c:if>
					        <c:if test="${ row.treat != null }">
					            <div class="review_content">
					              <p>치료 내용 ${ row.treat }</p>					
					            </div>
					        </c:if>
					        <c:if test="${ row.cost != null }">
					            <div class="review_content">
					              <p>비용 ${ row.cost }</p>					
					            </div>
					        </c:if>
				            <div class="review_content">
				              <p>${ row.content }</p>					
				            </div>
				            <div class="btn_wrap">
				              <button type="button" data-bs-toggle="modal" data-bs-target="#editHreviewModal"
								onclick="openHreviewEditModal(${ row.api_ref }, ${ row.review_idx }, ${ row.score }, '${ row.content }', '${ row.cost }', '${ row.treat }', '${ row.doctor }')">
									수정하기
								</button>
								<button type="button" onclick="deleteHreview(${ row.api_ref }, ${ row.review_idx });">
									삭제하기
								</button>
				            </div> 
				          </div>
				          <a href="">
				            <span class="blind">리뷰 바로가기</span>
				          </a>
				        </li>
					</c:forEach>
					
					<!-- 작성한 의사 리뷰 -->
					<c:forEach items="${ dreviewList }" var="row" varStatus="loop">
						<li>
				          <div class="info">
				            <div class="info_right">
				                <div class="info_top">
				                  <h4>${ row.doc_name }</h4>
				                  <p>${ row.hospname }</p>
				                </div>
				            </div>
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
				            <div class="taginfo">
	              				<!-- 해시태그 -->
								<c:if test="${ not empty hashtagList }">
									<ul class="review_hash">
										<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
											<c:if test="${ hashrow.dreview_ref == row.review_idx }">
												<li>
													<p>${ hashrow.tag }</p>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
				              <div class="review_title">
				                <p>${ row.postdate }</p>
				                <c:if test="${ row.rewrite == 'T' }">
				                	<p class="edit">수정됨</p>
				                </c:if>
				              </div>
				            </div>
				            <div class="review_content">
				              <p>${ row.content }</p>					
				            </div>
				            <div class="btn_wrap">
  				           		<button type="button" data-bs-toggle="modal" data-bs-target="#editDreviewModal"
                                             onclick="openDreviewEditModal(${ row.doc_ref }, ${ row.review_idx }, ${ row.score }, '${ row.content }')">
                                          수정하기
                                       </button>
                                 <button type="button" onclick="deleteDreview(${ row.doc_ref }, ${ row.review_idx });">
                                    삭제하기
                                 </button>
				            </div> 
				          </div>
				          <a href="">
				            <span class="blind">리뷰 바로가기</span>
				          </a>
				        </li>
					</c:forEach>
				</ul>
			</c:otherwise>
		</c:choose>
    </div>
  </div>
</main>
<%@include file="../common/main_footer.jsp" %>



<!-- 병원 리뷰 수정 모달창 -->
<form method="post" action="../mypage/editHreview.do" onsubmit="return validateReviewForm(this);">
	<input type="hidden" id="hreview_edit_api_ref" name="api_ref" value="" />
	<input type="hidden" name="hashtags" id="hreview_edit_hashtags" />
    <input type="hidden" id="hreview_edit_score" name="score" value="" />
	<div class="modal" id="editHreviewModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">병원 리뷰 수정</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<input type="hidden" id="hreview_edit_hreview_idx" name="review_idx" value="">
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
                    <textarea class="form-control" id="hreview_edit_doctor"  name="doctor" style="height: 20px;" placeholder="담당 의사를 입력해주세요"></textarea>
                    <textarea class="form-control" id="hreview_edit_treat" name="treat" style="height: 20px;" placeholder="치료 내용을 입력해주세요"></textarea>
                    <textarea class="form-control" id="hreview_edit_cost" name="cost" style="height: 20px;" placeholder="비용을 입력해주세요"></textarea>
					<textarea class="form-control" id="hreview_edit_content" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
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

<!-- 의사 리뷰 수정 모달창 -->
<form method="post" action="../mypage/editDreview.do" onsubmit="return validateReviewForm(this);">
   <input type="hidden" id="dreview_edit_doc_ref" name="doc_ref" value="" />
   <input type="hidden" id="dreview_edit_hashtags" name="hashtags" />
    <input type="hidden" id="dreview_edit_score" name="score" value="" />
   <div class="modal" id="editDreviewModal" >
      <div class="modal-dialog">
         <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
               <h4 class="modal-title">의사 리뷰 수정</h4>
               <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <!-- Modal Body -->
            <div class="modal-body">
               <input type="hidden" id="dreview_edit_dreview_idx" name="review_idx" value="">
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
               <textarea class="form-control" id="dreview_edit_content" name="content" style="height: 100px;" placeholder="내용을 입력해주세요 (필수입력)"></textarea>
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