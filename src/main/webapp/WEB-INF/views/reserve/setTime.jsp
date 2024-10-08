<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 예약관리</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/reserve-setTime.css" />

<script>
//  ****************** 달력 관련 ******************  
    document.addEventListener("DOMContentLoaded", function() {
        buildCalendar();
        
        document.getElementById("btnPrevCalendar").addEventListener("click", function(event) {
            prevCalendar();
        });
        
        document.getElementById("nextNextCalendar").addEventListener("click", function(event) {
            nextCalendar();
        });
    });
    
    var toDay = new Date(); // @param 전역 변수, 오늘 날짜 / 내 컴퓨터 로컬을 기준으로 toDay에 Date 객체를 넣어줌
    var nowDate = new Date();  // @param 전역 변수, 실제 오늘날짜 고정값
    
    // @brief   이전달 버튼 클릭시
    function prevCalendar() {
        this.toDay = new Date(toDay.getFullYear(), toDay.getMonth() - 1, toDay.getDate());
        buildCalendar();    // @param 전월 캘린더 출력 요청
    }

    // @brief   다음달 버튼 클릭시
    function nextCalendar() {
        this.toDay = new Date(toDay.getFullYear(), toDay.getMonth() + 1, toDay.getDate());
        buildCalendar();    // @param 명월 캘린더 출력 요청
    }

     /*
     @brief   캘린더 오픈
     @details 날짜 값을 받아 캘린더 폼을 생성하고, 날짜값을 채워넣는다.
     */
     
     // *************** 선택된 병원의 근무요일만 활성화 *************** 
     var weeks = [${week}];

	function buildCalendar() {
	   let doMonth = new Date(toDay.getFullYear(), toDay.getMonth(), 1); // 이번 달의 첫 번째 날
	   let lastDate = new Date(toDay.getFullYear(), toDay.getMonth() + 1, 0); // 이번 달의 마지막 날
	
	   let tbCalendar = document.querySelector(".scriptCalendar > tbody"); // 캘린더 테이블 본문
	   document.getElementById("calYear").innerText = toDay.getFullYear(); // 년도 표시
	   document.getElementById("calMonth").innerText = autoLeftPad((toDay.getMonth() + 1), 2); // 월 표시
	
	   // 이전 캘린더 데이터를 삭제
	   while (tbCalendar.rows.length > 0) {
	       tbCalendar.deleteRow(tbCalendar.rows.length - 1);
	   }
	
	   let row = tbCalendar.insertRow(); // 첫 번째 행
	   let dom = 1; // 요일 카운터
	   let daysLength = (Math.ceil((doMonth.getDay() + lastDate.getDate()) / 7) * 7) - doMonth.getDay(); // 캘린더에 표시할 총 일 수
	
	   for (let day = 1 - doMonth.getDay(); daysLength >= day; day++) {
	       let column = row.insertCell();
	
	       // 현재 달의 유효한 날
	       if (Math.sign(day) == 1 && lastDate.getDate() >= day) {
	           column.innerText = autoLeftPad(day, 2); // 날짜 표시
	
	           let currentDate = new Date(toDay.getFullYear(), toDay.getMonth(), day); // 현재 날짜 계산
	
	           // 요일 계산
	           let dayOfWeek = new Date(toDay.getFullYear(), toDay.getMonth(), day).getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일
	           let korWeekday = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"][dayOfWeek];
	
	           // 오늘 이후 날짜일 경우 && 선택 가능한 요일인지 확인
	           if (currentDate >= nowDate && weeks.includes(korWeekday)) {
	               column.onclick = function () { calendarChoiceDay(this); };
	               // 오늘 이후 날짜 배경 색상
	               column.classList.add("future")
	           } else {
	               // 오늘 이전 날짜 또는 선택 불가능한 요일
	               column.classList.add("past");
	           }
	
	           // 오늘 날짜일 경우
	           if (day === nowDate.getDate() && toDay.getMonth() === nowDate.getMonth() && toDay.getFullYear() === nowDate.getFullYear()) {
	               column.onclick = function () { calendarChoiceDay(column); }; // 오늘 날짜도 선택 가능
	               calendarChoiceDay(column); // 오늘 날짜 자동 선택
	           }
	       } else {
	           // 이전 또는 다음 달 날짜 처리
	           let exceptDay = new Date(doMonth.getFullYear(), doMonth.getMonth(), day);
	           column.innerText = autoLeftPad(exceptDay.getDate(), 2);
	           column.classList.add("prevnext")
	       }
	
	       // 일요일
	       if (dom % 7 == 1) {
	    	   column.classList.add("sunday");
	       }
	
	       // 토요일
	       if (dom % 7 == 0) {
	    	   column.classList.add("saturday");
	           row = tbCalendar.insertRow(); // 주가 끝날 때마다 새 행 추가
	       }
	
	       dom++;
	    }
	}


    	// 날짜 선택 함수 (기본적으로 오늘 선택)
    	// 날짜 선택 함수 수정 (선택된 날짜를 hidden input에 설정)
   	    function calendarChoiceDay(column) {
		    if (document.getElementsByClassName("choiceDay")[0]) {
		        // 이전에 선택된 날짜가 있을 경우 초기화
		        document.getElementsByClassName("choiceDay")[0];  
		        document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");
		    }
		    // 선택한 날짜 강조
		    column.classList.add("choiceDay");
		
		    // 선택한 날짜를 hidden input에 설정
		    const year = document.getElementById("calYear").innerText;
		    const month = document.getElementById("calMonth").innerText;
		    const day = column.innerText.trim(); // 공백 제거
		    
		    const formattedDate = year + "-" + month + "-" +  day;
		    
// 		    선택한 날짜를 input에 설정
		    document.getElementById("selectedDate").value = formattedDate;
		}


     /*
     @brief   숫자 두자릿수( 00 ) 변경
     @details 자릿수가 한자리인 ( 1, 2, 3등 )의 값을 10, 11, 12등과 같은 두자리수 형식으로 맞추기위해 0을 붙인다.
     @param   num     앞에 0을 붙일 숫자 값
     @param   digit   글자의 자릿수를 지정 ( 2자릿수인 경우 00, 3자릿수인 경우 000 … )
     */
    function autoLeftPad(num, digit) {
        if(String(num).length < digit) {
            num = new Array(digit - String(num).length + 1).join("0") + num;
        }
        return num;
    }
     
	//  ****************** 폼값 검증 ******************  
	function validateForm(form) {
		
		// 의사 선택 검증
	    const doctorname = form.doctorname;  
	    let doctorChecked = false;
	    if (doctorname.length) {
	        for (let i = 0; i < doctorname.length; i++) {
	            if (doctorname[i].checked) {
	                doctorChecked = true;
	                break;
	            }
	        }
	    } else {
	        doctorChecked = doctorname.checked;
	    }
	    if (!doctorChecked) {
	        alert("진료받을 의사를 선택하세요.");
	        return false;
	    }
		 
		// 시간 선택 검증
		const posttime = form.posttime;  
		let timeChecked = false;
		for (let i = 0; i < posttime.length; i++) {
		    if (posttime[i].checked) {
		    	timeChecked = true;
		        break;
		    }
		}
		if (!timeChecked) {
			alert("진료받을 시간을 선택하세요.");
			return false;
		}
		
		// 예약자 정보 검증
		if (form.username.value == '') {
			alert("방문자 이름을 입력하세요.");
			form.username.focus();
			return false;
		}
		if (form.tel.value == '') {
			alert("방문자 전화번호를 입력하세요.");
			form.tel.focus();
			return false;
		}
		if (form.rrn.value == '') {
			alert("방문자 주민등록번호 입력하세요.");
			form.rrn.focus();
			return false;
		}
	
		return true;
	}
