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
    <link rel="stylesheet" href="/css/tripplan/tripplan.css">
    <script type="text/javascript">
        let markers = []; // 마커 배열
        let maps = []; // 지도 배열
    </script>
    <style>
        .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
        .wrap * {padding: 0;margin: 0;}
        .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
        .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
        .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
        .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
        .info .close:hover {cursor: pointer;}
        .info .body {position: relative;overflow: hidden;}
        .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
        .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
        .desc .category {font-size: 11px;color: #888;margin-top: -2px;}
        .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
        .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
        .info .link {color: #5085BB;}

        // 주석위로는 마커 클릭시 나오는 오버레이창
        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .plan-contents {
            text-align: left;
            margin-right: 20px;
        }

        .place-info {
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>여행플랜</h1>
    <button id="tripPlanLikes" value="${tripPlan.tripPlanNo}">여행플랜 추천</button>
    <td colspan="5"><hr></td>
    <table>
        <tr>
            <th align="center" width="200">작성자 닉네임</th>
            <th align="center" width="200">여행플랜 제목</th>
            <th align="center" width="200">총 여행일수</th>
            <th align="center" width="200">작성날짜</th>
            <th align="center" width="200">추천수</th>
            <th align="center" width="200">조회수</th>
        </tr>
        <tr>
            <td align="center" width="200">${tripPlan.tripPlanAuthor}</td>
            <td align="center" width="200">${tripPlan.tripPlanTitle}</td>
            <td align="center" width="200">${tripPlan.tripDays}</td>
            <td align="center" width="200">${tripPlan.tripPlanRegDate}</td>
            <td id="likes" align="center" width="200">${tripPlan.tripPlanLikes}</td>
            <td align="center" width="200">${tripPlan.tripPlanViews}</td>
        </tr>
    </table>
    <td colspan="5"><hr></td>
    <c:set var="i" value="0" />
    <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
        <c:set var="i" value="${ i+1 }" />
        <h2>${i}일차 여행플랜</h2>
        <table>
            <tr>
                <th align="left" width="400">여행플랜 본문</th>
                <%-- <th align="center" width="400">일차별 여행플랜 번호</th> --%>
            </tr>
            <tr>
                <td class="plan-contents" width="400">${dailyPlan.dailyPlanContents}</td>
                <%-- <td align="center" width="400">${dailyPlan.dailyPlanNo}</td> --%>
            </tr>
        </table>
        <div style="display: flex; justify-content: space-between;">
            <div class="plan-contents">
                <table>
                    <tr>

                    </tr>
                </table>
            </div>
            <div id="map${i-1}" style="width: 400px; height: 400px;"></div>
            <div>
                <table>
                    <td class="place-info" width="200">${dailyPlan.totalTripTime}</td>

                    <%-- 나중에 지울게요 일단 보기좋기용 --%>
                    <tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <%-- 나중에 지울게요 일단 보기좋기용 --%>

                    <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                        <tr>
                            <td class="place-info" width="250">#${place.placeTags}</td>
                        </tr>
                        <tr>
                            <td class="place-info" width="250">${place.tripTime}</td>
                        </tr>
                        <script type="text/javascript">
                            var placeTags = "${place.placeTags}";
                            var placePhoneNumber = "${place.placePhoneNumber}";
                            var placeAddress = "${place.placeAddress}";
                            var placeCategory = "${place.placeCategory}";
                            var placeImage = "${place.placeImage}";
                            var latitude = ${place.placeCoordinates.split(',')[0]}; // 위도
                            var longitude = ${place.placeCoordinates.split(',')[1]}; // 경도
                            var markerPosition = new kakao.maps.LatLng(longitude, latitude); // 경도, 위도 순으로 저장해야함
                            var mapId = 'map${i-1}'; // 해당 명소의 맵 ID

                            // markers 배열에 좌표 및 맵 ID 정보 추가
                            markers.push({
                                position: markerPosition,
                                mapId: mapId,
                                placeTags: placeTags,
                                placePhoneNumber: placePhoneNumber,
                                placeAddress: placeAddress,
                                placeCategory: placeCategory,
                                placeImage: placeImage
                            });
                        </script>
                    </c:forEach>
                </table>
            </div>
        </div>
        <button id="reset${i-1}">원위치</button>
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
        var overlays = [];
        for (var i = 0; i < markers.length; i++) { // 각 지도에 맞춰서 마커들을 표시
            var mapId = markers[i].mapId;
            var mapIndex = parseInt(mapId.replace("map", ""));
            var markerOptions = {
                position: markers[i].position,
                map: maps[mapIndex]
            };
            var marker = new kakao.maps.Marker(markerOptions);
            marker.setMap(markerOptions.map);

            // 오버레이 정보창
            var content = '<div class="wrap">' +
                        '    <div class="info">' +
                        '        <div class="title">' +
                        '            ' + markers[i].placeTags +
                        '            <div class="close" data-index="' + i + '" title="닫기"></div>' +
                        '        </div>' +
                        '        <div class="body">' +
                        '            <div class="img">' +
                        '                <img src="' + markers[i].placeImage + '" width="73" height="70">' +
                        '           </div>' +
                        '            <div class="desc">' +
                        '                <div class="ellipsis">' + markers[i].placeAddress + '</div>' +
                        '                <div class="category">(카테고리) ' + markers[i].placeCategory + ' (전화번호) ' + markers[i].placePhoneNumber + '</div>' +
                        '    </div></div></div></div>';

            var overlay = new kakao.maps.CustomOverlay({  // 마커 위에 커스텀오버레이를 표시합니다, 마커를 중심으로 커스텀 오버레이를 표시하기 위해 CSS를 이용해 위치를 설정했습니다
                content: content,
                map: maps[mapIndex],
                position: marker.getPosition(),
                yAnchor: 1
            });

            overlay.setMap(null); // 오버레이 초기 상태는 숨김으로 설정
            overlays.push(overlay);

            (function (marker, overlay, mapIndex) {

                // 마커를 클릭했을 때 오버레이 표시
                kakao.maps.event.addListener(marker, 'click', function() {
                    maps[mapIndex].setLevel(3); // 확대 수준 설정 (1: 세계, 3: 도시, 5: 거리, 7: 건물)
                    maps[mapIndex].panTo(marker.getPosition()); // 해당 마커 위치로 지도 이동
                    overlay.setMap(maps[mapIndex]);
                });

                // 지도상 어디든 클릭했을 때 오버레이 숨김
                kakao.maps.event.addListener(maps[mapIndex], 'click', function() {
                    overlay.setMap(null);
                });

                // 화면 초기화
                $('#reset' + mapIndex).click(function() {
                    overlay.setMap(null);
                    var mapIndex = parseInt(this.id.replace("reset", ""));
                    var bounds = new kakao.maps.LatLngBounds();

                    for (var j = 0; j < markers.length; j++) {
                        if (markers[j].mapId === "map" + mapIndex) {
                            bounds.extend(markers[j].position);
                        }
                    }
                    maps[mapIndex].setBounds(bounds);
                });

            })(marker, overlay, mapIndex);
        }
    });

    $(function() {
         $("button[id='tripPlanLikes']").on("click", function() {
         var tripPlanNo = "${tripPlan.tripPlanNo}";
         var tripPlanAuthor = "${tripPlan.tripPlanAuthor}";
             if(tripPlanAuthor != null || tripPlanAuthor.length>1){
                $.ajax({ // userID와 tripPlanNo가 필요하여 객체로 전달
                      url: "/tripPlan/tripPlanLikes",
                      type: "GET",
                      data: { "tripPlanNo" :  tripPlanNo,
                              "tripPlanAuthor" : tripPlanAuthor },
                      contentType: "application/json; charset=utf-8",
                      success: function (data) {
                        console.log(data);
                        if(data == -1){
                            alert("이미 추천한 여행플랜입니다.");
                        } else {
                            alert("추천 완료");
                            $("#likes").text(data);
                        }
                      },
                      error: function (xhr, status, error) {
                        console.log(error);
                      }
                });
             }

         });
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