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
$(function() {
	$('#sido').change(function() {
		$.ajax({
			url : "./getGugun.do",
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
				optionStr += "- 구/군 선택 -";
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
						<!-- 광역시도 선택 (필수) -->
						<select id="sido" name="searchSido" class="searchField">
							<option value="sido">- 시/도 선택 -</option>
							<c:forEach items="${ sidoLists }" var="sidoRow">
								<option value="${ sidoRow.sido }">
									${ sidoRow.sido }
								</option>
							</c:forEach>
						</select>
						<select id="gugun" name="searchGugun" class="searchField">
							<option value="">- 구/군 선택 -</option>
						</select>
										
						<input name="searchWord" class="searchKeyword" type="text" placeholder="병원명을 검색하세요.">
						<input type="submit" class="search_btn" value="">
					</div>
				</form>
			</div>
			
			
			
			
			
			<div class="list">
        <div class="other_search">
          <form class="searchForm" name="searchForm">
            <select class="searchField" name="searchDepart">
              <option value="department">-- 진료과목 선택 --</option>
              <option value="in">내과</option>
              <option value="out">외과</option>
              <option value="bone">정형외과</option>
              <option value="skin">피부과</option>
              <option value="ear">이비인후과</option>
              <option value="face">성형외과</option>
              <option value="teeth">치과</option>
            </select>
            <select name="searchTag" class="searchField">
              <option value="tag">-- 해시태그 선택 --</option>
              <option value="cold">감기</option>
              <option value="head">두통</option>
              <option value="tooth">치통</option>
              <option value="stomach">복통</option>
            </select>
            <select name="searchPark" class="searchField">
              <option value="park">-- 주차 선택 --</option>
              <option value="yesPark">주차 가능</option>
              <option value="noPark">주차 불가능</option>
            </select>
            <select name="searchPcr" class="searchField">
              <option value="pcr">-- PCR 검사 선택 --</option>
              <option value="yesPcr">PCR 검사 가능</option>
              <option value="noPcr">PCR 검사 불가능</option>
            </select>
            <select name="searchBed" class="searchField">
              <option value="bed">-- 입원 선택 --</option>
              <option value="yesBed">입원 가능</option>
              <option value="noBed">입원 불가능</option>
            </select>
            <select name="searchReserv" class="searchField">
              <option value="reserv">-- 예약 선택 --</option>
              <option value="yesReserv">예약 가능</option>
              <option value="noReserv">예약 불가능</option>
            </select>
            <!-- 검색 + 페이징 처리를 위한 hidden 박스인듯 -->
            <!-- <input type="hidden" name="page" value="1"> -->
            <input type="submit" class="search_btn" value="적용">
          </form>
        </div>
			
			
			
			<div class="list">
				<c:choose>
					<c:when test="${ empty hospList }">
						<tr>
							<p>검색 결과가 없습니다</p>
						</tr>
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
												<!-- 거리 정보가 있을 때만 쩜 나오게 처리해주세욧!!!!!!!!! -->
												<p>•</p>
												<p>${ row.distance }</p>
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
</main>
<%@include file="../common/main_footer.jsp" %>
</body>
</html>