</script>
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<h2>병원 예약관리</h2>
			
			<form name="setTimeFrm" method="post" 
				action="/reserve/setTime.do">
			

				<!-- 병원명/아이디 전달 -->
				<input type="hidden" name="hosp_ref" value="${ hospitalInfo.id }" placeholder="" readonly/>
				<input type="hidden" name="hospname" value="${ hospitalInfo.name }" placeholder="" readonly/>
      				
	      		<!-- 예약 폼 -->
				<div class="reservation">
		          <!-- ************************************* 캘린더 ************************************ -->
		          	<div class="calendar">
						<div class="calendar_top">
						   <button type="button" class="prev_btn" id="btnPrevCalendar">
						      <img src="/images/paging2.svg" alt="" style="width: 30px; height: 30px;" />
						   </button>
						   <div class="date">
						      <p id="calYear">YYYY</p>
						      <p>/</p>
						      <p id="calMonth">MM</p>
						   </div>
						   <button type="button" class="next_btn" id="nextNextCalendar">
						      <img src="/images/paging3.svg" alt="" style="width: 30px; height: 30px;" />
						   </button>
						</div>
					
						<table class="scriptCalendar">
						    <thead>
						        <tr>
						            <td>일</td>
						            <td>월</td>
						            <td>화</td>
						            <td>수</td>
						            <td>목</td>
						            <td>금</td>
						            <td>토</td>
						        </tr>
						    </thead>
						    <tbody>
						    	<!-- 스크립트로 내용 채워넣음 -->
						       
						    	<!-- 선택한 예약 날짜 전달 input -->
								<input type="hidden" id="selectedDate" name="postdate" value="">
						    </tbody>
						</table>
					</div>
					
					<div class="reserv_right">
						<div class="time_select">
							<p> 예약받지 않을 시간을 선택하세요.</p>
				        	<div class="am">
				            	<div class="time_title">오전</div>
			              		<ul class="time_list">
			              		
