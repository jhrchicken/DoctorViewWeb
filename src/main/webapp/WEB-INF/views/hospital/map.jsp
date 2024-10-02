<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<style>
	/* 지도에 사용자 컨트롤 올리기 */
	html, body {width:100%;height:100%;margin:0;padding:0;} 
	.map_wrap {position:relative;overflow:hidden;width:100%;height:350px;}
	.radius_border{border:1px solid #919191;border-radius:5px;}     
	.custom_typecontrol {position:absolute;top:10px;right:10px;overflow:hidden;width:130px;height:30px;margin:0;padding:0;z-index:1;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;}
	.custom_typecontrol span {display:block;width:65px;height:30px;float:left;text-align:center;line-height:30px;cursor:pointer;}
	.custom_typecontrol .btn {background:#fff;background:linear-gradient(#fff,  #e6e6e6);}       
	.custom_typecontrol .btn:hover {background:#f5f5f5;background:linear-gradient(#f5f5f5,#e3e3e3);}
	.custom_typecontrol .btn:active {background:#e6e6e6;background:linear-gradient(#e6e6e6, #fff);}    
	.custom_typecontrol .selected_btn {color:#fff;background:#425470;background:linear-gradient(#425470, #5b6d8a);}
	.custom_typecontrol .selected_btn:hover {color:#fff;}   
	.custom_zoomcontrol {position:absolute;top:50px;right:10px;width:36px;height:80px;overflow:hidden;z-index:1;background-color:#f5f5f5;} 
	.custom_zoomcontrol span {display:block;width:36px;height:40px;text-align:center;cursor:pointer;}     
	.custom_zoomcontrol span img {width:15px;height:15px;padding:12px 0;border:none;}
	.custom_zoomcontrol span:first-child{border-bottom:1px solid #bfbfbf;}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=15a2c1c344d439b437c885c0fadd2798&libraries=services"></script>
<script>
// 지도 전역변수로 선언
var map;

document.addEventListener('DOMContentLoaded', function() {
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.56918323969871, 126.98481614705707), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };
    // 지도 생성
    map = new kakao.maps.Map(mapContainer, mapOption);
    
/*  	// 마커가 표시될 위치 
    var markerPosition  = new kakao.maps.LatLng(37.56918323969871, 126.98481614705707); 
    // 마커 생성
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });
    // 마커를 지도 위에 표시
    marker.setMap(map); */
    
    // 병원 주소 배열
    var hospAddresses = [
        <c:forEach items="${ hospList }" var="row" varStatus="loop">
            '${row.address}'<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];
    // 배열의 각 주소에 대해 마커 생성
    hospAddresses.forEach(function(address) {
        markHosp(address);
    });
    
});

function markHosp(address) {
	// 주소-좌표 변환 객체를 생성
    var geocoder = new kakao.maps.services.Geocoder();
    // 주소로 좌표를 검색
    geocoder.addressSearch(address.split(',')[0], function(result, status) {
        // 정상적으로 검색이 완료된 경우
         if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            // 결과값으로 받은 위치를 마커로 표시
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });
            // 인포윈도우로 장소에 대한 설명을 표시
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
            });
            infowindow.open(map, marker);
        } 
    });
	
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
<div class="map_wrap">
    <div id="map" style="width:100%; height:100%; position:relative; overflow:hidden;"></div>
    <!-- 지도 확대, 축소 컨트롤 -->
    <div class="custom_zoomcontrol radius_border"> 
        <span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
        <span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    </div>
</div>
</body>
</html>