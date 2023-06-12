<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Mold Discover . HTML Template</title>

  <!-- 구분선 -->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a&libraries=services"></script>
  <link rel="stylesheet" href="/css/tripplan/tripplan.css">
<%--    <link rel="stylesheet" href="/css/tripplan/overlay.css">--%>
  <!-- jqurey -->
  <script src="/vendor/jquery/dist/jquery.min.js"></script>
  <script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
  <!-- 서머노트 CDN 링크 -->
  <link rel="stylesheet" href="/summernote/summernote.css">
  <script src="/summernote/summernote.js"></script>
  <!-- alert -->
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <!-- 구분선 -->

  <link rel="icon" type="image/png" href="assets/img/favicon.png" />
  <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
  <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
  <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
  <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
  <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
  <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

  <!-- 설정용 변수 -->
  <script>
    let markers = []; // 마커를 담을 배열입니다
    let markersBound = []; // 마커가 여러개일 경우 버튼을 눌러서 화면을 재구성하기 위한 배열
    let maps = []; // 생성    된 지도를 저장할 배열
    let placeTripPositions = []; // 이동시간 구하기 위한 명소배열
    let placeTripTimes = [];
    let allPlaces = [];
    let totalTripTimes = [];
    let polylineArray = []; // 명소간 이동경로를 보여주기 위한 경로
    let pathArray = []; // 디비에 저장할 이동경로 패스값

    let mapOptions = { // 지도 옵션
      center: new kakao.maps.LatLng(37.566826, 126.9786567),
      level: 3
    };

    let isPlanPublic = ${tripPlan.getisPlanPublic()}; // 공유여부
    let isPlanDownloadable = false; // 가져가기 여부
    let mapCounter = 1; // 지도 갯수 카운트
    let idCheck = ${tripPlan.tripDays}; // 여행일수의 수량만큼 map 생성
  </script>

  <style>
    .day {
      font-size: 30px; /* 원하는 크기로 설정 */
      font-weight: bold; /* 굵은 글씨체 설정 */
    }
  </style>
  <style>
    /* 리스트 css */
    .column {
      border: 1px solid #cecece;
      padding-top: 10px;
      padding-bottom: 10px;
    }

    .container-fluid .card {
      margin-left: auto;
      margin-right: auto;
    }

    /* 마우스 포인터를 손가락으로 변경 */
    .card:not(.no-move) .card-header {
      cursor: pointer;
    }
  </style>

  <c:if test="${empty sessionScope.user.userId}">
    <script>
      // 유저가 로그인되어 있지 않은 경우
      alert("접근 권한이 없습니다.")
      history.back();
    </script>
  </c:if>

</head>

<body>

<header class="nav-menu fixed">
  <%@ include file="/WEB-INF/views/layout/header.jsp" %>
</header>


<div class="post-single left">
  <div class="page-img" style="background-image: url('/images/tripImage.jpg');">
    <div class="page-img-txt container">
      <div class="row">
        <div class="col-sm-8">
          <h2>
            <div class="author-img">
                <img src="/images/tripImage.jpg" alt="">
            </div>
          </h2>
          <p class="byline">
          <h4>
            <span class="italic">${tripPlan.tripPlanAuthor}</span>
            <span class="dot">·</span>
            <span>${tripPlan.tripPlanRegDate}</span>
            <span class="dot">·</span>
            <span>${tripPlan.tripPlanLikes}</span>
            <span class="dot">·</span>
            <td id="likes" align="center" width="200">${tripPlan.tripPlanLikes}</td>
          </h4>
          </p>
        </div>
        <div class="colsm-4">
        </div>
      </div>
    </div>
  </div>


