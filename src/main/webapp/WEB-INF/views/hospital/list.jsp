<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
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
            const listElement = document.querySelector('.hosp_list');
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
			<h2>병원 찾기</h2>
			<h3>병원명, 지역명, 해시태그 등으로 검색해보세요</h3>
			
			<!-- 검색 메뉴 -->
			<div class="search_menu">
				<form class="search_form" name="searchForm">
					<!-- 지역 선택 -->
					<div class="search_region">
						<select class="search_field" id="sido" name="searchSido">
							<option value="">-- 시/도 선택 --</option>
							<c:forEach items="${ sidoLists }"> var="sido">
								<option value="${ sido.sido }">${ sido.sido }</option>
							</c:forEach>
						</select>
						<select id="gugun" name="searchGugun" class="search_field">
							<option value="">-- 시/군/구 선택 --</option>
						</select>
						<select id="dong" name="searchDong" class="search_field">
							<option value="">-- 읍/면/동 선택 --</option>
						</select>
					</div>
					
					<!-- 키워드 검색 -->
					<div class="search_keyword">
						<select class="search_field" name="searchField">
							<option value="name">-- 검색 조건 선택 --</option>
							<option value="name">병원명</option>
							<option value="department">진료과목</option>
							<option value="hashtag">해시태그</option>
						</select>
						<input type="text" class="search_word" name="searchWord" placeholder="검색어를 입력하세요.">
						<button type="submit" class="search_btn" onclick="searchHosp(event)"></button>
					</div>
					
					<!-- 검색 필터 -->
					<div class="search_filter">
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
			
			<!--  병원 목록 -->
			<div class="hosp_wrap">
				<div class="hosp_list">
					<c:choose>
						<c:when test="${ empty hospList }">
							<div>
								<p>검색 결과가 없습니다</p>
							</div>
						</c:when>
						<c:otherwise>
							<ul class="hosp">
								<c:forEach items="${ hospList }" var="row" varStatus="loop">
									<li onclick="location.href='./hospital/viewHosp.do?api_idx=${ row.api_idx }'">
										<!-- 병원 사진 -->
										<div class="hosp_photo">
											<c:if test="${ row.photo == null }">
												<!-- <img src="/images/hosp.png" alt=""> -->
											</c:if>
											<c:if test="${ row.photo != null }">
												<img src="/uploads/${ row.photo }" alt="">
											</c:if>
										</div>
										<!-- 병원 정보 -->
										<div class="hosp_info">
											<div class="hosp_name">
												<p>${ row.name }</p>
												<c:if test="${ row.enter == 'T' }">
													<span class="hosp_mark"></span>
												</c:if>
											</div>
											<div class="hosp_dept">
												<p>${ row.department }</p>
											</div>
											<div class="hosp_tel">
												<p class="sub_tit">전화</p>
												<div class="divider"></div>
												<p>${ row.tel }</p>
											</div>
											<div class="hosp_addr">
												<p class="sub_tit">주소</p>
												<div class="divider"></div>
												<p>${ row.address }</p>
											</div>
											<!-- 찜과 리뷰 -->
											<div class="info_right">
												<div class="like">
													<img src="/images/mark_full.svg" alt="">
													<p>${ row.likecount }</p>
												</div>
												<div class="review">
													<img src="/images/star.svg" alt="">
													<p>${ row.score }</p>
													<p class="count">(${ row.reviewcount })</p>
												</div>
											</div>
											<!-- 해시태그 -->
											<c:if test="${ row.enter == 'T' }">
												<c:if test="${ not empty hashtagList }">
													<div class="hosp_hashtag">
														<ul>
															<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
																<c:if test="${ hashrow.hosp_ref == row.id }">
																	<li class="tag">
																		<p># ${ hashrow.tag }
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</div>
												</c:if>
											</c:if>
										</div>
									</li>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
				
				<!-- 더보기 버튼 -->
				<div class="btn_wrap">
					<a class="more_btn" href="">
						<span>더보기</span>
					</a>
				</div>
			</div>
		
		</div>
		
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>