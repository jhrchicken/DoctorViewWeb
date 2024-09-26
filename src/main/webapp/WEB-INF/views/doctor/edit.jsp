<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-view.css" />
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	
	<main id="container">
		<div class="content">
			<!-- 게시글 -->
			<h2>의료진 정보 수정하기</h2>	
			<div class="board_inner">
				<form name="deleteDoctorForm">
					<input type="hidden" name="doc_idx" value="${ doctorDTO.doc_idx }" />
				</form>
				
				<table class="board">
					<!-- 게시글 정보 -->
					<tr>
						<td class="left">이름</td>
						<td colspan="3"><input type="text" name="name" value="${ doctorDTO.name }" /></td>
					</tr>
					<tr>
						<td class="left">전공</td>
						<td colspan="3"><input type="text" name="major" value="${ doctorDTO.major }" /></td>
						
					</tr>
					<tr>
						<td class="left">경력</td> <td><input type="text" name="career" value="${ doctorDTO.career }" /></td>
						<td class="left">시간</td> <td><input type="text" name="hours" value="${ doctorDTO.hours }" /></td>
					</tr>
					 
					 
<!-- 내용 뭘 넣징 --> 
<tr>
	<td class="left">내용</td>
	<td class="board_content" colspan="3">비었음</td>
					
					
				</table>
				<!-- 하단 메뉴(버튼) -->
				<div class="board_btn">
					<button type="button" onclick="location.href='../doctor.do';">뒤로가기</button>
					<button type="button" onclick="location.href='../doctor/editDoctor.do?doc_idx=${ param.doc_idx }';">수정하기</button>
				</div>
				
			</div>
		</div>		
	</main>
    <%@include file="../common/main_footer.jsp" %>
    
</body> 
</html>