<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>맛집 리스트</title>
<!-- Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="Soft UI - Neumorphism Style UI Kit" />
<meta name="author" content="kingstudio.ro" />
<meta 
  http-equiv="Content-Security-Policy"
  content="upgrade-insecure-requests"
/>
<!-- Favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath}/images/grgr_logo.png">
<!-- Site Title -->
<title>Soft UI - Neumorphism Style UI Kit</title>
<!-- Bootstrap 4 core CSS -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Custom Styles -->
<link href="${pageContext.request.contextPath}/assets/css/animate.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;600;800&display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;600;800&display=swap"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/fontawesome-all.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=14d52cf2170b402e29c245507937cea1"></script>
	<style>
.dot {
    overflow: hidden;
    float: left;
    width: 12px;
    height: 12px;
    /* 절대 경로로 수정 */
    background: url('${pageContext.request.contextPath}/resources/images/mini_circle.png');
}.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {
    content: '';
    position: absolute;
    margin-left: -6px;
    left: 50%;
    bottom: -8px;
    width: 11px;
    height: 8px;
    /* 절대 경로로 수정 */
    background: url('${pageContext.request.contextPath}/resources/images/vertex_white_small.png');
}.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
</style>
</head>
<body>

	<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/tiles/header.jsp" />

<!-- / top -->
<div class="container">
    <h1 class="mt-5">맛집 리스트</h1>
    <hr>
	<div id="map" style="width: 100%; height: 500px;"></div>\
	<hr>
	*다중 경로 소요시간 계산하기* : 지도를 마우스로 클릭하면 선 그리기가 시작되고,
	오른쪽 마우스를 클릭하면 선 그리기가 종료됩니다
	<hr>
    <div class="mb-4">
    
    	
    
        <button class="btn btn-primary" data-category="전체">전체</button>
        <button class="btn btn-primary" data-category="한식">한식</button>
        <button class="btn btn-primary" data-category="일식">일식</button>
        <button class="btn btn-primary" data-category="중식">중식</button>
        <button class="btn btn-primary" data-category="양식">양식</button>
        <button class="btn btn-primary" data-category="기타">기타</button>
        <!-- 다른 카테고리 버튼들 추가 -->
    </div>
    <div class="row mt-4">
        <c:forEach items="${matzibList}" var="matzib" varStatus="loop">
            <div class="col-md-4 mb-4" data-category="${matzib.category_name.split(" > ")[1]}">
                <div class="card">
                    <div class="card-body">

                        <h5 class="card-title">${matzib.place_name}</h5>
                        <p class="card-text">카테고리: ${matzib.category_name.split(" > ")[1]}</p>
                        <p class="card-text">전화번호: ${matzib.phone}</p>
                        <p class="card-text">주소: ${matzib.address_name}</p>
                        <p class="card-text">x: ${matzib.x}</p>
                        <p class="card-text">y: ${matzib.y}</p>
                        <a href="#" class="btn btn-primary" data-toggle="modal"
                            data-target="#linkModal_${loop.index}">상세 정보 보기</a>
                            <a href="#" class="btn btn-primary btn-gilchadgi" data-index="${loop.index}">길찾기</a>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="linkModal_${loop.index}" tabindex="-1" role="dialog"
                aria-labelledby="linkModalLabel_${loop.index}" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content" width="1100">
                        <div class="modal-header">
                            <h5 class="modal-title" id="linkModalLabel_${loop.index}">상세 정보 보기</h5>
                            <button type="button" class="close" data-dismiss="modal"
                                aria-label="닫기">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" width="1000" height="1000">
                            <iframe src="${matzib.place_url}" width="1000" height="1000"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<!-- footer 영역 추가-->
<jsp:include page="/WEB-INF/views/tiles/footer.jsp" />


<script
    src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script
    src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- jQuery UI 라이브러리 추가 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(document).ready(function() {
    
    $(".modal-content").draggable({
        handle: ".modal-header" // 드래그 핸들로 모달 헤더를 사용
    });
});
</script>

<script>
var matzibData = [
    <c:forEach items="${matzibList}" var="matzib" varStatus="loop">
        {
            name: "${matzib.place_name}",
            category: "${matzib.category_name.split(" > ")[1]}",
            phone: "${matzib.phone}",
            address: "${matzib.address_name}",
            x: ${matzib.x},
            y: ${matzib.y}
        },
    </c:forEach>
];
</script>

