<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>

<html>
<head>
<title>motrip</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- 지도용 스크립트 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a&libraries=services"></script>
    <script type="text/javascript">
        let markers = []; // 마커 배열
        let maps = []; // 지도 배열
    </script>
</head>
<body>
    <h1>여행플랜</h1>

    <td colspan="5"><hr></td>
    <table>
        <tr>
            <th align="center" width="200">작성자 아이디</th>
            <th align="center" width="200">여행플랜 제목</th>
            <th align="center" width="200">총 여행일수</th>
            <th align="center" width="200">작성날짜</th>
            <th align="center" width="200">추천수</th>
            <th align="center" width="200">조회수</th>
            <th align="center" width="200">여행플랜 번호</th>
        </tr>
        <tr>
            <td align="center" width="200">${tripPlan.tripPlanAuthor}</td>
            <td align="center" width="200">${tripPlan.tripPlanTitle}</td>
            <td align="center" width="200">${tripPlan.tripDays}</td>
            <td align="center" width="200">${tripPlan.tripPlanRegDate}</td>
            <td align="center" width="200">${tripPlan.tripPlanLikes}</td>
            <td align="center" width="200">${tripPlan.tripPlanViews}</td>
            <td align="center" width="200">${tripPlan.tripPlanNo}</td>
        </tr>
    </table>
    <td colspan="5"><hr></td>
    <c:set var="i" value="0" />
    <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
        <c:set var="i" value="${ i+1 }" />
        <h2>${i}일차 여행플랜</h2>
        <table>
            <tr>
                <th align="center" width="200">여행플랜 본문</th>
                <th align="center" width="200">총 이동시간</th>
                <th align="center" width="200">일차별 여행플랜 번호</th>
            </tr>
            <tr>
                <td align="center" width="200">${dailyPlan.dailyPlanContents}</td>
                <td align="center" width="200">${dailyPlan.totalTripTime}</td>
                <td align="center" width="200">${dailyPlan.dailyPlanNo}</td>
            </tr>
        </table>

        <div id="map${i-1}" style="width: 400px; height: 400px;"></div>
        <h2>명소</h2>
        <td>
            <table>
                <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                <tr>
                    <td align="center" width="200">명소태그 : ${place.placeTags}</td>
                    <td align="center" width="200">명소좌표 : ${place.placeCoordinates}</td>
                    <td align="center" width="200">명소전화번호 : ${place.placePhoneNumber}</td>
                    <td align="center" width="200">명소주소 : ${place.placeAddress}</td>
                    <td align="center" width="200">카테고리 : ${place.placeCategory}</td>
                    <td align="center" width="200">명소번호 : ${place.placeNo}</td>
                </tr>

                <script type="text/javascript">
                    var latitude = ${place.placeCoordinates.split(',')[0]}; // 위도
                    var longitude = ${place.placeCoordinates.split(',')[1]}; // 경도
                    var markerPosition = new kakao.maps.LatLng(longitude, latitude); // 경도, 위도 순으로 저장해야함
                    var mapId = 'map${i-1}'; // 해당 명소의 맵 ID

                    // markers 배열에 좌표 및 맵 ID 추가
                    markers.push({
                        position: markerPosition,
                        mapId: mapId
                    });
                </script>

                </c:forEach>
            </table>
        </td>
        <td colspan="5"><hr></td>
    </c:forEach>
    <button type="button" id="updateTripPlan">여행플랜 수정</button>
    <button type="button" id="history">이전</button>
</body>

<script type="text/javascript">

    let tripDays = ${tripPlan.tripDays}; // 여행일수의 수량만큼 map 생성

    $(function() {
        for (var i = 0; i < tripDays; i++) { // map의 아이디를 동적으로 할당하여 생성
            var mapContainer = document.getElementById('map' + i);
            var mapOptions = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567),
                level: 3
            };
            var map = new kakao.maps.Map(mapContainer, mapOptions);
            maps.push(map);
        }
        $(maps).each(function(index, map) { // 각 지도마다 들어있는 마커를 기준으로 화면 재구성
            var bounds = new kakao.maps.LatLngBounds();
            var mapId = 'map' + index;
            var mapMarkers = markers.filter(function(marker) {
                return marker.mapId === mapId;
            });

            $(mapMarkers).each(function(index, marker) {
                var markerOptions = {
                    position: marker.position,
                    map: map
                };
                var marker = new kakao.maps.Marker(markerOptions);
                marker.setMap(map);
                bounds.extend(markerOptions.position);
            });
            map.setBounds(bounds);
        });
    });

    $(function() {
        for (var i = 0; i < markers.length; i++) { // 각 지도에 맞춰서 마커들을 표시
            var mapId = markers[i].mapId;
            var mapIndex = parseInt(mapId.replace("map", ""));
            var markerOptions = {
                position: markers[i].position,
                map: maps[mapIndex]
            };
            var marker = new kakao.maps.Marker(markerOptions);
            marker.setMap(markerOptions.map);
        }
    });

    $(function() {
         $("button[id='updateTripPlan']").on("click", function() {
            window.location.href = "/tripPlan/updateTripPlan";
         });
    });

    $(function() {
         $("button[id='history']").on("click", function() {
              console.log("이전");
         });
    });

</script>
</html>