/**
 * 변수 선언
 * offset: 현재 데이터 시작 위치
 * limit: 한 번에 가져올 데이터 개수
 * count: 전체 데이터 개수
 */
var offset = 0;
var limit = 10;
var count = 0;


/**
 * 
 */
$(document).ready(function() {
	// 초기 페이지 로딩 시 doctorListContent를 가져오기 위한 AJAX 호출
	loadDoctorListContent();
	
	// 더보기 버튼 클릭 시 추가 제품 로드
	$('.more_btn').click(function(event) {
		event.preventDefault();
		loadDoctorListContent();
	});
})


/**
 * 
 */
function loadDoctorListContent() {
		
	$.ajax({
		url: './doctor/doctorListContent.do',
		type: 'GET',
		data: {
			offset: offset,
			limit: limit
		},
		success: function(response) {
			$('#doctorListContent').append(response);
			
			// 서버에서 count 값을 가져와서 설정
			count = parseInt($('#count').val());
			offset += limit;
			
			if (offset >= count) {
				$('.btn_more').hide();
			}
			else {
				$('.btn_more').show();
			}
		},
		error: function(error) {
            console.error(error);
            $('.btn_more').hide();
        }
	})
}






