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
    <!-- sortable -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script> // sortable 스크립트
      $(function () {
         $(".column").sortable({
            // 드래그 앤 드롭 단위 css 선택자
            connectWith: ".column",
            // 움직이는 css 선택자
            handle: ".card-header",
            // 움직이지 못하는 css 선택자
            cancel: ".no-move",
            // 이동하려는 location에 추가 되는 클래스
            placeholder: "card-placeholder",
            // 요소를 잡는 순간 실행
            start : function(event, ui){
               $(this).css('background-color', 'rgb(213,222,232)');
            },
            // 모든 이동이 끝난 후에 마지막으로 실행
            stop : function(event, ui){
               $(this).css('background-color', 'transparent');
            }
         });
         // 해당 클래스 하위의 텍스트 드래그를 막는다.
         $(".column .card").disableSelection();
      });

      // 삭제 라벨
      $(document).on('click', ".deleteBox", function(){
         var id = $(this).attr('id');
         var index = $(this).data('index');

         console.log("id : " + id);
         console.log("index : " + index);
         console.log("varStatus : " + varStatusIndex[id]);

         if(index == 0 || varStatusIndex[id] == 0) {
            alert("첫번째값은 다른 명소가 있는 경우에는 삭제시킬수없습니다. 나중에 앞서 다른 명소들 삭제후 삭제시킬수있게 만들것이며 이동순서를 바꿔서 삭제");
         } else {
             var prevTripTimeEl = document.querySelector('.card.text-white.mb-3[id="' + id + '"][data-index="' + (index - 1) + '"]'); // 명소를 삭제했을 때 이전 시간 리스트박스
             var newTripTimeEl = document.createElement('div'); // 대체할 새로운 시간 리스트박스
             newTripTimeEl.className = 'card text-white mb-3';
             newTripTimeEl.setAttribute('id', id);
             newTripTimeEl.setAttribute('name', 'tripTime');
             newTripTimeEl.style.backgroundColor = 'rgb(200, 94, 153)';
             newTripTimeEl.setAttribute('data-index', index - 1);

             var tripTimeEl = document.querySelector('.card.text-white.mb-3[id="' + id + '"][data-index="' + index + '"]'); // 명소를 삭제했을 때 시간 리스트박스

             // 배열에서 해당 명소 정보 삭제
             if (placeTripTimes['map' + id][index] != undefined || placeTripTimes['map' + id][index] != null) {
               totalTripTimes[id] = totalTripTimes[id] - placeTripTimes['map' + id][index]; // 시간을 다시 구하기 위해 총 더한 시간에서 없어진 시간들을 지움
               tripTimeEl.parentNode.replaceChild(newTripTimeEl, tripTimeEl); // 시간 리스트박스를 대체할 새로운 시간 리스트박스로 교체
             }

             totalTripTimes[id] = totalTripTimes[id] - placeTripTimes['map' + id][index-1]; // 시간을 다시 구하기 총 더한 시간에서 없어진 시간들을 지움
             prevTripTimeEl.parentNode.removeChild(prevTripTimeEl);

             $("#totalTripTime" + id).text(totalTripTimes[id]);
             placeTripTimes['map' + id].splice(index-1, index+1); // 시간을 다시 구하기 위해서 앞뒤로 지워야함
             placeTripPositions[id].splice(index, index); // 삭제된 좌표 인덱스
             allPlaces['map' + id].splice(index, index); // 삭제된 명소정보

             // 이후 남아있는 리스트박스들의 id 값을 업데이트
             var elTripTimes = document.querySelectorAll('.card.text-white.mb-3[id="' + id + '"]');
             if(index != elTripTimes.length){
                 for (var i = index; i < elTripTimes.length; i++) {
                   elTripTimes[i].setAttribute('data-index', i);
                 }
             }else {
                elTripTimes[index-1].setAttribute('data-index', index-1);
             }
             var elCategory = document.querySelectorAll('.card-header[name="placeCategory"][id="' + id + '"]');
             for (var i = index; i < elCategory.length; i++) {
               elCategory[i].setAttribute('data-index', i-1);
               console.log(elCategory[i]);
             }
             var elDeleteBoxes = document.querySelectorAll('.deleteBox[id="' + id + '"]');
             for (var i = index; i < elDeleteBoxes.length; i++) {
               elDeleteBoxes[i].setAttribute('data-index', i-1);
               console.log(elDeleteBoxes[i]);
             }
             var elPlaceTitles = document.querySelectorAll('.card-title[name="placeTitle"][id="' + id + '"]');
             for (var i = index; i < elPlaceTitles.length; i++) {
               elPlaceTitles[i].setAttribute('data-index', i-1);
               console.log(elPlaceTitles[i]);
             }

             varStatusIndex[id]--;
             console.log("varStatusIndex[id] : " + varStatusIndex[id]);
             console.log("placeTripPositions[id] : " + placeTripPositions[id]);

             var start = placeTripPositions[id][index-1];
             var end = placeTripPositions[id][index];
             if( end != null) { // 마지막 값이 없다면 시간을 다시 찾지않는다.
                $.ajax({ // 명소간 이동시간 구하기(길찾기 API)
                     url: "/tripPlan/tripTime",
                     type: "GET",
                     data: {start: start, end: end},
                     dataType: "JSON",
                     success: function (data) {

                       var hour = parseInt(data.hour);
                       var minute = parseInt(data.minute);

                       if (hour == 0) {
                           newTripTimeEl.textContent = minute;
                           placeTripTimes['map' + id].splice(index - 1, 0, minute);
                           totalTripTimes[id] = (totalTripTimes[id] || 0) + minute;
                         } else {
                           newTripTimeEl.textContent = (hour * 60) + minute;
                           placeTripTimes['map' + id].splice(index - 1, 0, (hour * 60) + minute);
                           totalTripTimes[id] = (totalTripTimes[id] || 0) + (hour * 60) + minute;
                         }

                       $("#totalTripTime" + id).text(totalTripTimes[id]);
                     },
                     error: function (xhr, status, error) {
                       console.log(error);
                     }
               });
             }

             $(this).parent().parent().remove();
         }

      });
    </script>

    <script type="text/javascript">
        let markers = []; // 오버레이 클릭시 보여줄 정보를 담은 배열
        let maps = []; // 각 지도의 배열
        let placeTripPositions = []; // 이동시간 구하기 위한 명소의 좌표배열
        let placeTripTimes = []; // 좌표와 좌표사이의 이동시간들을 담아둔 배열
        let allPlaces = []; // 각 지도별 명소들의 배열로 저장되었었던 명소와 새로운 명소들
        let totalTripTimes = []; // 총 이동시간들의 배열
        let overlays = []; // 기존 저장되어있던 마커

        let totalTripTime; // 이동시간을 구하여 시간 분으로 파씽하기 위한 변수
        let isPlanPublic = false; // 공유여부
        let isPlanDownloadable = false; // 가져가기 여부
        let markerLengthCheck = ${tripPlan.tripDays}; // 저장된 여행일수를 통하여 배열의 크기 조정하기위해
    </script>

