/**
 * 
 */

function searchHosp() {
	var form = document.searchForm;
	
	if (form.searchWord.value == "") {
		alert("검색어를 입력하세요");
		return false;
	}
	else {
		var searchField = form.searchField.value;
		var searchWord = form.searchWord.value;
		if (searchField == "hospital") {
			window.location.href = "hospital.do";
			return false;
		}
		else if (searchField == "doctor") {
			window.location.href = "doctor.do?searchField=name&searchWord=" + searchWord;
			return false;
		}
	}
}

/**
 * 베스트 병원 클릭 시 색상 변경
 * 
 */
document.addEventListener('DOMContentLoaded', function() {
	const tabItems = document.querySelectorAll('.best_menu .hd .tab ul li');
	
	// 각 li 요소에 클릭 이벤트 추가
	tabItems.forEach(item => {
		item.addEventListener('click', function(event) {
		event.preventDefault();
		// 모든 li에서 active 클래스 제거
		tabItems.forEach(li => li.classList.remove('active'));
		// 클릭된 li에만 active 클래스 추가
		this.classList.add('active');
		});
	});
});
