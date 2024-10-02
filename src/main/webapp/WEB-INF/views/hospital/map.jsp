<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/hosp-map.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=15a2c1c344d439b437c885c0fadd2798&libraries=services"></script>
<script>
// 지도 전역변수로 선언
var map;

// 마커가 표시될 병원 목록 배열
var allHospitals = [];
var openHospitals = [];
var nightHospitals = [];
var weekendHospitals = [];

// 마커 객체를 가지고 있을 배열
var allMarkers = [];
var openMarkers = [];
var nightMarkers = [];
var weekendMarkers = [];

document.addEventListener('DOMContentLoaded', function() {
    var mapContainer = document.getElementById('map');
    var mapOption = { 
    	center: new kakao.maps.LatLng(37.56918323969871, 126.98481614705707), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };
    // 지도 생성
    map = new kakao.maps.Map(mapContainer, mapOption);
    
  	// 마커가 표시될 위치 (현재 위치)
    var markerPosition  = new kakao.maps.LatLng(37.56918323969871, 126.98481614705707); 
    // 마커 생성
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });
    // 마커를 지도 위에 표시
    marker.setMap(map);

    // 병원 객체 배열 생성
	var hospList = [
	    <c:forEach items="${ hospList }" var="row" varStatus="loop">
	        {
	            address: '${row.address}',
	            name: '${row.name}',
	        }<c:if test="${!loop.last}">,</c:if>
	    </c:forEach>
	];
    
    // 배열의 각 병원에 대해 조건에 따라 분류
    hospList.forEach(function(hospital) {
    	allHospitals.push(hospital);
    	if (true) {
    		openHospitals.push(hospital);
    	}
    	if (true) {
    		nightHospitals.push(hospital);
    	}
    	if (true) {
    		weekendHospitals.push(hospital);
    	}
    });
    
    createAllMarkers();
    createOpenMarkers();
    createNightMarkers();
    createWeekendMarkers();
    
    changeMarker('all');
});

// 영업중 마커를 생성하고 영업중 마커 배열에 추가하는 함수
function createOpenMarkers() {
	// 주소-좌표 변환 객체를 생성
    var geocoder = new kakao.maps.services.Geocoder();
	
	openHospitals.forEach(function(hospital) {
		// 주소로 좌표를 검색
	    geocoder.addressSearch(hospital.address.split(',')[0], function(result, status) {
	    	// 정상적으로 검색이 완료된 경우
	        if (status === kakao.maps.services.Status.OK) {
	            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    		// 마커 생성 (기본 이미지 사용)
	    		var marker = new kakao.maps.Marker({
	    			position: coords,
	    			clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정
	    		});
	    		// 생성된 마커를 영업중 마커 배열에 추가
	    		openMarkers.push(marker);
	    		marker.setMap(map);
	        }
	    });
	});
}

// 모든 마커를 생성하고 영업중 마커 배열에 추가하는 함수
function createAllMarkers() {
	// 주소-좌표 변환 객체를 생성
    var geocoder = new kakao.maps.services.Geocoder();
	
	allHospitals.forEach(function(hospital) {
		// 주소로 좌표를 검색
	    geocoder.addressSearch(hospital.address.split(',')[0], function(result, status) {
	    	// 정상적으로 검색이 완료된 경우
	        if (status === kakao.maps.services.Status.OK) {
	            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    		// 마커 생성 (기본 이미지 사용)
	    		var marker = new kakao.maps.Marker({
	    			position: coords,
	    			clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정
	    		});
	    		// 생성된 마커를 모든 병원 마커 배열에 추가
	    		allMarkers.push(marker);
	    		marker.setMap(map);
	        }
	    });
	});
}

// 야간진료 마커를 생성하고 야간진료 마커 배열에 추가하는 함수
function createNightMarkers() {
	// 주소-좌표 변환 객체를 생성
    var geocoder = new kakao.maps.services.Geocoder();
	
	nightHospitals.forEach(function(hospital) {
		// 주소로 좌표를 검색
		geocoder.addressSearch(hospital.address.split(',')[0], function(result, status) {
			// 정상적으로 검색이 완료된 경우
	        if (status === kakao.maps.services.Status.OK) {
	        	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        	// 마커 생성 (기본 이미지 사용)
	    		var marker = new kakao.maps.Marker({
	    			position: coords,
	    			clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정
	    		});
	    		// 생성된 마커를 야간진료 마커 배열에 추가
	    		nightMarkers.push(marker);
	    		marker.setMap(map);
	        }
		});
	});
}

// 주말진료 마커를 생성하고 주말진료 마커 배열에 추가하는 함수
function createWeekendMarkers() {
	// 주소-좌표 변환 객체를 생성
    var geocoder = new kakao.maps.services.Geocoder();
	
	weekendHospitals.forEach(function(hospital) {
		// 주소로 좌표를 검색
		geocoder.addressSearch(hospital.address.split(',')[0], function(result, status) {
			// 정상적으로 검색이 완료된 경우
	        if (status === kakao.maps.services.Status.OK) {
	        	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	        	// 마커 생성 (기본 이미지 사용)
	    		var marker = new kakao.maps.Marker({
	    			position: coords,
	    			clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정
	    		});
	    		// 생성된 마커를 주말진료 마커 배열에 추가
	    		weekendMarkers.push(marker);
	    		marker.setMap(map);
	        }
		});
	});
}