</head>
<body>
    <h1>여행플랜</h1>
    <div>
        공개<input type="checkbox" id="chbispublic" class="round" value="true"/>
        비공개<input type="checkbox" id="chbpublic" class="round" value="false" checked="true" disabled/>
        가져가기 가능<input type="checkbox" id="chbIsDownloadle" class="round" value="true" disabled/>
        가져가기 불가능<input type="checkbox" id="chbDownloadle" class="round" value="false" disabled/>
    </div>
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
        <input type="text" style='width:450px' id="tripPlanTitle" name="tripPlanTitle" value="${tripPlan.tripPlanTitle}" />
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
                </script>
                <div id='totalTripTime${i-1}' class='totalTripTime'>총 이동시간 ${dailyPlan.totalTripTime}</div>
                    <!-- 세로 리스트 박스 -->
                    <div class="col-12 column" id="placeTagsList${i-1}">
                    <c:set var="varStatus" value="" />
                    <c:forEach var="place" items="${dailyPlan.placeResultMap}" varStatus="varStatus">
                        <c:set var="varStatus" value="${varStatus}" scope="request" />
                        <tr>
                            <!-- sortable 적용을 위해 선언하는 세로 리스트 박스 -->
                            <div class="col-12 column">
                                <!-- 각 카드 리스트 박스 -->
                                <div class="card text-white mb-3 " style="background-color: rgb(76, 94, 153);">
                                   <div class="card-header" name="placeCategory" id="${i-1}" data-index="${varStatus.index}">${place.placeCategory}
                                   <label class="deleteBox" name="deleteBox" id="${i-1}" data-index="${varStatus.index}"> [삭제]</label></div>
                                   <div class="card-body">
                                      <h6 class="card-title" name="placeTitle" id="${i-1}" data-index="${varStatus.index}">#${place.placeTags}</h5>
                                   </div>
                                </div>
                                <div class="card text-white mb-3 " name="tripTime" id="${i-1}" data-index="${varStatus.index}" style="background-color: rgb(200, 94, 153);">
                                    ${place.tripTime}
                                </div>
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
                            var tripTime = "${place.tripTime}"
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

                            // 명소간 이동시간 저장
                            if (!placeTripTimes[mapId]) {
                              placeTripTimes[mapId] = [];
                            }
                            placeTripTimes[mapId].push(${place.tripTime});

                            var place = {
                              placeTags: placeTags,
                              placeAddress: placeAddress,
                              placeCoordinates: latitude+","+longitude,
                              placeCategory: placeCategory,
                              placeImage: "",
                              placePhoneNumber: placePhoneNumber,
                              tripTime: tripTime
                            };

                            if (!allPlaces[mapId]) {
                              allPlaces[mapId] = [];
                            }
                            allPlaces[mapId].push(place);

                        </script>
                    </c:forEach>
                    </div>
                </table>
            </div>
        </div>
        <button id="reset${i-1}">원위치</button>
        <td colspan="5"><hr></td>
    </c:forEach>
    <c:if test="${user.userId == tripPlan.tripPlanAuthor}">
        <button type="button" id="updateTripPlan">수정하기</button>
    </c:if>
    <button type="button" id="history">이전</button>

