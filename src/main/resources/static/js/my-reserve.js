/**
 * 예약을 취소하는 함수
 * 
 * @paran {String} app_id - 예약 일련번호
 */
function cancelReservation(app_id) {
	if (confirm("예약을 취소하시겠습니까?")) {
		var form = document.forms["cancelReservationForm_" + app_id];
		form.method = "post";
		form.action = "/reserve/cancel.do";
		form.submit();
	}
}


/**
 * 예약 내역을 숨기는 함수
 * 
 * @paran {String} app_id - 예약 일련번호
 */
function hideReservation(app_id) {
	if (confirm("숨겨진 내역은 다시 되돌릴 수 없습니다. 예약내역을 숨김처리 하시겠습니까?")) {
		var form = document.forms["hideReservationForm_" + app_id];
		form.action = "/reserve/delete.do";
		form.submit();
	}
}


/**
 * 탭 메뉴 클릭 시 탭 메뉴를 활성화하고 해당하는 내용을 표시하는 함수
 */
document.addEventListener('DOMContentLoaded', function() {
    const tabItems = document.querySelectorAll('.tab ul li');
    const contentItems = document.querySelectorAll('.tab_content');

    tabItems.forEach((item, index) => {
        item.addEventListener('click', function(event) {
            event.preventDefault();
            
            // 모든 li에서 active 클래스 제거
            tabItems.forEach(li => li.classList.remove('active'));
            // 클릭된 li에만 active 클래스 추가
            this.classList.add('active');
            
            // 모든 contentItems 숨기기
            contentItems.forEach(content => content.style.display = 'none');
            // 클릭된 탭에 해당하는 내용만 보이기
            contentItems[index].style.display = 'block';
        });
    });

    // 첫 번째 탭과 내용을 기본으로 활성화
    tabItems[0].classList.add('active');
	contentItems.forEach(content => content.style.display = 'none');
    contentItems[0].style.display = 'block';
});


/**
 * 메모 작성 모달창을 여는 함수
 * 
 * @param {String} app_id - 예약 일련번호
 * @param {String} content - 메모 내용
 */
function openMemoModal(app_id, content) {
	document.getElementById("memo_app_id").value = app_id;
	document.getElementById("memo_content").value = content;
}


/**
 * 메모 내용을 입력했는지 검증하는 함수
 * 
 * @param {Form} form - 검증할 HTML폼 객체
 * @returns {boolean} - 검증 결과  
 */
function validateMemoForm(form) {
	if (form.memo_content.value == "") {
		alert("내용을 입력하세요");
		form.memo_content.focus();
		return false;
	}
}








