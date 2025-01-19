/**
 * 시/구/군을 동적으로 셀렉트하는 함수
 */
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


/**
 * 읍/면/동을 동적으로 셀렉트하는 함수
 */
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


/**
 * 조건 필터 버튼 클릭 시 동작하는 함수
 */
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