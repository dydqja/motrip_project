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
    <link rel="stylesheet" href="/css/tripplan/overlay.css">
    <script type="text/javascript">
        let markers = []; // 마커 배열
        let maps = []; // 지도 배열
        let placeTripPositions = []; // 이동시간 구하기 위한 명소의 좌표배열
        let placeTripTimes = []; // 좌표와 좌표사이의 이동시간들
        let totalTripTimes = [];
        let totalTripTime; // 가져온 트립타임을 이용하여 시간 분으로 파씽
        let overlays = []; // 기존 저장되어있던 마커

        let markerLengthCheck = ${tripPlan.tripDays}; // 저장된 여행일수를 통하여 배열의 크기 조정하기위해
    </script>

</head>
<body>
    <h1>여행플랜</h1>
    <button id="check" >확인용</button>
    <td colspan="5"><hr></td>
    <table>
        <tr>
            <th align="center" width="200">작성자 닉네임</th>
            <th align="center" width="200">총 여행일수</th>
            <th align="center" width="200">작성날짜</th>
            <th align="center" width="200">추천수</th>
            <th align="center" width="200">조회수</th>
        </tr>
        <tr>
            <td align="center" width="200">${nickName}</td>
            <th align="center" width="200">${tripPlan.tripPlanViews}</th>
            <td align="center" width="200">${tripPlan.tripDays}</td>
            <td align="center" width="200">${tripPlan.tripPlanRegDate}</td>
            <td id="likes" align="center" width="200">${tripPlan.tripPlanLikes}</td>
        </tr>
    </table>
    <div>
        <th align="center" width="200">여행플랜 제목</th>
        <input type="text" style='width:450px' name="tripPlanTitle" value="${tripPlan.tripPlanTitle}" />
    </div>
    <td colspan="5"><hr></td>
    <c:set var="i" value="0" />
    <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
        <c:set var="i" value="${ i+1 }" />
        <h2>${i}일차 여행플랜</h2>
        <table>
            <tr>
                <th align="left" width="400">여행플랜 본문</th>
            </tr>
        </table>
        <div style="display: flex; justify-content: space-between;">
            <div class="plan-contents">
                <table>
                    <tr>

                    </tr>
                </table>

                <div class="map_wrap" style="display: flex;">
                  <textarea id="dailyPlanContents${i-1}" style="width: 300px; height: 400px; resize: vertical; overflow: auto;">${dailyPlan.dailyPlanContents}</textarea>
                  <div id="menu_wrap${i-1}">
                      <div class="option">
                            <input type="text" id="placeName${i-1}" placeholder="장소 검색" onkeypress="handleKeyPress(event, ${i-1})">
                            <button class="placeSearch" onclick="placeSearch(${i-1})">검색</button>
                      <ul id="placesList${i-1}" style="width: 150px; height: 400px;"></ul>
                      <div id="pagination"></div>
                    </div>
                  </div>
                </div>
            </div>
                <div id="map${i-1}" style="width: 400px; height: 400px;"></div>
            <div>
                <table>
                <script type="text/javascript">
                    totalTripTimes.push(${dailyPlan.totalTripTime});
                    var totalHours = Math.floor(totalTripTimes[ "${i-1}" ] / 60);
                    var totalMinutes = totalTripTimes[ "${i-1}" ]  % 60;
                    if(totalHours == 0){
                      totalTripTime = "총 이동시간: " + totalMinutes + "분";
                    } else {
                      totalTripTime = "총 이동시간: " + totalHours + "시간 " + totalMinutes + "분";
                    }
                </script
                <div id='totalTripTime${i-1}' class='totalTripTime'>총 이동시간 ${dailyPlan.totalTripTime}</div>
                    <c:forEach var="place" items="${dailyPlan.placeResultMap}" varStatus="loop">
                        <tr>
                            <div id="placeTagsList${loop.index}_${loop.index}" data-map-id="map${i-1}" style="margin-top: 40px; padding-left: 40px; text-align: left;">
                                #${place.placeTags}
                                <div id="tripTime${loop.index}_${loop.index}" class="tripTime">${place.tripTime}</div>
                                <button onclick="deletePlace(${loop.index}, ${loop.index})">삭제</button>
                            </div>
                        </tr>
                        <tr>
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
                            var placeIndex = ${loop.index}; // 명소의 인덱스

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

                            // 명소간 이동시간 저장
                            if (!placeTripTimes[mapId]) {
                              placeTripTimes[mapId] = [];
                            }

                            placeTripTimes[mapId].push({
                              tripTime: "${place.tripTime}",
                              placeIndex: placeIndex
                            });

                        </script>
                    </c:forEach>
                </table>
            </div>
        </div>
        <button id="reset${i-1}">원위치</button>
        <td colspan="5"><hr></td>
    </c:forEach>
    <c:if test="${user.userId == tripPlan.tripPlanAuthor}">
        <button type="button" id="updateTripPlan">여행플랜 수정</button>
    </c:if>
    <button type="button" id="history">이전</button>
