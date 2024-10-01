<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>닥터뷰 | 마이페이지</title>
<%@ include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/edit-hosp.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
// 	폼값 검증
function validateForm(form) {
	if (form.password.value == '') {
		alert("비밀번호를 입력하세요.");
		form.password.focus();
		return false;
	}
// 	var password_pattern =  /^[a-zA-Z0-9]{8,20}$/;
// 	if (!password_pattern.test(form.password.value)) {
// 	    alert("비밀번호는 영문자와 숫자가 포함되어야 하며, 8~20자여야 합니다.");
// 	    form.password.focus();
// 	    return false;
// 	}
	if (form.passwordCheck.value == '') {
		alert("비밀번호가 일치하지않습니다.");
		form.passwordCheck.focus();
		return false;
	}
	return true;
}
</script>
</head>
<body>
<%@ include file="../common/main_header.jsp" %>
	
<main id="container">
  <div class="content">
    <div class="content_inner">
      <div class="login_wrap">
      	<h2>병원정보 수정</h2>
    
	    <c:if test="${ not empty editUserFaild }">
			<!-- 글자색 css 변경필요 -->
	  		<p><b>${ editUserFaild }</b></p>
	    </c:if>
	        
	        
		<form name="joinFrm" method="post" enctype="multipart/form-data"
				action="../../member/editdosp.do" onsubmit="return validateForm(tdis);">
			<p>*필수 입력사항</p>
			<table class="regist">
				<tr>
					<td class="left">아이디</td>
					<td class="id">
						<input type="text" name="id" value="${ loginUserInfo.id }" maxlength="15" readonly/>
					</td>
				</tr>
				<tr class="pass">
					<td rowspan="2" class="left">비밀번호</td>
					<td><input type="password" name="password" maxlength="20" value="" placeholder="비밀번호* (영문+숫자, 특수문자(선택), 8~20자)"/></td>
				</tr>
				<tr>
					<td><input type="password" name="passwordCheck" maxlength="20" value="" placeholder="비밀번호 확인*"/></td>
				</tr>
				<tr>
					<td class="left">이름</td>
					<td><input type="text" name="name" value="${ loginUserInfo.name }" placeholder="이름*"/></td>
				</tr>
				<tr>
					<td class="left">전화번호</td>
					<td class="mobile">
						<input type="tel" name="tel1" maxlength="3" value="${ tel[0] }" placeholder="010"/> -
						<input type="tel" name="tel2" maxlength="4" value="${ tel[1] }" placeholder="전화번호*" /> -
						<input type="tel" name="tel3" maxlength="4" value="${ tel[2] }" />
					</td>
				</tr>
				<tr>
					<td class="left">주소</td>
					<td><input type="text" name="address" value="${ loginUserInfo.address }" placeholder="주소*"/></td>
				</tr>
				<tr>
					<td class="left">진료과목</td>
					<td><input type="text" name="department" value="${ loginUserInfo.department }" placeholder="진료과목*" /></td>
				</tr>
				<tr>
					<td class="left">사업자 번호</td>
					<td class="regi">
						<input type="text" name="taxid1" value="${ taxid[0] }" placeholder="사업자번호*" readonly/> -
						<input type="text" name="taxid2" value="${ taxid[1]  }" placeholder="사업자번호*" readonly/> -
						<input type="text" name="taxid3" value="${ taxid[2]  }" placeholder="사업자번호*" readonly/>
					</td>
				</tr>
			
				<!-- 영업시간 폼 시작 -->
			    <tr class="time">
			    	<td rowspan="4" class="left">영업시간</td>
			     	<td>
			       		요일:  
						<c:if test="${not empty weeks}">
						    <script>
						        $(document).ready(function() {
						            var weeks = ["${fn:join(weeks, '","')}" ];
						            
						            if (weeks.includes("월요일")) {
						                $('#monday').prop('checked', true);
						            }
						            if (weeks.includes("화요일")) {
						                $('#tuesday').prop('checked', true);
						            }
						            if (weeks.includes("수요일")) {
						                $('#wednesday').prop('checked', true);
						            }
						            if (weeks.includes("목요일")) {
						                $('#tdursday').prop('checked', true);
						            }
						            if (weeks.includes("금요일")) {
						                $('#friday').prop('checked', true);
						            }
						            if (weeks.includes("토요일")) {
						                $('#saturday').prop('checked', true);
						            }
						            if (weeks.includes("일요일")) {
						                $('#sunday').prop('checked', true);
						            }
						        });
						    </script>
						</c:if>
						<label class="checkbox_wrap">
				         	<input id="monday" type="checkbox" name="weeks" value="월요일" />
				         	<label for="monday">월</label>
						</label>
				      	<label class="checkbox_wrap">
					        <input id="tuesday" type="checkbox" name="weeks" value="화요일" />
					        <label for="tuesday">화</label>
				      	</label>
				        <label class="checkbox_wrap">
					      	<input id="wednesday" type="checkbox" name="weeks" value="수요일" />
					      	<label for="wednesday">수</label>
				      	</label>
				        <label class="checkbox_wrap">
				        	<input id="tdursday" type="checkbox" name="weeks" value="목요일" />
				        	<label for="tdursday">목</label>
				      	</label>
				        <label class="checkbox_wrap">
				        	<input id="friday" type="checkbox" name="weeks" value="금요일" />
				        	<label for="friday">금</label>
				      	</label>
				        <label class="checkbox_wrap">
				        	<input id="saturday" type="checkbox" name="weeks" value="토요일" />
				        	<label for="saturday">토</label>
				      	</label>
				        <label class="checkbox_wrap">
				        	<input id="sunday" type="checkbox" name="weeks" value="일요일" />
				        	<label for="sunday">일</label>
				      	</label>
				     </td>
   				</tr>
	   			<tr class="time">
					<td>
				    	진료 시간: 
			       		<input type="time" name="starttime" value="${ starttime }" />
				        ~ 
				        <input type="time" name="endtime" value="${ endtime }" />
			        </td>
	   			</tr>
				<tr class="time">
	     			<td>
	       				휴게 시간: 
	       				<input type="time" name="startbreak" value="${ startbreak }" />
				        ~ 
				        <input type="time" name="endbreak" value="${ endbreak }" />
				    </td>
			    </tr>
			    <tr class="time">
			    	<td>
			        	접수 마감: <input type="time" name="deadline" value="${ deadline }" />
			     	</td>
			    </tr>
		    
		    
			    <!-- 추가사항 -->
			    <!-- ********* 병원 이미지 추가 필요 ********* -->
			    <tr>
			    	<td class="left">사진</td>
			    	<td>
			    		<div class="image">
			    			<c:if test="${ hospDatilInfo.photo == null || hospDatilInfo.photo == '' }">
				    			<!-- 병원.. 병원 기본 이미지 이거 맞나..?? -->
							    <img src="/images/hospital.png" alt="" />
							</c:if>
							<c:if test="${ hospDatilInfo.photo != null && hospDatilInfo.photo != '' }">
							    <img src="/uploads/${ hospDatilInfo.photo }"  />
							</c:if>
				    		<input type="file" name="file" value="${ hospDatilInfo.photo }" />
			    		</div>
			    	</td>
			    </tr>
			    <tr>
			    	<td class="left">소개</td>
			    	<td><input type="text" name="introduce" value="${ hospDatilInfo.introduce }" /></td>
			    </tr>
			    <tr>
			    	<td class="left">오시는 길</td>
			    	<td><input type="text" name="traffic" value="${ hospDatilInfo.traffic }" placeholder="ex ) 00역에서 도보 10분" /></td>
			    </tr>
			    <tr>
			    	<td class="left">주차</td>
			    	<td><input type="text" name="parking" value="${ hospDatilInfo.parking }" placeholder="ex ) 건물 내 주차 공간 있음" /></td>
			    </tr>
			    <tr>
			    	<td class="left">PCR 검사</td>
			    	<td><input type="text" name="pcr" value="${ hospDatilInfo.pcr }" placeholder="ex ) 가능 / 불가능" /></td>
			    </tr>
			    <tr>
			    	<td class="left">입원</td>
			    	<td><input type="text" name="hospitalize" value="${ hospDatilInfo.hospitalize }" placeholder="ex ) 가능 / 불가능" /></td>
			    </tr>
			    <tr>
			    	<td class="left">예약 방문</td>
			    	<td><input type="text" name="system" value="${ hospDatilInfo.system }" placeholder="ex ) 가능 / 불가능" /></td>
			    </tr>
		    
			    <!-- 의료진 추가 -->
			    <tr>
			    	<td class="left">의사</td>
		      		<!-- 의료진 관리 - 수정 페이지로 이동 --> 
			      	<td class="doctors">
			      		<a href="/member/doctorInfo.do">의사 등록 및 수정하기</a>
		      		</td>
			    </tr>
			</table>
			<div class="btn_wrap">
				<input type="submit" value="수정완료" />
			</div>
		</form>
  	  </div>
    </div>
  </div>
</main>	

<%@ include file="../common/main_footer.jsp" %>	
</body>
</html>