<!-- ************ 코드 수정 예정 **************** -->
<!-- 해당하는 시간에 예약이 있는 경우 예약불가 표시 -->
<c:forEach items="${hoursInfo.generateTimeSlots()}" var="timeSlot" varStatus="loop">
    <c:if test="${timeSlot lt '12:00'}">
        <c:set var="isReserved" value="false" />
        <c:forEach items="${closeTime}" var="close" varStatus="loop">
            <c:if test="${close.posttime eq timeSlot}">
                <c:set var="isReserved" value="true" />
            </c:if>
        </c:forEach>

        <c:if test="${isReserved}">
            <li class="time_item block">
            	<input id="${timeSlot}" type="checkbox" name="posttimez" value="${timeSlot}">
                <label for="${timeSlot}">${timeSlot}</label>
            </li>
        </c:if>
        <c:if test="${not isReserved}">
            <li class="time_item">
                <input id="${timeSlot}" type="checkbox" name="posttimez" value="${timeSlot}">
                <label for="${timeSlot}">${timeSlot}</label>
            </li>
        </c:if>
    </c:if>
</c:forEach>
								    
			              		</ul>
			            	</div>
			            	<div>
			              		<div class="time_title">오후</div>
		             			<ul class="time_list">
		             			
<!-- ************ 코드 수정 예정 **************** -->
<!-- 해당하는 시간에 예약이 있는 경우 예약불가 표시 -->
<c:forEach items="${hoursInfo.generateTimeSlots()}" var="timeSlot" varStatus="loop">
    <c:if test="${timeSlot ge '12:00'}">
        <c:set var="isReserved" value="false" />
        <c:forEach items="${closeTime}" var="close" varStatus="loop">
            <c:if test="${close.posttime eq timeSlot}">
                <c:set var="isReserved" value="true" />
            </c:if>
        </c:forEach>

        <c:if test="${isReserved}">
            <li class="time_item block">
            	<input id="${timeSlot}" type="checkbox" name="posttimez" value="${timeSlot}">
                <label for="${timeSlot}">${timeSlot}</label>
            </li>
        </c:if>
        <c:if test="${not isReserved}">
            <li class="time_item">
                <input id="${timeSlot}" type="checkbox" name="posttimez" value="${timeSlot}">
                <label for="${timeSlot}">${ timeSlot }</label>
            </li>
        </c:if>
    </c:if>
</c:forEach>
								    
								    
								    
			              		</ul>
		           			</div>
		       			</div>
		       			
		       			
		       			
		       			<div class="btn_wrap">
			            	<button type="submit">예약 닫기</button>
			            </div>
		       			
		       			
					</div>
				        
	   			</div>
	   			
	   		
	   		</form>
	   		
   		</div>
	</div>
</main>

<%@ include file="../common/main_footer.jsp" %>
</body>
</html>