<main class="white">
  <div class="container">
    <div >
      <span><h4><input type="text" id="tripPlanTitle" value="${tripPlan.tripPlanTitle}" style="color: black; width: 57%; height: 40px; "></h4></span>
      <h5>
        <c:if test="${tripPlan.getisPlanPublic()}">
          공개<input type="checkbox" id="chbispublic" class="round" value="true" checked="true" disabled/>&nbsp;&nbsp;
          비공개<input type="checkbox" id="chbpublic" class="round" value="false" />
        </c:if>
        <c:if test="!${tripPlan.getisPlanPublic()}">
          공개<input type="checkbox" id="chbispublic" class="round" value="true" />&nbsp;&nbsp;
          비공개<input type="checkbox" id="chbpublic" class="round" value="false" checked="true" disabled/>
        </c:if>
      </h5>
      <div style="text-align: right;">
        <div class="tag-link">여행일수</div>
        <button class="icon-triangle-up" id="btnAddTripDay"
                style="background-color: #558B2F;"></button>
        <button class="icon-triangle-down" id="btnRemoveTripDay"
                style="background-color: #558B2F;"></button>
      </div>
    </div>
  </div>

  <c:set var="i" value="0"/>
  <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
  <c:set var="i" value="${ i+1 }"/>
  <div class="container" id="container${i-1}">
    <div class="day"> ${i}일차 여행플랜 </div>
    <div class="row">
      <div class="col-sm-7">
        <textarea id="dailyPlanContents${i-1}" name="dailyPlanContents" required style="width: 100%;">${dailyPlan.dailyPlanContents}</textarea>
      </div>

      <div class="col-sm-5">
        <div class="sidebar">
          <div class="border-box">
            <div id="menu_wrap0"></div>
            <div class="box-title">
              <div class="input-group">
                <input type="text" class="form-control" id="placeName${i-1}"
                       onkeypress="handleKeyPress(event, ${i-1})" placeholder="명소 검색">
                <div class="input-group-btn">
                  <button class="btn btn-primary" id="placeSearch${i-1}"
                          onclick="handleKeyPress(event, ${i-1})">Search
                  </button>
                </div>
              </div>
            </div>
            <button class="icon-locate-map" id="reset${i-1}" onclick="reset(event, ${i-1})"></button>
            <div id="map${i-1}" style="width: 100%; height: 300px;"></div>
            <ul id="placesList${i-1}"></ul>
            <div id="pagination"></div>
          </div>

          <div class="border-box">
            <div class="box-title">명소리스트
              <div class="tag-link" style="text-align: right;" id="totalTripTime${i-1}">${dailyPlan.totalTripTime}</div>
            </div>
            <c:set var="j" value="0"/>
            <c:forEach var="place" items="${dailyPlan.placeResultMap}">
              <c:set var="j" value="${ j+1 }"/>
            <ul class="list${i-1}">
              <div class="col-12 column">
                <div class="card text-white mb-3" style="background-color: rgb(80, 250, 120); width: auto; height: auto; text-align: center;">
                  <div class="card-header" name="placeCategory" id="placeCategory${i-1}" data-index="${j-1}"></div>
                  <label class="deleteBox" name="deleteBox" id="deleteBox${i-1}" data-index="${j-1}">[삭제]</label>
                  <div class="card-body">
                    <h4 class="card-title" name="placeTitle" id="placeTitle${i-1}" data-index="${j-1}"></h4>
                      ${place.placeTags}
                  </div>
                  <div class="card text-white mb-3" name="tripTime" id="tripTime${i-1}" data-index="${j-1}" style="background-color: white; width: auto; height: auto; text-align: center;">${place.tripTime}</div>
                </div>
                <div></div>
              </div>
            </ul>
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
                var mapIndex = 'map${i-1}'; // 해당 명소의 맵 ID

                // 명소간 이동시간 저장
                if (!placeTripTimes[mapIndex]) {
                  placeTripTimes[mapIndex] = [];
                }
                placeTripTimes[mapIndex].push(${place.tripTime});

                // 포지션과 mapId는 처음 읽어들어왔을때 중심점 잡기위해
                var place = {
                  placeTags: placeTags,
                  placeAddress: placeAddress,
                  placeCoordinates: latitude + "," + longitude,
                  placeCategory: placeCategory,
                  placeImage: "",
                  placePhoneNumber: placePhoneNumber,
                  tripTime: tripTime,
                  position: markerPosition,
                  mapId: mapIndex
                };

                if (!allPlaces[mapIndex]) {
                  allPlaces[mapIndex] = [];
                }
                allPlaces[mapIndex].push(place);

              </script>
            </c:forEach>
          </div>
        </div>
      </div>
    </div>
    </c:forEach>
    <div class="addDaily" id="addDaily" style="text-align: right;">
      <button class="btn btn-primary" id="btnUpdateTripPlan">수정</button>
      <button class="btn btn-primary" id="history">취소</button>
    </div>
  </div>
