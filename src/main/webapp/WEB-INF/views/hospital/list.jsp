<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 병원 찾기</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/hosp-list.css" />
<script>
// 시/구/군 동적 셀랙트
$(function() {
	$('#sido').change(function() {
		$.ajax({
			url : "../hospital/getGugun.do",
			type : "get",
			contentType : "text/html;charset:utf-8;",
			// 파라미터: 선택한 시도를 전달
			data : {
				sido : $('#sido option:selected').val()
			},
			dataType : "json",
			success : function(d) {
				var optionStr = "";
				optionStr += "<option value=''>";
				optionStr += "- 시/군/구 선택 -";
				optionStr += "</option>";
				$.each(d.result, function(index, data) {
					optionStr += '<option value="' + data.gugun + '">';
					optionStr += data.gugun;
					optionStr += '</option>';
				});
				// 구군 <select> 태그에 삽입
				$('#gugun').html(optionStr);
			},
			error : function(e) {
				alert("오류발생:" + e.status + ":" + e.statusText); 
			}
		});
	});
});

// 읍/면/동 동적 셀렉트
$(function() {
	$('#gugun').change(function() {
		$.ajax({
			url : "../hospital/getDong.do",
			type : "get",
			contentType : "text/html;charset:utf-8;",
			// 파라미터: 선택한 시도를 전달
			data : {
				gugun : $('#gugun option:selected').val()
			},
			dataType : "json",
			success : function(d) {
				var optionStr = "";
				optionStr += "<option value=''>";
				optionStr += "- 읍/면/동 선택 -";
				optionStr += "</option>";
				$.each(d.result, function(index, data) {
					optionStr += '<option value="' + data.dong + '">';
					optionStr += data.dong;
					optionStr += '</option>';
				});
				// 구군 <select> 태그에 삽입
				$('#dong').html(optionStr);
			},
			error : function(e) {
				alert("오류발생:" + e.status + ":" + e.statusText); 
			}
		});
	});
});

// 필터 버튼 클릭
document.addEventListener('DOMContentLoaded', function() {
    const filterButtons = document.querySelectorAll('.filter-button');
    const filtersHiddenInput = document.getElementById('filters');
    let selectedFilters = [];

    // 버튼 클릭 시 처리
    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            const filterValue = button.getAttribute('data-filter');
            // 이미 선택된 조건인 경우 색상 원래대로 되돌리기
            if (selectedFilters.includes(filterValue)) {
                selectedFilters = selectedFilters.filter(h => h !== filterValue);
                button.style.backgroundColor = ''; // 원래 색상으로 변경
                button.style.color = ''; // 원래 텍스트 색상으로 변경
                button.style.border = '';
            }
            else {
                // 선택되지 않은 조건인 경우 추가
                selectedFilters.push(filterValue);
                button.style.backgroundColor = '#005ad5'; // 선택된 색상으로 변경
                button.style.color = '#fff'; // 텍스트 색상 변경
                button.style.border = 'none';
            }
            // 필터 값을 숨겨진 input에 저장
            filtersHiddenInput.value = selectedFilters.join(',');
            // 검색 함수 호출
            searchHosp();
        });
    });
});

// 검색
function searchHosp(event) {
	// 기본 제출 동작 방지
    if (event) { // event가 정의된 경우에만 preventDefault 호출
        event.preventDefault();
    }
    const form = document.forms['searchForm'];
    const formData = new FormData(form);
 	// 필터 값을 추가
    formData.append('filters', document.getElementById('filters').value);
    // AJAX 요청
    $.ajax({
        url: "../hospital/searchHosp.do",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "html", // HTML로 응답 받기
        success: function(response) {
            const listElement = document.querySelector('.search_result');
            listElement.innerHTML = ''; // 기존 내용 제거
            listElement.innerHTML = response; // 서버에서 받은 HTML 그대로 삽입
        },
        error: function(e) {
            alert("오류 발생: " + e.status + ": " + e.statusText);
        }
    });
}

</script>
  	