</body>

<script type="text/javascript">
    let tripDays = ${tripPlan.tripDays}; // 여행일수의 수량만큼 map 생성

    let varStatusIndex = {}; // 명소에서 동적으로 생성되는 부분의 id값
    for(var i=0; i<tripDays; i++) {
         varStatusIndex[i] = ${varStatus.index};
    }

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


    // 공개 체크박스 클릭
    $("#chbispublic").click(function() {
      isPlanPublic = this.value;
      console.log(isPlanPublic);

      var chbispublic = $(this);
      var chbpublic = $("#chbpublic");
      var chbIsDownloadle = $("#chbIsDownloadle");
      var chbDownloadle = $("#chbDownloadle");

      if (chbispublic.prop("checked")) {
        chbispublic.prop("disabled", true);
        chbpublic.prop("disabled", false);
        chbpublic.prop("checked", false);
        chbIsDownloadle.prop("disabled", false);
        chbDownloadle.prop("checked", true);
        chbDownloadle.prop("disabled", true);
      }
    });

    // 비공개 체크박스 클릭 이벤트 핸들러
    $("#chbpublic").click(function() {
      isPlanPublic = this.value;
      isPlanDownloadable = false; // 가져가기 불가능으로 변경
      console.log(isPlanPublic);

      var chbpublic = $(this);
      var chbispublic = $("#chbispublic");
      var chbIsDownloadle = $("#chbIsDownloadle");
      var chbDownloadle = $("#chbDownloadle");

      if (chbpublic.prop("checked")) {
        chbpublic.prop("disabled", true);
        chbispublic.prop("disabled", false);
        chbispublic.prop("checked", false);
        chbIsDownloadle.prop("checked", false);
        chbDownloadle.prop("checked", false);
        chbIsDownloadle.prop("disabled", true);
        chbDownloadle.prop("disabled", true);
      }
    });

    // 가져가기 가능 체크박스 클릭 이벤트 핸들러
    $("#chbIsDownloadle").click(function() {
      isPlanDownloadable = this.value;
      console.log(isPlanDownloadable);
      var chbIsDownloadle = $(this);
      var chbDownloadle = $("#chbDownloadle");

      chbIsDownloadle.prop("disabled", true);
      chbDownloadle.prop("disabled", false);
      chbDownloadle.prop("checked", false);
    });

    // 가져가기 불가능 체크박스 클릭 이벤트 핸들러
    $("#chbDownloadle").click(function() {
      isPlanDownloadable = this.value;
      console.log(isPlanDownloadable);
      var chbDownloadle = $(this);
      var chbIsDownloadle = $("#chbIsDownloadle");

      chbDownloadle.prop("disabled", true);
      chbIsDownloadle.prop("disabled", false);
      chbIsDownloadle.prop("checked", false);
    });


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

                    if (!placeTripPositions[indexCheck]) { // 배열이 존재하지 않는 경우에만 초기화
                      placeTripPositions[indexCheck] = [];
                    }
                    if (!allPlaces['map' + indexCheck]) { // 배열이 존재하지 않는 경우에만 초기화
                      allPlaces['map' + indexCheck] = [];
                    }

                    console.log("변경전 명소목록");
                    console.log(placeTripPositions[indexCheck]);
                    placeTripPositions[indexCheck].push(positions[placePositionId - 1].coordinates);

                    if(placeTripPositions[indexCheck].length > 1){
                      tripTime(placeTripPositions[indexCheck], varStatusIndex);
                    }

                    var place = {
                      placeTags: doc.querySelector('.info h5').textContent.trim(),
                      placeAddress: doc.querySelector('.info span:not(.tel)').textContent.trim(),
                      placeCoordinates: positions[placePositionId - 1].coordinates,
                      placeCategory: 0,
                      placePhoneNumber: doc.querySelector('.info .tel').textContent.trim(),
                      tripTime: null
                    };
                    allPlaces['map' + indexCheck].push(place);
                    console.log(allPlaces);

                    console.log("varStatusIndex[indexCheck] : " + varStatusIndex[indexCheck]);
                    // 동적 생성
                    var tripTimeEl = document.querySelector('[name="tripTime"][id="' + indexCheck + '"][data-index="' + varStatusIndex[indexCheck] + '"]');

                    var cardBoxEl = document.createElement('div');
                    cardBoxEl.className = 'card text-white mb-3';
                    cardBoxEl.style.backgroundColor = 'rgb(76, 94, 153)';

                    var cardHeaderEl = document.createElement('div');
                    cardHeaderEl.className = 'card-header';
                    cardHeaderEl.setAttribute('name', 'placeCategory');
                    cardHeaderEl.setAttribute('data-index', varStatusIndex[indexCheck]+1);

                    var categoryTitleEl = document.createElement('span');
                    categoryTitleEl.textContent = place.placeCategory;
                    cardHeaderEl.appendChild(categoryTitleEl);

                    var deleteLabelEl = document.createElement('label');
                    deleteLabelEl.className = 'deleteBox';
                    deleteLabelEl.id = indexCheck;
                    deleteLabelEl.textContent = ' [삭제]';
                    deleteLabelEl.setAttribute('name', 'deleteBox');
                    deleteLabelEl.setAttribute('data-index', varStatusIndex[indexCheck]+1);
                    cardHeaderEl.appendChild(deleteLabelEl);

                    var cardBodyEl = document.createElement('div');
                    cardBodyEl.className = 'card-body';

                    var placeTagsEl = document.createElement('h6');
                    placeTagsEl.className = 'card-title';
                    placeTagsEl.id = indexCheck;
                    placeTagsEl.textContent = '#' + title;
                    placeTagsEl.setAttribute('name', 'placeTitle');
                    placeTagsEl.setAttribute('data-index', varStatusIndex[indexCheck]+1);

                    cardBoxEl.appendChild(cardHeaderEl);
                    cardBoxEl.appendChild(cardBodyEl);
                    cardBodyEl.appendChild(placeTagsEl);

                    console.log(tripTimeEl);
                    console.log(cardBoxEl);

                    var placeTagsListEl = tripTimeEl.parentNode;
                    placeTagsListEl.insertBefore(cardBoxEl, tripTimeEl.nextSibling);

                    var newTripTimeEl = document.createElement('div');
                    newTripTimeEl.className = 'card text-white mb-3';
                    newTripTimeEl.setAttribute('name', 'tripTime');
                    newTripTimeEl.setAttribute('id', indexCheck);
                    newTripTimeEl.setAttribute('data-index', varStatusIndex[indexCheck]+1);
                    newTripTimeEl.style.backgroundColor = 'rgb(200, 94, 153)';
                    newTripTimeEl.textContent = place.tripTime;

                    placeTagsListEl.insertBefore(newTripTimeEl, cardBoxEl.nextSibling);

                    varStatusIndex[indexCheck]++;

                    maps[indexCheck].setBounds(bounds);
                  };
                })(marker, places[i].place_name);
                fragment.appendChild(itemEl);
              }
              listEl.appendChild(fragment); // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
              menuEl.scrollTop = 0;

              maps[indexCheck].setBounds(bounds); // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            }

            function tripTime(placeTripPositions, varStatusIndex) {
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
                  console.log("총 이동시간 변경전");
                  console.log(totalTripTimes);

                  var tripTimeEl = document.querySelector('[name="tripTime"][id="' + indexCheck + '"][data-index="' + (varStatusIndex[indexCheck]-1) + '"]');

                  if (hour == 0) {
                    tripTimeEl.textContent = minute;
                    placeTripTimes['map' + indexCheck].push(minute);
                    totalTripTimes[indexCheck] = (totalTripTimes[indexCheck] || 0) + minute;
                  } else {
                    tripTimeEl.textContent = (hour * 60) + minute;
                    placeTripTimes['map' + indexCheck].push((hour * 60) + minute);
                    totalTripTimes[indexCheck] = (totalTripTimes[indexCheck] || 0) + (hour * 60) + minute;
                  }
                  $("#totalTripTime" + indexCheck).text(totalTripTimes[indexCheck]);

                  console.log(placeTripTimes['map' + indexCheck]);
                  console.log("총 이동시간 변경후");
                  console.log(totalTripTimes);

                  console.log("변경후 명소목록");
                  console.log(placeTripPositions);
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


    $(function() {
         $("button[id='updateTripPlan']").on("click", function() {

              var tripPlanTitle = $('#tripPlanTitle').val(); // 여행플랜 제목
              var dailyPlanContents = []; // 일차별 여행플랜 본문과 명소들을 모두 저장하는곳

              for(var i=0; i<tripDays; i++) {
                var dailyPlanContent; // 일차별 여행플랜 본문
                var totalTripTime; // 일차별 명소간 총 이동시간
                var placeInfo = [] // 명소를 저장하는 배열
                var placeSum = 0; // 명소의 갯수 파악

                dailyPlanContent = $('#dailyPlanContents' + i).val();
                totalTripTime = totalTripTimes[i];
                placeSum = varStatusIndex[i];

                for(var j=0; j<placeSum+1; j++){
                    var placeText = allPlaces['map' + i][j];
                    var tripTimeText = placeTripTimes['map' + i][j];
                    var place = placeText; // JSON 문자열을 객체로 파싱
                    place.tripTime = tripTimeText; // 시간 값을 할당
                    placeInfo.push(JSON.stringify(placeText));
                }

                dailyPlanContents.push({
                  dailyPlanContents: dailyPlanContent,
                  totalTripTime: totalTripTime,
                  placesInfo: placeInfo
                });
              }

              if(tripPlanTitle == null || tripPlanTitle.length<1){
                alert("여행플랜 제목을 빈칸일수없습니다.");
                return;
              }
              if(dailyPlanContents == null || dailyPlanContents.length<1){
                alert("플랜본문은 1개 이상 입력하여야 저장가능합니다.");
                return;
              }

              var tripPlan = {
                tripPlanNo: ${tripPlan.tripPlanNo},
                tripPlanTitle: tripPlanTitle,
                tripDays: tripDays,
                isPlanPublic: isPlanPublic,
                isPlanDownloadable: isPlanDownloadable,
                dailyplanResultMap: dailyPlanContents.map(function (dailyPlan) {
                  return {
                    dailyPlanContents: dailyPlan.dailyPlanContents,
                    totalTripTime: dailyPlan.totalTripTime,
                    placeResultMap: dailyPlan.placesInfo.map(function (place) {
                      return JSON.parse(place); // JSON 문자열을 객체로 변환
                    }),
                  };
                }),
              };

              console.log(tripPlan);


              $.ajax({ // JSON 형태로 저장하여 RestContoller로 ajax통신
                  url: "/tripPlan/updateTripPlan",
                  type: "POST",
                  data: JSON.stringify(tripPlan),
                  contentType: "application/json; charset=utf-8",
                  success: function () {
                    window.location.href = "/tripPlan/tripPlanList"; // 내 리스트로 변경하여보내기
                  },
                  error: function (xhr, status, error) {
                    console.log(error);
                  }
              });

         });
    });

    $(function() {
         $("button[id='history']").on("click", function() {
              console.log("취소");
         });
    });

    $(function() {
         $("button[id='check']").on("click", function() {

         });
    });

</script>
</html>