</main>
</div>

  <footer id="footer">
    <div class="container">
      <div class="row">
        <div class="col-sm-7 col-md-3">
          <h3>Mold Discover</h3>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequuntur, quia, architecto? A, reiciendis eveniet! Esse est eaque adipisci natus rerum laudantium accusamus magni.</p>
        </div>
        <div class="col-sm-5 col-md-2">
          <h3>Quick Link</h3>
          <ul>
            <li>Holiday Package</li>
            <li>Summer Adventure</li>
            <li>Bus and Trasnportation</li>
            <li>Ticket and Hotel Booking</li>
            <li>Trek and Hikings</li>
          </ul>
        </div>
        <div class="col-sm-7 col-md-4">
          <h3>Newsletter Signup</h3>
          <p>Subscribe to our weekly newsletter to get news and update</p>
          <br>
          <div class="input-group">
            <input type="text" class="form-control" placeholder="Your Email">
            <div class="input-group-btn">
              <button class="btn btn-primary">Subscribe</button>
            </div>
          </div>
        </div>
        <div class="col-sm-5 col-md-2">
          <h3>Contact Info</h3>
          <ul>
            <li>Mold Discover</li>
            <li>info@moldthemes.com</li>
          </ul>
          <div class="clearfix">
            <div class="social-icon-list">
              <ul>
                <li>
                  <a href="https://twitter.com/moldthemes" class="icon-twitter"></a>
                </li>
                <li>
                  <a href="mailto:info@moldthemes.com" class="icon-mail"></a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="copy"><span>&copy;</span> Copyright Mold Discover, 2017</div>
  </footer>

    /////////////////////// 아래는 설정용 스크립트 입니다. ////////////////////////////

  <script>
    <!-- 서머노트기본생성 -->
    console.log(idCheck);
    for (var i = 0; i < idCheck; i++) {
      var elementId = 'dailyPlanContents' + i;
      createSummerNoteElement(elementId);
    }

    function createSummerNoteElement(elementId) {
      $('#' + elementId).summernote({
        callbacks: {
          onImageUpload: function (files) {
            // 이미지 업로드 후, 이미지 태그에 contenteditable 속성을 false로 설정
            var img = $('<img>').attr('src', URL.createObjectURL(files[0]));
            img.attr('contenteditable', false);
            $(this).summernote('insertNode', img[0]);
          }
        },
        toolbar: [
          ['fontname', ['fontname']],
          ['fontsize', ['fontsize']],
          ['style', ['bold', 'italic', 'underline']],
          ['color', ['forecolor', 'color']],
          ['table', ['table']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['height', ['height']],
          ['insert', ['picture']],
        ],
        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
        fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72'],
        height: 620,
        disableResizeEditor: true
      });
    };

    function initializeSummernote(idCheck) {
      $('#dailyPlanContents' + idCheck).summernote({
        callbacks: {
          onImageUpload: function (files) {
            // 이미지 업로드 후, 이미지 태그에 contenteditable 속성을 false로 설정
            var img = $('<img>').attr('src', URL.createObjectURL(files[0]));
            img.attr('contenteditable', false);
            $(this).summernote('insertNode', img[0]);
          }
        },
        toolbar: [
          ['fontname', ['fontname']],
          ['fontsize', ['fontsize']],
          ['style', ['bold', 'italic', 'underline']],
          ['color', ['forecolor', 'color']],
          ['table', ['table']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['height', ['height']],
          ['insert', ['picture']],
        ],
        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
        fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72'],
        focus: true,
        height: 620,
        disableResizeEditor: true
      });
    }

    <!-- 체크박스 true, false -->
    $("#chbispublic").click(function () {

      isPlanPublic = this.value;
      console.log(isPlanPublic);

      var chbispublic = $(this);
      var chbpublic = $("#chbpublic");

      if (chbispublic.prop("checked")) {
        chbispublic.prop("disabled", true);
        chbpublic.prop("disabled", false);
        chbpublic.prop("checked", false);
      }
    });

    // 비공개 체크박스 클릭 이벤트 핸들러
    $("#chbpublic").click(function () {
      isPlanPublic = this.value;
      console.log(isPlanPublic);

      var chbpublic = $(this);
      var chbispublic = $("#chbispublic");

      if (chbpublic.prop("checked")) {
        chbpublic.prop("disabled", true);
        chbispublic.prop("disabled", false);
        chbispublic.prop("checked", false);
      }
    });
  </script>

  <!-- 지도 관련 -->
  <script>

    $(function () { // 맵 생성 및 화면 재구성
      for (var i = 0; i < idCheck; i++) { // map의 아이디를 동적으로 할당하여 생성
        var mapContainer = document.getElementById('map' + i);
        var map = new kakao.maps.Map(mapContainer, mapOptions);
        maps.push(map);
      }
      $(maps).each(function (index, map) { // 각 지도마다 들어있는 마커를 기준으로 화면 재구성


        var bounds = new kakao.maps.LatLngBounds();
        var mapId = 'map' + index;
        var mapMarkers = allPlaces['map' + index].filter(function (marker) {
          return marker.mapId === mapId;
        });

        $(mapMarkers).each(function (index, marker) {
          var markerOptions = {
            position: marker.position,
            map: map
          };
          var marker = new kakao.maps.Marker(markerOptions);
          marker.setMap(map);
          bounds.extend(markerOptions.position);
        });


        var mapPlaces = []; // map별로 나눠서 배열에 저장하기 위하여 선언
        for (var i = 0; i < mapMarkers.length; i++) { // 안에 여러개의 명소가 있을수 있으므로 하나씩 저장
          var longitude = mapMarkers[i].position.La;
          var latitude = mapMarkers[i].position.Ma;
          mapPlaces.push(longitude + "," + latitude);
        }
        placeTripPositions.push(mapPlaces);

        map.setBounds(bounds);
      });
    });

    function handleKeyPress(event, indexCheck) {
      console.log(indexCheck)
      if (event.type === 'click' || event.keyCode === 13) {
        // 검색창에 입력한 키워드로 목록 출력 요청
        var ps = new kakao.maps.services.Places();
        var infowindow = new kakao.maps.InfoWindow({zindexCheck: 1});

        searchPlaces();

        function searchPlaces() {
          var keyword = document.getElementById('placeName' + indexCheck).value;
          if (!keyword.replace(/^\s+|\s+$/g, '')) {
            alert('키워드를 입력해주세요!');
            return false;
          }
          ps.keywordSearch(keyword, placesSearchCB);
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

        // 검색 결과 목록과 마커를 표출하는 함수입니다
        function displayPlaces(places) {
          var listEl = document.getElementById('placesList' + indexCheck),
                  menuEl = document.getElementById('menu_wrap' + indexCheck),
                  fragment = document.createDocumentFragment(),
                  bounds = new kakao.maps.LatLngBounds(),
                  listStr = '';
          removeAllChildNods(listEl); // 다시 검색했을때 이전 결과 목록 항목들을 제거합니다
          var positions = []; // 검색된 항목들 위도, 경도 저장하는 배열

          for (var i = 0; i < places.length; i++) {
            // 마커를 생성하고 지도에 표시
            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                    marker = addMarker(placePosition),
                    itemEl = getListItem(i, places[i]);

            positions.push({coordinates: placePosition.La + "," + placePosition.Ma}); // 반복문에 출력되는 위도+경도 저장
            // 검색된 장소들의 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 목록이나 지도상에 마우스를 올릴때 동작하는 함수들
            (function (marker, title) {
              kakao.maps.event.addListener(marker, 'mouseover', function () {
                displayInfowindow(marker, title, indexCheck);
              });
              kakao.maps.event.addListener(marker, 'mouseout', function () {
                infowindow.close();
              });
              kakao.maps.event.addListener(marker, 'click', function () {
                var bounds = new kakao.maps.LatLngBounds();
                bounds.extend(marker.getPosition());
                maps[indexCheck].setBounds(bounds);
              });
              itemEl.onmouseover = function () {
                displayInfowindow(marker, title, indexCheck);
                maps[indexCheck].panTo(marker.getPosition()); // 마우스를 올린 위치로 자연스럽게 이동
              };
              itemEl.onmouseout = function () {
                infowindow.close();
                marker.setMap(null);
              };
              itemEl.onclick = function () {

                // 배열이 존재하지 않는 경우에만 초기화
                if (!placeTripPositions[indexCheck]) {
                  placeTripPositions[indexCheck] = [];
                }
                if (!allPlaces['map' + indexCheck]) {
                  allPlaces['map' + indexCheck] = [];
                }
                if (!placeTripTimes['map' + indexCheck]) {
                  placeTripTimes['map' + indexCheck] = [];
                }
                if (!markers[indexCheck]) {
                  markers[indexCheck] = [];
                }
                if (!polylineArray[indexCheck]) {
                  polylineArray[indexCheck] = [];
                }
                if (!pathArray[indexCheck]) {
                  pathArray[indexCheck] = [];
                }

                marker.setMap(maps[indexCheck]); // 해당 지도에 마커를 표출합니다
                markers[indexCheck].push(marker); // 해당 지도의 마커 배열에 추가합니다

                console.log("아 마커스 제대로 추가?")
                console.log(markers[indexCheck]);
                console.log(markersBound);
                console.log(allPlaces['map' + indexCheck]);
                console.log("아 마커스 제대로 추가?")

                infowindow.close();
                displayPagination(pagination);

                removeAllChildNods(listEl); // 검색목록 초기화
                $("#placeName" + indexCheck).val(""); // 검색창 초기화

                // 목록에서 선택한 명소정보에 대해서 몇번째인지 파싱
                var parser = new DOMParser();
                var doc = parser.parseFromString(this.innerHTML, "text/html");
                var placePositionId = this.innerHTML.split('marker_')[1].split('"')[0];

                placeTripPositions[indexCheck].push(positions[placePositionId - 1].coordinates);
                var varStatusIndex = allPlaces['map' + indexCheck].length; // 어느 맵의 몇번째 명소인지

                // 관련 이미지 받아오는 api ajax 호출
                $.ajax({
                  url: 'https://dapi.kakao.com/v2/search/image',
                  type: 'GET',
                  data: {
                    query: title
                  },
                  beforeSend: function(xhr) {
                    xhr.setRequestHeader('Authorization', 'KakaoAK ' + '6e3c7aaa8069d3ffebbb72c6865fb977');
                  },
                  success: function(response) {
                    if (response.documents.length > 0) {
                      var placeImage = response.documents[0].thumbnail_url;
                      console.log(placeImage);

                      // 이미지를 받아온 후에 다음 작업을 진행
                      setTimeout(function() {
                        var place = {
                          placeTags: doc.querySelector('.info h5').textContent.trim(),
                          placeAddress: doc.querySelector('.info span:not(.tel)').textContent.trim(),
                          placeCoordinates: positions[placePositionId - 1].coordinates,
                          placeImage: placeImage,
                          placeCategory: 0,
                          placePhoneNumber: doc.querySelector('.info .tel').textContent.trim(),
                          tripTime: null
                        };
                        allPlaces['map' + indexCheck].push(place);
                      }, 1500); // 1.5초 지연 후에 다음 작업을 수행합니다.
                    } else {
                      console.log('검색 결과가 없습니다.');
                      placeImage = '';
                    }
                  },
                  error: function(xhr, status, error) {
                    console.error(error); // 에러 발생시에도 이미지를 제외하고 저장해야함
                    var place = {
                      placeTags: doc.querySelector('.info h5').textContent.trim(),
                      placeAddress: doc.querySelector('.info span:not(.tel)').textContent.trim(),
                      placeCoordinates: positions[placePositionId - 1].coordinates,
                      placeImage: placeImage,
                      placeCategory: 0,
                      placePhoneNumber: doc.querySelector('.info .tel').textContent.trim(),
                      tripTime: null,
                      tripPath: pathArray[indexCheck][varStatusIndex]
                    };
                    allPlaces['map' + indexCheck].push(place);
                  }
                });


                // 명소 사이 이동시간 구하기
                if (placeTripPositions[indexCheck].length > 1) {
                  tripTime(placeTripPositions[indexCheck], varStatusIndex);
                }

                // 동적 생성
                var newListBox = '<div class="col-12 column">' +
                        '<div class="card text-white mb-3" style="background-color: rgb(80, 250, 120); width: auto; height: auto; text-align: center;">' +
                        '<div class="card-header" name="placeCategory" id="placeCategory' + indexCheck + '" data-index="' + varStatusIndex + '"></div>' +
                        '<label class="deleteBox" name="deleteBox" id="deleteBox' + indexCheck + '" data-index="' + varStatusIndex + '"> [삭제]</label>' +
                        '<div class="card-body">' +
                        '<h4 class="card-title" name="placeTitle" id="placeTitle' + indexCheck + '" data-index=' + varStatusIndex + '></h4>' + title +
                        '</div>' +
                        '<div class="card text-white mb-3" name="tripTime" id="tripTime' + indexCheck + '" data-index=' + varStatusIndex + ' style="background-color: white; width: auto; height: auto; text-align: center;">tripTime</div>' +
                        '</div>' +
                        '<div></div>' +
                        '</div>';

                var newPlaceElement = document.createElement('div');
                newPlaceElement.setAttribute('id', 'newPlaceElement' + indexCheck);
                newPlaceElement.innerHTML = newListBox;

                // 추가할 목록 요소 가져오기
                var listElement = document.querySelector('.list' + indexCheck);

                // 목록 요소에 동적 요소 추가
                listElement.appendChild(newPlaceElement);

                // 마커가 여러개더라도 한화면으로 재구성
                var bounds = new kakao.maps.LatLngBounds();
                for (var i = 0; i < markers[indexCheck].length; i++) {
                  bounds.extend(markers[indexCheck][i].getPosition());
                }
                // 마커들 중앙값 저장 해놓은 배열
                markersBound[indexCheck] = bounds;
                // 입력후 저장된 마커들의 중앙으로 화면 이동
                maps[indexCheck].setBounds(bounds);

              };
            })(marker, places[i].place_name);
            fragment.appendChild(itemEl);
          }
          // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
          listEl.appendChild(fragment);
          //menuEl.scrollTop = 0;
          // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
          maps[indexCheck].setBounds(bounds);
        }

        function tripTime(placeTripPositions, varStatusIndex) {
          var start = placeTripPositions[placeTripPositions.length - 2]; // 저장된 명소들의 시작지점 명소를 저장할때마다 추가되기에 배열크기의 -2
          var end = placeTripPositions[placeTripPositions.length - 1]; // 저장된 명소들의 종료지점 명소를 저장할때마다 추가되기에 배열크기의 -1

          $.ajax({ // 명소간 이동시간 구하기(길찾기 API)
            url: "/tripPlan/tripTime",
            type: "GET",
            data: {start: start, end: end},
            dataType: "JSON",
            success: function (data) {
              var hour = parseInt(data.hour);
              var minute = parseInt(data.minute);
              var polylines = data.polylineCoordinates;

              // 경로 그리기 코드 추가
              var path = polylines.map(function (coordinate) {
                return new kakao.maps.LatLng(coordinate.lat, coordinate.lng);
              });
              pathArray[indexCheck].push(path);

              var polyline = new kakao.maps.Polyline({
                map: maps[indexCheck],
                path: path,
                strokeWeight: 4,
                strokeColor: '#2116fa',
                strokeOpacity: 0.7,
                strokeStyle: 'shortdash'
              });
              polylineArray[indexCheck].push(polyline);

              polyline.setMap(maps[indexCheck]);

              var tripTimeEl = document.querySelector('[name="tripTime"][id="tripTime' + indexCheck + '"][data-index="' + (varStatusIndex - 1) + '"]');
              if (hour == 0) {
                tripTimeEl.textContent = minute + "분";
                placeTripTimes['map' + indexCheck].push(minute);
                totalTripTimes[indexCheck] = (totalTripTimes[indexCheck] || 0) + minute;
              } else {
                tripTimeEl.textContent = (hour * 60) + "시간" + minute + "분";
                placeTripTimes['map' + indexCheck].push((hour * 60) + minute);
                totalTripTimes[indexCheck] = (totalTripTimes[indexCheck] || 0) + (hour * 60) + minute;
              }
              $("#totalTripTime" + indexCheck).text(totalTripTimes[indexCheck]);

            },
            error: function (xhr, status, error) {
              console.log(error);
            }
          });
        }

        function addMarker(position) {  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
              marker = new kakao.maps.Marker({
                position: position
              });
          return marker;
        }

        function getListItem(indexCheck, places) {  // 검색결과 항목을 Element로 반환하는 함수입니다
          var el = document.createElement('li'),
                  itemStr = '<span class="markerbg marker_' + (indexCheck + 1) + '"></span><div class="info"><h5>' + places.place_name + '</h5>';
          if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span><span class="jibun gray">' + places.address_name + '</span>';
          } else {
            itemStr += '    <span>' + places.address_name + '</span>';
          }
          itemStr += '  <span class="tel">' + places.phone + '</span></div>';
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
            paginationEl.removeChild(paginationEl.lastChild);
          }
          for (i = 1; i <= pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;
            if (i === pagination.current) {
              el.className = 'on';
            } else {
              el.onclick = (function (i) {
                return function () {
                  pagination.gotoPage(i);
                }
              })(i);
            }
            fragment.appendChild(el);
          }
          paginationEl.appendChild(fragment);
        }

        // 명소리스트 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
        function displayInfowindow(marker, title, indexCheck) {
          var content = '<div class="icon-locate-map" style="padding:5px;z-indexCheck:1;">' + title + '</div>';
          infowindow.setContent(content); // 설명창 내부에 표시될 글
          infowindow.open(maps[indexCheck], marker); // 설명창 띄움
        }

        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
        function removeAllChildNods(el) {
          while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
          }
        }
      }
    }

  </script>

    /////////////////////// 아래는 버 클릭시 동작되는 부분입니다 ////////////////////////////
  <script>

    // 지도 화면 초기화
    function reset(event, indexCheck) {
      console.log(indexCheck);
      console.log(markersBound[indexCheck]);
      var bounds = markersBound[indexCheck];
      maps[indexCheck].setBounds(bounds);
    };

    // 여행플랜 업데이트
    $("#btnUpdateTripPlan").click(function () {

      var tripPlanTitle = $('#tripPlanTitle').val(); // 여행플랜 제목
      var dailyPlanContents = []; // 일차별 여행플랜 본문과 명소들을 모두 저장하는곳

      for (var i = 0; i < idCheck; i++) {
        var dailyPlanContent; // 일차별 여행플랜 본문
        var totalTripTime; // 일차별 명소간 총 이동시간
        var placeInfo = [] // 명소를 저장하는 배열
        var placeSum = 0; // 명소의 갯수 파악

        if(($('#dailyPlanContents' + i).val() != "" && $('#dailyPlanContents' + i).val() != null) && (allPlaces['map' + i] != undefined && allPlaces['map' + i] != null && allPlaces['map' + i].length != 0)) {

          dailyPlanContent = $('#dailyPlanContents' + i).val();
          totalTripTime = totalTripTimes[i];
          placeSum = allPlaces['map' + i].length;

          for (var j = 0; j < placeSum; j++) {
            var placeText = allPlaces['map' + i][j];
            var tripTimeText = placeTripTimes['map' + i][j];
            var place = placeText;
            place.tripTime = tripTimeText; // 시간 값을 할당
            placeInfo.push(JSON.stringify(placeText));
          }

          dailyPlanContents.push({
            dailyPlanContents: dailyPlanContent,
            totalTripTime: totalTripTime,
            placesInfo: placeInfo
          });

        } else {
          alert("여행플랜을 작성할때에는 반드시 문구와 명소를 간단하게 작성해야합니다.")
          return;
        }

      }

      console.log(dailyPlanContents);

      if (tripPlanTitle == null || tripPlanTitle.length < 1) {
        alert("여행플랜 제목을 입력하여야 저장가능합니다.");
        return;
      }
      if (dailyPlanContents == null || dailyPlanContents.length < 1) {
        alert("플랜본문은 1개 이상 입력하여야 저장가능합니다.");
        return;
      }

      var tripPlan = {
        tripPlanNo: ${tripPlan.tripPlanNo},
        tripPlanTitle: tripPlanTitle,
        tripDays: idCheck,
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

      console.log("저장전 확인");
      console.log(tripPlan);


      $.ajax({ // JSON 형태로 저장하여 RestContoller로 ajax통신
        url: "/tripPlan/updateTripPlan",
        type: "POST",
        data: JSON.stringify(tripPlan),
        contentType: "application/json; charset=utf-8",
        success: function () {
          window.location.href = "/tripPlan/tripPlanList?type=my";
        },
        error: function (xhr, status, error) {
          console.log(error);
        }
      });

    });


    $("#btnAddTripDay").click(function () { // 추가 지도 생성 최대 10개까지
      // 버튼 비활성화
      $(this).prop('disabled', true);

      // 일정 시간후에 버튼 활성화
      setTimeout(function () {
        $("#btnAddTripDay").prop('disabled', false);
      }, 500); // 0.5초 후에 버튼 활성화

      // 새로운 요소를 생성
      if (idCheck < 10) {
        console.log("뭐나오는지")
        console.log(idCheck);
        var dynamicHTML = '<hr></hr>' +
                '<div class="container" id="container' + idCheck +'"><div class="day">' + (idCheck+1)  + '일차 여행플랜 </div>' + '<div class="row">' + '<div class="col-sm-7">' +
                '<textarea id="dailyPlanContents' + idCheck + '" name="dailyPlanContents" required style="width: 100%;"></textarea>' +
                '</div>' + '<div class="col-sm-5">' + '<div class="sidebar">' +
                '<div class="border-box">' + '<div id="menu_wrap' + idCheck + '"></div>' + '<div class="box-title">' + '<div class="input-group">' +
                '<input type="text" class="form-control" id="placeName' + idCheck + '" onkeypress="handleKeyPress(event, ' + idCheck + ')" placeholder="명소 검색">' +
                '<div class="input-group-btn">' +
                '<button class="btn btn-primary" id="placeSearch' + idCheck + '" onclick="handleKeyPress(event, ' + idCheck + ')">Search</button>' +
                '</div>' + '</div>' + '</div><button class="icon-locate-map" id="reset' + idCheck + '" onclick="reset(event, ' + idCheck + ')"></button>' +
                '<div id="map' + idCheck + '" style="width: 100%; height: 300px;"></div>' + '<ul id="placesList' + idCheck + '"></ul>' + '<div id="pagination"></div>' +
                '</div>' + '<div class="border-box">' + '<div class="box-title">명소리스트 <div class="tag-link" style="text-align: right;" id="totalTripTime' + idCheck + '"></div></div>' +
                '<ul class="list' + idCheck + '">' + '</ul>' + '</div>' + '</div>' + '</div>' + '</div>' + '</div>';

        // 동적으로 생성한 요소들을 DOM에 추가
        var newElement = document.createElement('div');
        newElement.setAttribute('class', 'row');
        newElement.setAttribute('id', 'newElement' + idCheck);
        newElement.innerHTML = dynamicHTML;

        var btnElement = document.getElementById('addDaily');

        btnElement.parentNode.insertBefore(newElement, btnElement);

        // 지도를 생성 및 옵션 설정
        var mapDiv = document.getElementById('map' + idCheck);
        mapDiv.setAttribute('id', 'map' + idCheck);
        maps.push(new kakao.maps.Map(mapDiv, mapOptions));

        // 서머노트 추가생성
        initializeSummernote(idCheck);
        idCheck++;
        console.log("idCheck 증가하였음");
        console.log(idCheck);

      } else {
        alert("하나의 여행플랜의 일정은 10개가 최대입니다. \n추가적인 일정은 새로운 여행플랜을 작성하여 이용해주시기 바랍니다.");
      }
    });

    $("#btnRemoveTripDay").click(function () {
      // 버튼 비활성화
      $(this).prop('disabled', true);

      // 일정 시간후에 버튼 활성화
      setTimeout(function () {
        $("#btnRemoveTripDay").prop('disabled', false);
      }, 500); // 0.5초 후에 버튼 활성화

      if (idCheck > 1) {
        console.log("뭐나오는지")
        console.log(idCheck);
        var elementToRemove = document.getElementById('container' + (idCheck - 1));
        console.log(elementToRemove)
        if (elementToRemove) {
          // 내용이 있는지 확인
          var dailyPlanContents = elementToRemove.querySelector('textarea[name="dailyPlanContents"]');
          var listElement = elementToRemove.querySelector('.list' + (idCheck - 1));
          var addedPlaceCount = listElement.children.length;

          if (dailyPlanContents && dailyPlanContents.value.trim() !== '' ||
                  addedPlaceCount > 0) {
            // 내용이 있을 경우 확인 후 삭제
            if (confirm("작성중인 내용이 있습니다 삭제하시겠습니까?")) {
              elementToRemove.parentNode.removeChild(elementToRemove);
              delDailyPlan((idCheck - 1))
              idCheck --; // idCheck 감소
              console.log("idCheck 감소하였음");
              console.log(idCheck);
            }
          } else {
            // 내용이 없을 경우 바로 삭제
            elementToRemove.parentNode.removeChild(elementToRemove);
            delDailyPlan((idCheck - 1));
            idCheck--; // idCheck 감소
            console.log("idCheck 감소하였음");
            console.log(idCheck);
          }
        }
      } else {
        alert("하나의 여행플랜의 반드시 필요합니다.");
      }
    });

    function delDailyPlan(indexCheck) {
      // 배열에서 전체 삭제
      console.log("삭제하겠습니다");

      console.log(placeTripTimes['map' + indexCheck]);
      console.log(totalTripTimes[indexCheck]);
      console.log(placeTripPositions[indexCheck]);
      console.log(allPlaces['map' + indexCheck]);
      console.log(markers[indexCheck]);
      console.log(markersBound[indexCheck]);
      console.log(maps[indexCheck]);

      delete placeTripTimes['map' + indexCheck];
      totalTripTimes.splice(indexCheck, 1);
      delete placeTripPositions[indexCheck];
      delete allPlaces['map' + indexCheck];
      delete markers[indexCheck];
      delete markersBound[indexCheck];
      maps.splice(indexCheck, 1);
      console.log(maps);
    }

    // 명소 삭제 로직
    $(document).on('click', ".deleteBox", function () {
      var id = $(this).attr('id');
      var indexCheck = id.slice("deleteBox".length);
      var index = $(this).data('index');

      console.log("id : " + indexCheck);
      console.log("index : " + index);

      var prevTripTimeEl = document.querySelector('.card.text-white.mb-3[id="tripTime' + indexCheck + '"][data-index="' + (index) + '"]'); // 명소를 기준으로 이전 시간 리스트박스
      $(prevTripTimeEl).parent().remove();
      $(prevTripTimeEl).remove();

      if(index == 0){

        console.log("0으로 시작")

        totalTripTimes[indexCheck] = totalTripTimes[indexCheck] - placeTripTimes['map' + indexCheck][index];
        $("#totalTripTime" + indexCheck).text(totalTripTimes[indexCheck]); // 앞뒤 시간을 모두 삭제하고 새롭게 표시

        placeTripTimes['map' + indexCheck].splice(index, index + 1); // 시간 다시 구해서 넣기 위해 앞뒤로 지워야함
        placeTripPositions[indexCheck].splice(index, index + 1); // 삭제된 좌표 인덱스
        allPlaces['map' + indexCheck].splice(index, index + 1); // 삭제된 명소정보
        pathArray[indexCheck].splice(index, index + 1); // 폴리라인 경로 삭제

        var marker = markers[indexCheck][index];
        marker.setMap(null); // 마커를 지도에서 제거
        markers[indexCheck].splice(index, index + 1); // 마커 삭제

        var polyline = polylineArray[indexCheck][index]
        polyline.setMap(null);
        polylineArray[indexCheck].splice(index, index + 1); // 폴리라인 삭제

        // 이후 남아있는 리스트박스들의 id 값을 업데이트
        var elTripTimes = document.querySelectorAll('.card.text-white.mb-3[id="tripTime' + indexCheck + '"]');
        console.log(elTripTimes)
        console.log(elTripTimes.length)
        console.log("위에가 남아있는 리스트 크기임")

        if(elTripTimes.length == 0){
          $("#totalTripTime" + indexCheck).text("");
          elTripTimes.textContent = "";
          return
        } else {

          for (var i = index; i < elTripTimes.length; i++) {
            elTripTimes[i].setAttribute('data-index', i);
            console.log(elTripTimes[i])
          }
          var elCategory = document.querySelectorAll('.card-header[name="placeCategory"][id="placeCategory' + indexCheck + '"]');
          for (var i = index; i < elCategory.length; i++) {
            elCategory[i].setAttribute('data-index', i);
            console.log(elCategory[i]);
          }
          var elDeleteBoxes = document.querySelectorAll('.deleteBox[id="deleteBox' + indexCheck + '"]');
          for (var i = index; i < elDeleteBoxes.length; i++) {
            elDeleteBoxes[i].setAttribute('data-index', i);
            console.log(elDeleteBoxes[i]);
          }
          var elPlaceTitles = document.querySelectorAll('.card-title[name="placeTitle"][id="placeTitle' + indexCheck + '"]');
          for (var i = index; i < elPlaceTitles.length; i++) {
            elPlaceTitles[i].setAttribute('data-index', i);
            console.log(elPlaceTitles[i]);
          }

          // 삭제된 화면을 재구성
          var bounds = new kakao.maps.LatLngBounds();
          for (var i = 0; i < markers[indexCheck].length; i++) {
            bounds.extend(markers[indexCheck][i].getPosition());
          }
          markersBound[indexCheck] = bounds;
          maps[indexCheck].setBounds(bounds);

          var start = placeTripPositions[indexCheck][index - 1];
          var end = placeTripPositions[indexCheck][index];

          console.log(start)
          console.log(end)
        }

      } else {

        console.log("0이상의 값으로 시작")

        totalTripTimes[indexCheck] = totalTripTimes[indexCheck] - placeTripTimes['map' + indexCheck][index - 1];
        totalTripTimes[indexCheck] = totalTripTimes[indexCheck] - placeTripTimes['map' + indexCheck][index];
        $("#totalTripTime" + indexCheck).text(totalTripTimes[indexCheck]); // 앞뒤 시간을 모두 삭제하고 새롭게 표시

        placeTripTimes['map' + indexCheck].splice(index - 1, index + 1); // 시간 다시 구해서 넣기 위해 앞뒤로 지워야함
        placeTripPositions[indexCheck].splice(index, index); // 삭제된 좌표 인덱스
        allPlaces['map' + indexCheck].splice(index, index); // 삭제된 명소정보
        pathArray[indexCheck].splice(index -1, index + 1);

        var marker = markers[indexCheck][index];
        marker.setMap(null); // 마커를 지도에서 제거
        markers[indexCheck].splice(index, index); // 마커 삭제

        var polyline = polylineArray[indexCheck][index -1] // 앞뒤로 지우기
        if(polylineArray[indexCheck][index] != null) {
          var polyline2 = polylineArray[indexCheck][index]
          polyline2.setMap(null);
        }
        polyline.setMap(null);

        polylineArray[indexCheck].splice(index-1 , index + 1); // 폴리라인 삭제

        // 이후 남아있는 리스트박스들의 id 값을 업데이트
        var elTripTimes = document.querySelectorAll('.card.text-white.mb-3[id="tripTime' + indexCheck + '"]');
        console.log(elTripTimes)
        console.log(elTripTimes.length)
        console.log("위에가 남아있는 리스트 크기임")

        for (var i = index; i < elTripTimes.length; i++) {
          elTripTimes[i].setAttribute('data-index', i);
        }
        var elCategory = document.querySelectorAll('.card-header[name="placeCategory"][id="placeCategory' + indexCheck + '"]');
        for (var i = index; i < elCategory.length; i++) {
          elCategory[i].setAttribute('data-index', i);
          console.log(elCategory[i]);
        }
        var elDeleteBoxes = document.querySelectorAll('.deleteBox[id="deleteBox' + indexCheck + '"]');
        for (var i = index; i < elDeleteBoxes.length; i++) {
          elDeleteBoxes[i].setAttribute('data-index', i);
          console.log(elDeleteBoxes[i]);
        }
        var elPlaceTitles = document.querySelectorAll('.card-title[name="placeTitle"][id="placeTitle' + indexCheck + '"]');
        for (var i = index; i < elPlaceTitles.length; i++) {
          elPlaceTitles[i].setAttribute('data-index', i);
          console.log(elPlaceTitles[i]);
        }

        // 삭제된 화면을 재구성
        var bounds = new kakao.maps.LatLngBounds();
        for (var i = 0; i < markers[indexCheck].length; i++) {
          bounds.extend(markers[indexCheck][i].getPosition());
        }
        markersBound[indexCheck] = bounds;
        maps[indexCheck].setBounds(bounds);

        var start = placeTripPositions[indexCheck][index - 1];
        var end = placeTripPositions[indexCheck][index];

        console.log(start)
        console.log(end)
      }

      if (end != null || start != null || start != end || end != undefined || start != undefined ) { // 마지막 값이 없거나 명소가 같을 경우에는 찾지않음
        $.ajax({ // 명소간 이동시간 구하기(길찾기 API)
          url: "/tripPlan/tripTime",
          type: "GET",
          data: {start: start, end: end},
          dataType: "JSON",
          success: function (data) {
            var hour = parseInt(data.hour);
            var minute = parseInt(data.minute);
            var polylines = data.polylineCoordinates;

            // 경로 그리기 코드 추가
            var path = polylines.map(function (coordinate) {
              return new kakao.maps.LatLng(coordinate.lat, coordinate.lng);
            });
            pathArray[indexCheck].push(path);

            var polyline = new kakao.maps.Polyline({
              map: maps[indexCheck],
              path: path,
              strokeWeight: 4,
              strokeColor: '#2116fa',
              strokeOpacity: 0.7,
              strokeStyle: 'shortdash'
            });
            polylineArray[indexCheck].push(polyline);

            polyline.setMap(maps[indexCheck]);

            var tripTimeEl = document.querySelector('[name="tripTime"][id="tripTime' + indexCheck + '"][data-index="' + (index - 1) + '"]');
            console.log(tripTimeEl);
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
          },
          error: function (xhr, status, error) {
            console.log(error);
          }
        });
      }
    });

    $(function () { // 이전으로 돌아가기
      $("#history").on("click", function () {
        window.history.back();
      });
    });

  </script>

    /////////////////////// 아래는 템플릿용 스크립트입니다. ////////////////////////////

  <!-- <script src="/vendor/jquery/dist/jquery.min.js"></script>  부트스트랩 에러로 인해 봉인 -->
  <script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
  <script src="/vendor/jquery.ui.touch-punch.min.js"></script>
  <script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>

  <script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
  <script src="/vendor/owlcarousel/owl.carousel.min.js"></script>
  <script src="/vendor/retina.min.js"></script>
  <script src="/vendor/jquery.imageScroll.min.js"></script>
  <script src="/assets/js/min/responsivetable.min.js"></script>
  <script src="/assets/js/bootstrap-tabcollapse.js"></script>

  <script src="/assets/js/min/countnumbers.min.js"></script>
  <script src="/assets/js/main.js"></script>

</body>
</html>