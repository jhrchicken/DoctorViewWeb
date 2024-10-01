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
<link rel="stylesheet" href="/css/reserve-hosp.css" />

<script type="text/javascript">
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

    	            // 오늘 이후 날짜일 경우
    	            if (currentDate >= nowDate) {
    	                column.style.backgroundColor = "#FFFFE6"; // 오늘 이후 날짜 배경 색상
    	                column.style.cursor = "pointer";
    	                column.onclick = function () { calendarChoiceDay(this); };
    	            } else {
    	                // 오늘 이전 날짜는 선택 불가
    	                column.style.backgroundColor = "#E5E5E5"; // 비활성화 색상
    	                column.style.cursor = "not-allowed"; // 선택 불가 커서
    	            }

    	            // 오늘 날짜일 경우
    	            if (day === nowDate.getDate() && toDay.getMonth() === nowDate.getMonth() && toDay.getFullYear() === nowDate.getFullYear()) {
    	                column.style.backgroundColor = "#FFFFE6"; // 오늘 날짜 강조
    	                column.style.cursor = "pointer"; // 오늘 날짜도 선택 가능하게 수정
    	                column.onclick = function () { calendarChoiceDay(column); }; // 오늘 날짜도 선택 가능
    	                calendarChoiceDay(column); // 오늘 날짜 자동 선택
    	            }
    	        } else {
    	            // 이전 또는 다음 달 날짜 처리
    	            let exceptDay = new Date(doMonth.getFullYear(), doMonth.getMonth(), day);
    	            column.innerText = autoLeftPad(exceptDay.getDate(), 2);
    	            column.style.color = "#A9A9A9"; // 이전/다음 달 날짜 회색 표시
    	        }

    	        // 일요일
    	        if (dom % 7 == 1) {
    	            column.style.color = "#FF4D4D"; // 일요일 빨간색
    	        }

    	        // 토요일
    	        if (dom % 7 == 0) {
    	            column.style.color = "#4D4DFF"; // 토요일 파란색
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
		        document.getElementsByClassName("choiceDay")[0].style.backgroundColor = "#FFFFE6";  
		        document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");
		    }
		
		    // 선택한 날짜 강조
		    column.style.backgroundColor = "#FF9999";
		    column.classList.add("choiceDay");
		
		    // 선택한 날짜를 hidden input에 설정
		    const year = document.getElementById("calYear").innerText;
		    const month = document.getElementById("calMonth").innerText;
		    const day = column.innerText.trim(); // 공백 제거
		    
		    const formattedDate = year + month + day;
// 		    console.log("Selected date:", formattedDate); // 디버깅
		    
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
</script>




</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
  <div class="content">
    <div class="content_inner">
      <h2>병원 예약</h2>
      
      <!-- form -->
	  <form name="proceedFrm" method="post" 
					action="#" onsubmit="return validateForm(this);">


      <!-- 병원 정보 -->
      <div class="list">
        <ul class="doctor">
          <li>
            <span class="img">
              <img src="/images/hospital.png" alt="" />
            </span>
            <div class="info">
              <div class="info_top">
                <h3>더조은병원</h3>
                <!-- 병원명/아이디 전달 -->
                <input type="hi-dden" name="hosp_ref" value="선택한 병원아이디" placeholder="" readonly/>
                <input type="hi-dden" name="hospname" value="선택한 병원명" placeholder="" readonly/>
              </div>
              <div class="detail">
                <div class="details">
                  <p class="blue">전화</p>
                  <p>02-738-5001</p>
                </div>
                <div class="details">
                  <p class="blue">주소</p>
                  <p>서울특별시 종로구</p>
                </div>
                <div class="details">
                  <p class="blue">진료과목</p>
                  <p>피부과</p>
                </div>
              </div>
            </div>
          </li>
        </ul>
      </div>
      
       <!-- 의사정보 -->
	  <div class="list">
	    <ul class="doctor">
	      
	      <li>
			<label>
				<input id="의사1"  type="radio" name="doctorname" value="의사1" />
				<label for="의사1">의사1</label>
			</label>
	        <span class="img">
	          <img src="/images/doctor.png" alt="" />
	        </span>
	        <div class="info">
	          <div class="info_top">
	            <h3>의료진명 1</h3>
	            <input type="hi-dden" name="doc_idx_doc1" value="의사idx1" />
	            <input type="hi-dden" name="doctorname_doc1" value="의료진이름1" />
	            <div class="detail">
	              <div class="details">
	                <p class="blue">전공</p>
	              </div>
	              <div class="details">
	                <p class="blue">경력</p>
	              </div>
	              <div class="details">
	                <p class="blue">근무시간</p>
	              </div>
	            </div>
	          </div>
	        </div>
	      </li>
	      
	      <li>
	      	<label>
				<input id="의사2"  type="radio" name="doctorname" value="의사2" />
				<label for="의사2">의사2</label>
			</label>
	        <span class="img">
	          <img src="/images/doctor.png" alt="" />
	        </span>
	        <div class="info">
	          <div class="info_top">
	            <h3>의료진명 2</h3>
	            <input type="hi-dden" name="doc_idx_doc2" value="의사idx2" />
	            <input type="hi-dden" name="doctorname_doc2" value="의료진이름2" />
	            <div class="detail">
	              <div class="details">
	                <p class="blue">전공</p>
	              </div>
	              <div class="details">
	                <p class="blue">경력</p>
	              </div>
	              <div class="details">
	                <p class="blue">근무시간</p>
	              </div>
	            </div>
	          </div>
	        </div>
	      </li>
	      
	    </ul>
	  </div>

