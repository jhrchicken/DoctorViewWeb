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