</body>

<script type="text/javascript">
    let tripDays = ${tripPlan.tripDays}; // 여행일수의 수량만큼 map 생성

    console.log(totalTripTimes);
    console.log(placeTripTimes);

    $(function() { // 맵 생성 및 화면 재구성
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

            var mapPlaces = []; // map별로 나눠서 배열에 저장하기 위하여 선언
            for(var i=0; i<mapMarkers.length; i++) { // 안에 여러개의 명소가 있을수 있으므로 하나씩 저장
                var longitude = mapMarkers[i].position.La;
                var latitude = mapMarkers[i].position.Ma;
                mapPlaces.push(longitude+","+latitude);
            }
            placeTripPositions.push(mapPlaces);

            map.setBounds(bounds);
        });
    });

    console.log(placeTripPositions);

    function handleKeyPress(event, indexCheck) {
          if (event.keyCode === 13) {
            var textValue = document.getElementById("placeName" + indexCheck).value;
            var ps = new kakao.maps.services.Places(); // 장소 검색 객체를 생성합니다
            var infowindow = new kakao.maps.InfoWindow({zindexCheck:1}); // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
            searchPlaces(); // 키워드로 장소를 검색합니다

            function searchPlaces() {  // 키워드 검색을 요청하는 함수입니다
              var keyword = document.getElementById('placeName'+indexCheck).value;
              if (!keyword.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
              }
              ps.keywordSearch(keyword, placesSearchCB);  // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            }

            function placesSearchCB(data, status, pagination) {  // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
              if (status === kakao.maps.services.Status.OK) {
                displayPlaces(data); // 검색 목록과 마커를 표출합니다
                displayPagination(pagination); // 페이지 번호를 표출합니다
              } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                alert('검색 결과가 존재하지 않습니다.');
                return;
              } else if (status === kakao.maps.services.Status.ERROR) {
                alert('검색 결과 중 오류가 발생했습니다.');
                return;
              }
            }

            function displayPlaces(places) {  // 검색 결과 목록과 마커를 표출하는 함수입니다
              var listEl = document.getElementById('placesList'+indexCheck),
                      menuEl = document.getElementById('menu_wrap'+indexCheck),
                      fragment = document.createDocumentFragment(),
                      bounds = new kakao.maps.LatLngBounds(),
                      listStr = '';
              var positions = []; // 검색된 항목들 위도, 경도 저장하는 배열
              removeAllChildNods(listEl); // 다시 검색했을때 이전 결과 목록 항목들을 제거합니다

              for (var i = 0; i < places.length; i++) {
                var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                        marker = addMarker(placePosition, i),
                        itemEl = getListItem(i, places[i]); // 마커를 생성하고 지도에 표시합니다
                var coordinates = placePosition.La+","+placePosition.Ma; // 반복문에 출력되는 위도 경도 모두 저장
                positions.push({ coordinates : coordinates }); // 위도와 경도를 모두 저장

                bounds.extend(placePosition); // 검색된 장소들의 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가합니다
                (function (marker, title) {

                  kakao.maps.event.addListener(marker, 'mouseover', function () {
                    displayInfowindow(marker, title, indexCheck);
                  });
                  kakao.maps.event.addListener(marker, 'mouseout', function () {
                    infowindow.close();
                  });
                  itemEl.onmouseover = function () {
                    displayInfowindow(marker, title, indexCheck);
                    maps[indexCheck].panTo(marker.getPosition()); // 특정범위 기준으로도 설정해야할듯....
                    marker.setMap(maps[indexCheck]);
                  };
                  itemEl.onmouseout = function () {
                    infowindow.close();
                    marker.setMap(null);
                  };
                  itemEl.onclick = function () {
                    marker.setMap(maps[indexCheck]); // 해당 지도에 마커를 표출합니다
                    markers.push(marker); // 해당 지도의 마커 배열에 추가합니다
                    removeAllChildNods(listEl); // 검색목록 초기화
                    displayPagination(pagination); //
                    infowindow.close(); // 지도위 정보창 닫기
                    $("#placeName" + indexCheck).val(""); // 검색창 초기화

                    // 선택한 명소정보들에 대해서 파싱
                    var parser = new DOMParser();
                    var doc = parser.parseFromString(this.innerHTML, "text/html");
                    var placePositionId = this.innerHTML.split('marker_')[1].split('"')[0]; // 몇번째 id인지 파싱

                    var placeCount = $("#placeTagsList" + indexCheck + " div[hidden]").length; // 기존 hidden place 개수

                    if (!placeTripPositions[indexCheck]) { // 배열이 존재하지 않는 경우에만 초기화
                      placeTripPositions[indexCheck] = [];
                    }
                    placeTripPositions[indexCheck].push(positions[placePositionId - 1].coordinates);

                    if(placeTripPositions[indexCheck].length > 1){
                      console.log(placeTripPositions[indexCheck]);
                      console.log(placeCount);
                      tripTime(placeTripPositions[indexCheck], placeCount);
                    }

                    var place = {
                      placeTags: doc.querySelector('.info h5').textContent.trim(),
                      placeAddress: doc.querySelector('.info span:not(.tel)').textContent.trim(),
                      placeCoordinates: positions[placePositionId - 1].coordinates,
                      placeCategory: 0,
                      placePhoneNumber: doc.querySelector('.info .tel').textContent.trim(),
                      tripTime: null
                    };

                    $("#placeTagsList" + indexCheck)
                            .append("<div id='placeTags" + indexCheck + "'>#" + title + "</div>")
                            .append("<div hidden id='place" + (placeCount + 1) + "'>" + JSON.stringify(place) + "</div>")
                            .append("<div id='tripTime" + (placeCount + 1) + "'></div>");

                    maps[indexCheck].setBounds(bounds);
                  };
                })(marker, places[i].place_name);
                fragment.appendChild(itemEl);
              }
              listEl.appendChild(fragment); // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
              menuEl.scrollTop = 0;

              maps[indexCheck].setBounds(bounds); // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            }

            function tripTime(placeTripPositions, placeCount) {

              console.log("place test : " + placeTripPositions);

              var start = placeTripPositions[placeTripPositions.length-2]; // 저장된 명소들의 시작지점 명소를 저장할때마다 추가되기에 배열크기의 -2
              var end = placeTripPositions[placeTripPositions.length-1]; // 저장된 명소들의 종료지점 명소를 저장할때마다 추가되기에 배열크기의 -1

              $.ajax({ // 명소간 이동시간 구하기(길찾기 API)
                url: "/tripPlan/tripTime",
                type: "GET",
                data: {start: start, end: end},
                dataType: "JSON",
                success: function (data) {
                  var hour = parseInt(data.hour);
                  var minute = parseInt(data.minute);

                  if(hour == 0) {
                    $("#placeTagsList" + indexCheck).find("#tripTime" + placeCount).text(minute + "분");
                    totalTripTimes[indexCheck] = (totalTripTimes[indexCheck] || 0) + minute;
                  } else {
                    $("#placeTagsList" + indexCheck).find("#tripTime" + placeCount).text(hour + "시간 " + minute + "분");
                    totalTripTimes[indexCheck] = (totalTripTimes[indexCheck] || 0) + (hour * 60) + minute;
                  }
                  var totalHours = Math.floor(totalTripTimes[indexCheck] / 60);
                  var totalMinutes = totalTripTimes[indexCheck] % 60;
                  if(totalHours == 0){
                    $("#totalTripTime" + indexCheck).text("총 이동시간: " + totalMinutes + "분");
                  } else {
                    $("#totalTripTime" + indexCheck).text("총 이동시간: " + totalHours + "시간 " + totalMinutes + "분");
                  }
                },
                error: function (xhr, status, error) {
                  console.log(error);
                }
              });
            }

            function addMarker(position, idx, indexCheck) {  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
              var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png',
                      imageSize = new kakao.maps.Size(36, 37),
                      imgOptions = {
                        spriteSize: new kakao.maps.Size(36, 691),
                        spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
                        offset: new kakao.maps.Point(13, 37)
                      },
                      markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                      marker = new kakao.maps.Marker({
                        position: position,
                        image: markerImage
                      });
              return marker;
            }

            function getListItem(indexCheck, places) {  // 검색결과 항목을 Element로 반환하는 함수입니다
              var el = document.createElement('li'),
                      itemStr = '<span class="markerbg marker_' + (indexCheck+1) + '"></span><div class="info"><h5>' + places.place_name + '</h5>';
              if (places.road_address_name) {
                itemStr += '    <span>' + places.road_address_name + '</span><span class="jibun gray">' +  places.address_name  + '</span>';
              } else {
                itemStr += '    <span>' +  places.address_name  + '</span>';
              }
              itemStr += '  <span class="tel">' + places.phone  + '</span></div>';
              el.innerHTML = itemStr;
              el.className = 'item';
              return el;
            }

            function displayPagination(pagination) {  // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
              var paginationEl = document.getElementById('pagination'),
                      fragment = document.createDocumentFragment(),
                      i;
              // 기존에 추가된 페이지번호를 삭제합니다
              while (paginationEl.hasChildNodes()) {
                paginationEl.removeChild (paginationEl.lastChild);
              }
              for (i=1; i<=pagination.last; i++) {
                var el = document.createElement('a');
                el.href = "#";
                el.innerHTML = i;
                if (i===pagination.current) {
                  el.className = 'on';
                } else {
                  el.onclick = (function(i) {
                    return function() {
                      pagination.gotoPage(i);
                    }
                  })(i);
                }
                fragment.appendChild(el);
              }
              paginationEl.appendChild(fragment);
            }

            function displayInfowindow(marker, title, indexCheck) {  // 명소리스트 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
              var content = '<div style="padding:5px;z-indexCheck:1;">' + title + '</div>';
              infowindow.setContent(content); // 설명창 내부에 표시될 글
              infowindow.open(maps[indexCheck], marker); // 설명창 띄움
            }

            function removeAllChildNods(el) {  // 검색결과 목록의 자식 Element를 제거하는 함수입니다
              while (el.hasChildNodes()) {
                el.removeChild (el.lastChild);
              }
            }

            function removeMarker() {  //지도 위에 표시되고 있는 마커를 모두 제거합니다
              for ( var i = 0; i < markers.length; i++ ) {
                markers[i].setMap(null);
              }
              markers = [];
            }

          }
    }


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


    function deletePlace(mapIndex, placeIndex) {
        var placeTagsList = document.querySelector('#placeTagsList' + mapIndex + '_' + placeIndex);
        var mapId = placeTagsList.dataset.mapId;

        console.log(placeTagsList);
            console.log(mapId);

        if(placeIndex == 0) {
            alert("맨처음 여행지는 지울수없습니다.");
        } else {

            // 해당 명소 정보를 삭제
            //var placeInfoElement = placeTagsList.children[placeIndex];
            //placeTagsList.removeChild(placeInfoElement);

            // 배열에서 해당 명소 정보 삭제
            //var deleteIndex = mapIndex * markerLengthCheck + placeIndex;
            //markers.splice(mapIndex, 1);
            //placeTripPositions[mapIndex].splice(placeIndex, 1);

            // 총 이동시간 재계산
            //var totalTripTime = calculateTotalTripTime(mapIndex);
            //tripTime.innerHTML = "총 이동시간: " + totalTripTime;
        }
    }

    function calculateTotalTripTime(mapIndex) {
        console.log("토탈 이동 시간 : " + totalTripTime);
        var start = placeTripPositions[mapIndex][placeTripPositions.length-2]; // 저장된 명소들의 시작지점 명소를 저장할때마다 추가되기에 배열크기의 -2
        var end = placeTripPositions[mapIndex][placeTripPositions.length-1]; // 저장된 명소들의 종료지점 명소를 저장할때마다 추가되기에 배열크기의 -1
        console.log(start + "///" + end);

        for(var i=0; i<placeTripPositions[mapIndex].length; i++){

            $.ajax({ // 명소간 이동시간 구하기(길찾기 API)
                url: "/tripPlan/tripTime",
                type: "GET",
                data: {start: start, end: end},
                dataType: "JSON",
                success: function (data) {

                  console.log(data);

                  var hour = parseInt(data.hour);
                  var minute = parseInt(data.minute);

                  if(hour == 0) {
                    console.log("흠터레스팅 : " + totalTripTimes[mapIndex]);
                    totalTripTimes[mapIndex] = (totalTripTimes[mapIndex] || 0) - minute;
                    console.log(totalTripTimes);
                  } else {
                    console.log("흠터레스팅 : " + totalTripTimes[mapIndex]);
                    totalTripTimes[mapIndex] = (totalTripTimes[mapIndex] || 0) - (hour * 60) + minute;
                    console.log(totalTripTimes);
                  }
                  var totalHours = Math.floor(totalTripTimes[mapIndex] / 60);
                  var totalMinutes = totalTripTimes[mapIndex] % 60;
                  if(totalHours == 0){
                    $("#totalTripTime" + mapIndex).text("총 이동시간: " + totalMinutes + "분");
                  } else {
                    $("#totalTripTime" + mapIndex).text("총 이동시간: " + totalHours + "시간 " + totalMinutes + "분");
                  }
                },
                error: function (xhr, status, error) {
                  console.log(error);
                }
            });
        }
    }


    $(function() {
         $("button[id='updateTripPlan']").on("click", function() {
            window.location.href = "/tripPlan/updateTripPlan";
         });
    });

    $(function() {
         $("button[id='history']").on("click", function() {
              console.log("취소");
         });
    });

    $(function() {
         $("button[id='check']").on("click", function() {
              console.log("확인용");
              console.log("maps : " + maps);
              console.log("placeTripPositions : " + placeTripPositions);
         });
    });


</script>
</html>