<!-- 카카오 맵 초기화 및 업체 마커 표시 -->
<script>
$(document).ready(function () {
    var mapContainer = document.getElementById('map'); // 지도를 표시할 div
    var map;
    var userMarker; // 현재 위치를 표시할 마커

    // 모든 업체 마커를 담을 배열
    var markers = [];

    // 카테고리 필터링 함수
    function filterCategory(category) {
    // 모든 카드와 마커 숨기기
    $(".col-md-4").hide();
    markers.forEach(function (marker) {
        marker.setMap(null);
    });

    // 선택한 카테고리의 카드만 표시하고 해당하는 마커만 지도에 표시
    if (category === "전체") {
        $(".col-md-4").show();
        markers.forEach(function (marker, index) {
            marker.setMap(map);
        });
    }  else if (category === "기타") {
        // 한식, 양식, 일식, 중식을 제외한 나머지 카테고리만 표시
        $(".col-md-4[data-category!='한식'][data-category!='양식'][data-category!='일식'][data-category!='중식']").show();
        markers.forEach(function (marker, index) {
            if (matzibData[index].category !== "한식" &&
                matzibData[index].category !== "양식" &&
                matzibData[index].category !== "일식" &&
                matzibData[index].category !== "중식") {
                marker.setMap(map);
            }
        });
    } 
    else {
        $(".col-md-4[data-category='" + category + "']").show();
        markers.forEach(function (marker, index) {
            if (matzibData[index].category === category) {
                marker.setMap(map);
            }
        });
    }
}

    // 현재 위치를 받아와 지도에 표시하는 함수
    function showUserLocation(position) {
        var latitude = position.coords.latitude; 
        var longitude = position.coords.longitude; 

        var userMarkerPosition = new kakao.maps.LatLng(latitude, longitude);

        // 현재 위치 마커 생성 및 지도에 표시
        userMarker = new kakao.maps.Marker({
            position: userMarkerPosition,
            image: new kakao.maps.MarkerImage(
            		'${pageContext.request.contextPath}/images/now_location_marker.png', 
                new kakao.maps.Size(65, 65), // 마커 이미지 크기
                {
                    offset: new kakao.maps.Point(17, 47)
                }
            )
        });

        userMarker.setMap(map);

        // 지도 중심을 현재 위치로 이동
        map.setCenter(userMarkerPosition);
    }

    // 초기 지도 설정과 업체 마커 표시
    function initializeMap() {
        var mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 5
        };

        // 지도 생성
        map = new kakao.maps.Map(mapContainer, mapOption);

        
        // 업체 마커 생성 및 표시
        matzibData.forEach(function (data, index) {
            var markerPosition = new kakao.maps.LatLng(data.y, data.x);

            var marker = new kakao.maps.Marker({
                position: markerPosition,
                clickable: true,
                title: data.name
            });

            markers.push(marker);

            // 초기에는 모든 마커를 지도에 표시
            marker.setMap(map);

            marker.addListener('click', function () {
                $('#linkModal_' + index).modal('show');
            });
        });
    }

    // 페이지 로드 시 초기 지도 설정과 업체 마커 표시
    initializeMap();

    // 현재 위치를 받아와서 표시
    if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(showUserLocation);
    } else {
        alert("Geolocation을 지원하지 않는 브라우저입니다.");
    }

    // 카테고리 버튼 클릭 이벤트 처리
    $("button.btn-primary").click(function () {
        var category = $(this).data("category");
        
        
        filterCategory(category);
    });
    
    var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
    var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
    var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
    var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
    var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

    // 지도에 클릭 이벤트를 등록합니다
    // 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

        // 마우스로 클릭한 위치입니다 
        var clickPosition = mouseEvent.latLng;

        if (!drawingFlag) {

            drawingFlag = true;
            
            deleteClickLine();
            
            deleteDistnce();

            deleteCircleDot();
        
            clickLine = new kakao.maps.Polyline({
                map: map,  
                path: [clickPosition], 
                strokeWeight: 4, 
                strokeColor: '#db4040', 
                strokeOpacity: 1, 
                strokeStyle: 'solid' 
            });
            
            
            moveLine = new kakao.maps.Polyline({
                strokeWeight: 3, // 선의 두께입니다 
                strokeColor: '#db4040', // 선의 색깔입니다
                strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid' // 선의 스타일입니다    
            });
        
            // 클릭한 지점에 대한 정보를 지도에 표시합니다
            displayCircleDot(clickPosition, 0);

                
        } else { // 선이 그려지고 있는 상태이면

            // 그려지고 있는 선의 좌표 배열을 얻어옵니다
            var path = clickLine.getPath();

            // 좌표 배열에 클릭한 위치를 추가합니다
            path.push(clickPosition);
            
            // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
            clickLine.setPath(path);

            var distance = Math.round(clickLine.getLength());
            displayCircleDot(clickPosition, distance);
        }
    });
        
    // 지도에 마우스무브 이벤트를 등록합니다
    // 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
    kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

        // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
        if (drawingFlag){
            
            // 마우스 커서의 현재 위치를 얻어옵니다 
            var mousePosition = mouseEvent.latLng; 

            // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
            var path = clickLine.getPath();
            
            // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
            var movepath = [path[path.length-1], mousePosition];
            moveLine.setPath(movepath);    
            moveLine.setMap(map);
            
            var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
                content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
            
            // 거리정보를 지도에 표시합니다
            showDistance(content, mousePosition);   
        }             
    });                 

    // 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
    // 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
    kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

        // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
        if (drawingFlag) {
            
            // 마우스무브로 그려진 선은 지도에서 제거합니다
            moveLine.setMap(null);
            moveLine = null;  
            
            // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
            var path = clickLine.getPath();
        
            // 선을 구성하는 좌표의 개수가 2개 이상이면
            if (path.length > 1) {

                // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
                if (dots[dots.length-1].distance) {
                    dots[dots.length-1].distance.setMap(null);
                    dots[dots.length-1].distance = null;    
                }

                var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                    content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
                    
                // 그려진 선의 거리정보를 지도에 표시합니다
                showDistance(content, path[path.length-1]);  
                 
            } else {

                // 선을 구성하는 좌표의 개수가 1개 이하이면 
                // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
                deleteClickLine();
                deleteCircleDot(); 
                deleteDistnce();

            }
            
            // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
            drawingFlag = false;          
        }  
    });    

    // 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
    function deleteClickLine() {
        if (clickLine) {
            clickLine.setMap(null);    
            clickLine = null;        
        }
    }

    function showDistance(content, position) {
        
        if (distanceOverlay) { 
            
            distanceOverlay.setPosition(position);
            distanceOverlay.setContent(content);
            
        } else { 
            
            distanceOverlay = new kakao.maps.CustomOverlay({
                map: map, 
                content: content, 
                position: position, 
                xAnchor: 0,
                yAnchor: 0,
                zIndex: 3  
            });      
        }
    }

    function deleteDistnce () {
        if (distanceOverlay) {
            distanceOverlay.setMap(null);
            distanceOverlay = null;
        }
    }

    
    function displayCircleDot(position, distance) {

        // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
        var circleOverlay = new kakao.maps.CustomOverlay({
            content: '<span class="dot"></span>',
            position: position,
            zIndex: 1
        });

        // 지도에 표시합니다
        circleOverlay.setMap(map);

        if (distance > 0) {
            // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
            var distanceOverlay = new kakao.maps.CustomOverlay({
                content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
                position: position,
                yAnchor: 1,
                zIndex: 2
            });

            // 지도에 표시합니다
            distanceOverlay.setMap(map);
        }

        // 배열에 추가합니다
        dots.push({circle:circleOverlay, distance: distanceOverlay});
    }

    function deleteCircleDot() {
        var i;

        for ( i = 0; i < dots.length; i++ ){
            if (dots[i].circle) { 
                dots[i].circle.setMap(null);
            }

            if (dots[i].distance) {
                dots[i].distance.setMap(null);
            }
        }

        dots = [];
    }

    
    function getTimeHTML(distance) {

        
        var walkkTime = distance / 67 | 0;
        var walkHour = '', walkMin = '';

        
        if (walkkTime > 60) {
            walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
        }
        walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

       
        var bycicleTime = distance / 227 | 0;
        var bycicleHour = '', bycicleMin = '';
        if (bycicleTime > 60) {
            bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
        }
        bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

        var content = '<ul class="dotOverlay distanceInfo">';
        content += '    <li>';
        content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
        content += '    </li>';
        content += '    <li>';
        content += '        <span class="label">도보</span>' + walkHour + walkMin;
        content += '    </li>';
        content += '    <li>';
        content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
        content += '    </li>';
        content += '</ul>'

        return content;
    }
});


</script>
</body>
</html>