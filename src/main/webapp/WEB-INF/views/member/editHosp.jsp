<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 마이페이지</title>
<script>
// 	폼값 검증
function validateForm(form) {
	if (form.password.value == '') {
		alert("비밀번호를 입력하세요.");
		form.password.focus();
		return false;
	}
	var password_pattern =  /^[a-zA-Z0-9]{8,20}$/;
	if (!password_pattern.test(form.password.value)) {
	    alert("비밀번호는 영문자와 숫자가 포함되어야 하며, 8~20자여야 합니다.");
	    form.password.focus();
	    return false;
	}
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
    <h2>병원정보 수정</h2>
    <!-- 로그인 실패 시 메시지 -->
    <c:if test="${ not empty editUserFaild }">
		<!-- 글자색 css 변경필요 -->
		<p><b>${ editUserFaild }</b></p>
    </c:if>
	        
	        
<form name="joinFrm" method="post" action="../../member/editUser.do" onsubmit="return validateForm(this);">
<table border="1">
	<tr>
		<th>아이디</th>
		<td>
			<input type="text" name="id" value="${loginUserInfo.id }" maxlength="15" readonly/>
		</td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" name="password" maxlength="20" value="" placeholder="비밀번호"/></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" name="passwordCheck" maxlength="20" value="" placeholder="비밀번호 확인"/></td>
	</tr>
	<tr>
		<th>병원명</th>
		<td><input type="text" name="name" value="${loginUserInfo.name }" placeholder="병원명"/></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>
		<input type="tel" name="tel1" maxlength="3" value="${ tel[0] }" placeholder="010"/> -
		<input type="tel" name="tel2" maxlength="4" value="${ tel[1] }" placeholder="0000"/> -
		<input type="tel" name="tel3" maxlength="4" value="${ tel[2] }" placeholder="0000"/>
		</td>
	</tr>
	<tr>
		<th>주소</th>
		<td><input type="text" name="address" value="${loginUserInfo.address }" placeholder="ex) 서울특별시"/></td>
	</tr>
	<tr>
		<th>진료과목</th>
		<td><input type="text" name="department" value="${loginUserInfo.department }"placeholder="진료과목*" /></td>
	</tr>
	<tr>
		<th>사업자 번호</th>
		
		<td>
			<!-- 사업자번호 input 길이 조정 필요 -->
<input type="text" name="taxid1" value="${taxid[0] }" placeholder="사업자번호*" /> -
<input type="text" name="taxid2" value="${taxid[1]  }" placeholder="사업자번호*" /> -
<input type="text" name="taxid3" value="${taxid[2]  }" placeholder="사업자번호*" />

		</td>
	</tr>
	<!-- 영업시간 폼 시작 -->
    <tr class="time">
      <th rowspan="5" class="left">영업시간</th>
      <td>
         요일:  
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
          	<input id="thursday" type="checkbox" name="weeks" value="목요일" />
          	<label for="thursday">목</label>
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
    <tr>
	  <td>
        진료 시간: 
        <input type="time" name="starttime" value="${hoursDTO.starttime }" />
         ~ 
        <input type="time" name="endtime" value="${hoursDTO.endtime }" />
      </td>
    <tr>
	<tr>
      <td>
        휴게 시간: 
        <input type="time" name="startbreak" value="" />
         ~ 
        <input type="time" name="endbreak" value="" />
      </td>
    </tr>
    <tr>
      <td>
        접수 마감: <input type="time" name="deadline" value="" />
      </td>
    </tr>
    <!-- 의료진 추가 -->
    <tr>
      <th>의료진</th>
      <!-- 의료진 관리 - 수정 페이지로 이동  -->
      <td><a href="">의료진 관리</a></td>
    </tr>
</table>
<input type="submit" value="수정하기" />






</form>

</body>
</html>