<!-- 진료과목 추후 추가 -->
<!--       <div class="list_search"> -->
<!--         <form class="searchForm" name="searchForm"> -->
<!--           <div class="search_depart"> -->
<!--             <select name="searchSelect" class="searchField"> -->
<!--               <option value="depart">-- 진료과목 선택 --</option> -->
<!--               <option value="in">내과</option> -->
<!--               <option value="out">외과</option> -->
<!--               <option value="ear">이비인후과</option> -->
<!--               <option value="plastic">성형외과</option> -->
<!--             </select> -->
<!--             <input type="submit" class="search_btn" value=""> -->
<!--           </div> -->
<!--         </form> -->
<!--       </div> -->
      
      <!-- 예약 폼 -->
      <div class="reservation">
      
        <div class="reserv_top">
          <!-- ************************************* 캘린더 ************************************ -->
			<div>
			   <button type="button" class="prev_btn" id="btnPrevCalendar">
			      <img src="/images/paging2.svg" alt="" />
			   </button>
			   <div>
			      <p id="calYear">YYYY</p>
			      <p id="calMonth">MM</p>
			   </div>
			   <button type="button" class="next_btn" id="nextNextCalendar">
			      <img src="/images/paging3.svg" alt="" />
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
				<!-- 선택한 날짜를 전달할 hidden input 추가 -->
				<input type="hi-dden" id="selectedDate" name="selectedDate" value="">
			    </tbody>
			</table>
			
			   

          <div class="time_select">
            <div class="am">
              <div class="time_title">오전</div>
              <ul class="time_list">
                <li class="time_item">
                  <button type="button" class="btn_time unselectable" disabled="">11:30</button>
                </li>
              </ul>
            </div>
            <div>
              <div class="time_title">오후</div>
              <ul class="time_list">
                <li class="time_item">
                  <button type="button" class="btn_time unselectable" disabled="">12:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">12:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">1:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">1:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">2:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">2:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">3:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">3:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">4:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">4:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">5:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time unselectable" disabled="">5:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">6:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">6:30</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">7:00</button>
                </li>
                <li class="time_item">
                  <button type="button" class="btn_time">7:30</button>
                </li>
              </ul>
            </div>
          </div>
        </div>

		<!-- 예약자 정보 -->
        <div class="reserv_bottom">
          <h3>예약자 정보</h3>
          <p>실제 방문하시는 분의 정보를 입력해주세요.</p>
          <div class="reserv_form">
            <div class="reserv_wrap">
              <table>
                <tr class="first_tr">
                  <td class="left">이름</td>
                  <td>
                  	<input type="text" name="username" value="유저명" placeholder="방문자의 이름을 입력해주세요.">
                  	<input type="hi-dden" name="user_ref" value="유저아이디">
                  </td>
                </tr>
                <tr>
                  <td class="left">전화번호</td>
                  <td><input type="text" name="tel" value="유저전화번호" placeholder="방문자의 전화번호를 입력해주세요."></td>
                </tr>
                <tr>
                  <td class="left">주민등록번호</td>
                  <td><input type="text" name="rnn" value="유저주민번호" placeholder="방문자의 전화번호를 입력해주세요."></td>
                </tr>
                <tr>
                  <td class="left">주소</td>
                  <td><input type="text" name="address" value="유저주소" placeholder="방문자의 전화번호를 입력해주세요."></td>
                </tr>
                <tr></tr>
              </table>
            </div>
            
            <button type="button" onclick="resetForm()">새로 작성하기</button> 
            
          </div>
        </div>
        
        <!-- 새로작성하기 버튼 함수 -->
		<script>
		function resetForm() {
		    // 모든 input 요소 선택
		    const inputs = document.querySelectorAll('.reserv_bottom input[type="text"]');
		
		    // 각 input 요소의 값을 초기화
		    inputs.forEach(input => {
		        input.value = ''; // 빈 문자열로 설정
		    });
		}
		</script>
        
		
      </div>
      
        <!-- 예약하기 버튼 -->
        <button type="button">예약하기</button>
      
      </form>
      
    </div>
  </div>
</main>

























<%@include file="../common/main_footer.jsp" %>
</body>
</html>