/**
 * 전역 변수 선언
 * offset: 현재 데이터 시작 위치
 * limit: 한 번에 가져올 데이터 개수
 * count: 전체 데이터 개수
 */
var offset = 0;
var limit = 10;
var count = 0;


/**
 * 더보기 버튼 클릭 시 데이터 로드 함수를 호출하는 함수
 */
var offset = 0;
var limit = 10;
var count = 0;

$(document).ready(function() {
    // 초기 페이지 로딩 시 doctorListContent를 가져오기 위한 AJAX 호출
    loadDoctorListContent();

    // 더보기 버튼 클릭 시 추가 데이터 로드
    $('.more_btn').click(function(event) {
        event.preventDefault();
        loadDoctorListContent();
    });

    // 검색 폼 제출 시 데이터 로드
    $('.search_form').submit(function(event) {
        event.preventDefault();
        // 검색 조건과 검색어
        var searchField = $('select[name="searchField"]').val();
        var searchWord = $('input[name="searchWord"]').val();
        // 검색어와 조건이 비어 있지 않은지 확인
        if (searchWord === "") {
            alert("검색어를 입력해주세요.");
            return;
        }
        // 초기화 후 데이터 로드
        offset = 0;
        $('#doctorListContent').empty();
        loadDoctorListContent(searchField, searchWord);
    });
});


/**
 * 데이터를 로드하는 함수
 */
function loadDoctorListContent(searchField = '', searchWord = '') {
    $.ajax({
        url: './doctor/doctorListContent.do',
        type: 'GET',
        data: {
            offset: offset,
            limit: limit,
            searchField: searchField,
            searchWord: searchWord
        },
        success: function(response) {
            $('#doctorListContent').append(response);

            // 서버에서 count 값을 가져와서 설정
            count = parseInt($('#count').val());
            offset += limit;

            // 더 이상 불러올 데이터가 없으면 더보기 버튼 숨김
            if (offset >= count) {
                $('.more_btn').hide();
            } else {
                $('.more_btn').show();
            }
        },
        error: function(error) {
            console.error(error);
            $('.more_btn').hide();
        }
    });
}