function setAllMarkers(map) {
    allMarkers.forEach(function(marker) {
        marker.setMap(map);
    });
}
function setOpenMarkers(map) {
    openMarkers.forEach(function(marker) {
        marker.setMap(map);
    });
}

function setNightMarkers(map) {
    nightMarkers.forEach(function(marker) {
        marker.setMap(map);
    });
}

function setWeekendMarkers(map) {
    weekendMarkers.forEach(function(marker) {
        marker.setMap(map);
    });
}

//카테고리를 클릭했을 때 type에 따라 카테고리의 스타일과 지도에 표시되는 마커를 변경하는 함수
function changeMarker(type) {
    var openMenu = document.getElementById('openMenu');
    var nightMenu = document.getElementById('nightMenu');
    var weekendMenu = document.getElementById('weekendMenu');

    // 현재 선택된 카테고리 확인
    if (openMenu.className === 'menu_selected' && type === 'open') {
        // 이미 선택된 카테고리를 다시 클릭했을 때 모든 마커 표시
        openMenu.className = '';
        openIcon.className = 'ico_open';
        setAllMarkers(map);
        setOpenMarkers(null);
        setNightMarkers(null);
        setWeekendMarkers(null);
    }
    else if (nightMenu.className === 'menu_selected' && type === 'night') {
        // 이미 선택된 카테고리를 다시 클릭했을 때 모든 마커 표시
        nightMenu.className = '';
        nightIcon.className = 'ico_night';
        setAllMarkers(map);
        setOpenMarkers(null);
        setNightMarkers(null);
        setWeekendMarkers(null);
    }
    else if (weekendMenu.className === 'menu_selected' && type === 'weekend') {
        // 이미 선택된 카테고리를 다시 클릭했을 때 모든 마커 표시
        weekendMenu.className = '';
        weekendIcon.className = 'ico_weekend';
        setAllMarkers(map);
        setOpenMarkers(null);
        setNightMarkers(null);
        setWeekendMarkers(null);
    }
    else {
        // 카테고리가 클릭된 경우
        if (type === 'open') {
            // 스타일 변경
            openMenu.className = 'menu_selected';
            openIcon.className = 'open_selected';
            nightMenu.className = '';
            nightIcon.className = 'ico_night';
            weekendMenu.className = '';
            weekendIcon.className = 'ico_weekend';
            setAllMarkers(null);
            setOpenMarkers(map);
            setNightMarkers(null);
            setWeekendMarkers(null);
        }
        else if (type === 'night') {
            nightMenu.className = 'menu_selected';
            nightIcon.className = 'night_selected';
            openMenu.className = '';
            openIcon.className = 'ico_open';
            weekendMenu.className = '';
            weekendIcon.className = 'ico_weekend';
            setAllMarkers(null);
            setOpenMarkers(null);
            setNightMarkers(map);
            setWeekendMarkers(null);
        }
        else if (type === 'weekend') {
            weekendMenu.className = 'menu_selected';
            weekendIcon.className = 'weekend_selected';
            openMenu.className = '';
            openIcon.className = 'ico_open';
            nightMenu.className = '';
            nightIcon.className = 'ico_night';
            setAllMarkers(null);
            setOpenMarkers(null);
            setNightMarkers(null);
            setWeekendMarkers(map);
        }
    }
}


// 지도 확대 함수
function zoomIn() {
    map.setLevel(map.getLevel() - 1);
}
// 지도 축소 함수
function zoomOut() {
    map.setLevel(map.getLevel() + 1);
}
</script>
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<div class="content_inner">
				<h2>지도로 찾기</h2>
				<div class="map_wrap">
				    <div id="map" style="width:100%; height:100%; position:relative; overflow:hidden;"></div>
				    <!-- 지도 위에 표시될 마커 카테고리 -->
				    <div class="category">
				        <ul>
				            <li id="openMenu" onclick="changeMarker('open')">
				                <span id="openIcon" class="ico_open"></span>
				                영업중
				            </li>
				            <li id="nightMenu" onclick="changeMarker('night')">
				                <span id="nightIcon" class="ico_night"></span>
				                야간진료
				            </li>
				            <li id="weekendMenu" onclick="changeMarker('weekend')">
				                <span id="weekendIcon" class="ico_weekend"></span>
				                주말진료
				            </li>
				        </ul>
				    </div>
				    <!-- 지도 확대, 축소 컨트롤 -->
				    <div class="custom_zoomcontrol radius_border"> 
				        <span onclick="zoomIn()"><img src="/images/zoom_in.svg"></span>  
				        <span onclick="zoomOut()"><img src="/images/zoom_out.svg"></span>
				    </div>
				</div>
			</div>
		</div>
	</main>
	<%@include file="../common/main_footer.jsp" %>
</body>
</html>