</head>
<body>
<%@include file="../common/main_header.jsp" %>
<main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="list_title">
				<h2>병원 찾기</h2>
				<p>병원명, 지역명, 해시태그 등으로 검색해보세요</p>
			</div>
			
			<div class="list_search">
				<form class="searchForm" name="searchForm">
					<div class="search_city">
						<!-- 주소 선택 -->
						<select id="sido" name="searchSido" class="searchField">
							<option value="">--- 시/도 선택 ---</option>
							<c:forEach items="${ sidoLists }" var="sidoRow">
								<option value="${ sidoRow.sido }">${ sidoRow.sido }</option>
							</c:forEach>
						</select>
						<select id="gugun" name="searchGugun" class="searchField">
							<option value="">--- 시/군/구 선택 ---</option>
						</select>
						<select id="dong" name="searchDong" class="searchField">
							<option value="">--- 읍/면/동 선택 ---</option>
						</select>
					</div>
					<div class="search_hosp">
						<!-- 검색 -->
						<select class="searchField" name="searchField">
							<option value="name">--- 조건 선택 ---</option>
							<option value="name">병원명</option>
							<option value="department">진료과목</option>
							<option value="hashtag">해시태그</option>
						</select>
						<input name="searchWord" class="searchKeyword" type="text" placeholder="검색어를 입력하세요.">
						<button type="submit" class="search_btn" onclick="searchHosp(event)"><span class="blind">검색</span></button>
					</div>
					<div class="other_search">
						<button type="button" class="filter-button" data-filter="parking" data-default-text="주차 가능">주차</button>
						<button type="button" class="filter-button" data-filter="pcr" data-default-text="PCR 검사 가능">PCR 검사</button>
						<button type="button" class="filter-button" data-filter="hospitalize" data-default-text="입원 가능">입원</button>
						<button type="button" class="filter-button" data-filter="system" data-default-text="예약 가능">예약</button>
						<button type="button" class="filter-button" data-filter="night" data-default-text="예약 가능">야간진료</button>
						<button type="button" class="filter-button" data-filter="weekend" data-default-text="예약 가능">주말진료</button>
					</div>
					<input type="hidden" name="filters" id="filters" value="">
				</form>
			</div>
			
			<div class="search_result">
				<div class="list">
					<c:choose>
						<c:when test="${ empty hospList }">
							<div>
								<p>검색 결과가 없습니다</p>
							</div>
						</c:when>
						<c:otherwise>
							<ul class="hospital">
								<c:forEach items="${ hospList }" var="row" varStatus="loop">
									<li>
										<span class="img">
											<c:if test="${ row.photo == null }">
												<img src="/images/hospital.png" alt=""></img>
											</c:if>
											<c:if test="${ row.photo != null }">
												<img src="/uploads/${ row.photo }">
											</c:if>
										</span>
										
										
										<div class="info">
											<div class="info_top">
												<div class="hosp_name">
													<h3>${ row.name }</h3>
													<!-- 입점한 병원 인증마크 표시 -->
													<c:if test="${ row.enter == 'T' }">
														<span class="approve"></span>
													</c:if>
												</div>
												<div class="depdis">
													<p>${ row.department }</p>
												</div>
											</div>
											<div class="detail">
												<div class="details">
													<p class="blue">전화</p>
													<p>${ row.tel }</p>
												</div>
												<div class="details">
													<p class="blue">주소</p>
													<p class="address">${ row.address }</p>
												</div>
											</div>
											<!-- 입점한 병원 좋아요 리뷰 수 표시 -->
											<c:if test="${ row.enter == 'T' }">
												<div class="info_right">
													<p class="like">${ row.likecount }</p>
													<p class="star">${ row.score } (${ row.reviewcount })</p>
												</div>
												
												<!-- 해시태그 -->
												<c:if test="${ not empty hashtagList }">
													<div class="hashtag">
														<ul>
															<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
																<c:if test="${ hashrow.hosp_ref == row.id }">
																	<li class="hash">
																		<p>${ hashrow.tag }</p>
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</div>
												</c:if>
											</c:if>
											<div class="info_right">
												<p class="like">${ row.likecount }</p>
												<p class="star">${ row.score } (${ row.reviewcount })</p>
											</div>
										</div>
										
										<!-- 이거 요청명 수정해야 함 -->
										<a href="./hospital/viewHosp.do?api_idx=${ row.api_idx }"><span class="blind">병원 바로가기</span></a>
									</li>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
				
				<!-- 페이지네이션 -->
				<div class="pagination">
					<div class="pagination_inner">
						${ pagingImg }
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<%@include file="../common/main_footer.jsp" %>
</body>
</html>