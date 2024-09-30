<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 예약하기</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/doc-list.css" />
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<div class="list_title">
				<h2>병원 예약하기</h2>
			</div>
			
			<form name="proceedFrm" method="post" 
				action="#" onsubmit="return validateForm(this);">
			<table border="1">
			    <tr>
			    	<th>병원명</th>
			    	<td>
			    		<p>병원 1</p>
			    		<input type="hi-dden" name="hospname" value="선택한 병원명" placeholder="" readonly/>
			    	</td>
			    </tr>
			    <tr>
			    	<th>의료진</th>
			    	<td>
			    		<label>
	                   		<input id="의사1"  type="radio" name="doctorname" value="의사1" />
	                   		<label for="의사1">의사1</label>
	                  	</label>
	                  	<label>
		                    <input id="의사2" type="radio" name="doctorname" value="의사2" />
		                    <label for="의사2">의사2</label>
	                  	</label>
			    	</td>
			    </tr>
			    <tr>
			    	<th>방문자</th>
			    	<td><input type="text" name="username" value="${userName} " placeholder="" /></td>
			    </tr>
			    <tr>
			    	<th>코로나 검사</th>
			    	<td><input type="text" name="pcr" value="${ hospDatilInfo.pcr }" placeholder="" /></td>
			    </tr>
			    <tr>
			    	<th>입원 가능 여부</th>
			    	<td><input type="text" name="hospitalize" value="${ hospDatilInfo.hospitalize }" placeholder="" /></td>
			    </tr>
			    <tr>
			    	<th>예약제 여부</th>
			    	<td><input type="text" name="system" value="${ hospDatilInfo.system }" placeholder="" /></td>
			    </tr>
			    
			</table>
			<input type="submit" value="수정하기" />
			</form>
			
			
			
			
		</div>
	</div>
</main>

<%@include file="../common/main_footer.jsp" %>
</body>
</html>