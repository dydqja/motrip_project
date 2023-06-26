<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Mold Discover . HTML Template</title>

  <!-- 구분선 -->
  <script type="text/javascript"
          src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a&libraries=services"></script>
  <%--    <link rel="stylesheet" href="/css/tripplan/tripplan.css">--%>
  <script src="/vendor/jquery/dist/jquery.min.js"></script>
  <script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <link rel="stylesheet" href="/summernote/summernote.css">
  <script src="/summernote/summernote.js"></script>
  <!-- 구분선 -->

  <link rel="icon" type="image/png" href="assets/img/favicon.png"/>
  <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
  <!-- 부트스트랩 지도위  탭 CSS 링크 추가 -->
  <!-- 부트스트랩 3.4.1 CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css">
  <!-- 부트스트랩 지도위  탭 CSS 링크 추가 -->
  <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
  <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
  <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
  <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
  <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

  <script type="text/javascript">

    <!-- 서머노트기본생성 -->
    $(document).ready(function () {
      $('#reviewContents').summernote({
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
        height: 470,
        width: 800,
        disableResizeEditor: true
      });
    });
  </script>

  <script type="text/javascript">
    let markers = []; // 마커 배열
    let maps = []; // 지도 배열
    let pathInfo = []; // 좌표 저장 배열
  </script>

  <style>
    /* 지도 탭 스타일 */
    .nav-tabs {
      border-bottom: none;
    }

    .nav-tabs > li {
      float: none;
      display: inline-block;
    }

    .nav-tabs > li > a {
      border-radius: 8px 8px 0 0;
    }

    .nav-tabs > li.active > a,
    .nav-tabs > li.active > a:hover,
    .nav-tabs > li.active > a:focus {
      background-color: #f8f8f8;
      border-color: #ddd;
    }

    .tab-content {
      padding: 15px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }
  </style>


  <style>
    #reviewContents {
      display: none;/*텍스트에리아 안보이게 */
    }
    main {
      padding: 10px 0px;
    }
  </style>
  <style>
    .post {
      width: 100%; /* 원하는 너비 설정 */
      height: 620px; /* 원하는 높이 설정 */
      overflow: auto; /* 내용이 넘칠 경우 스크롤 표시 */
      border: 1px solid #ccc; /* 테두리 스타일 지정 */
      padding: 10px; /* 내용과 테두리 사이 간격 */
    }
    .day {
      font-size: 30px; /* 원하는 크기로 설정 */
      font-weight: bold; /* 굵은 글씨체 설정 */
    }


    .wrap {
      position: absolute;
      left: 0;
      bottom: 40px;
      width: 288px;
      height: 132px;
      margin-left: -144px;
      text-align: left;
      overflow: hidden;
      font-size: 12px;
      font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
      line-height: 1.5;
    }

    .wrap * {
      padding: 0;
      margin: 0;
    }

    .wrap .info {
      width: 286px;
      height: 120px;
      border-radius: 5px;
      border-bottom: 2px solid #ccc;
      border-right: 1px solid #ccc;
      overflow: hidden;
      background: #fff;
    }

    .wrap .info:nth-child(1) {
      border: 0;
      box-shadow: 0px 1px 2px #888;
    }

    .info .title {
      padding: 5px 0 0 10px;
      height: 30px;
      background: #eee;
      border-bottom: 1px solid #ddd;
      font-size: 18px;
      font-weight: bold;
    }

    .info .close {
      position: absolute;
      top: 10px;
      right: 10px;
      color: #888;
      width: 17px;
      height: 17px;
      background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
    }

    .info .close:hover {
      cursor: pointer;
    }

    .info .body {
      position: relative;
      overflow: hidden;
    }

    .info .desc {
      position: relative;
      margin: 13px 0 0 90px;
      height: 75px;
    }

    .desc .ellipsis {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .desc .category {
      font-size: 11px;
      color: #888;
      margin-top: -2px;
    }

    .info .img {
      position: absolute;
      top: 6px;
      left: 5px;
      width: 73px;
      height: 71px;
      border: 1px solid #ddd;
      color: #888;
      overflow: hidden;
    }

    .info:after {
      content: '';
      position: absolute;
      margin-left: -12px;
      left: 50%;
      bottom: 0;
      width: 22px;
      height: 12px;
      background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
    }

    .info .link {
      color: #5085BB;
    }

    .custom-container {
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


  <style>
    .btnUpdateReview {
      font-family: 'Open Sans', sans-serif;
      font-size: 18px;
      font-weight: bold;
      letter-spacing: 0.05em;
      padding: 14px 30px;
      margin-bottom: 8px;
      text-transform: uppercase;
      border: none;
      color: #fff;
      background-color: #558B2F;
      border-radius: 6px;
    }

    .btnNoUpdate {
      font-family: 'Open Sans', sans-serif;
      font-size: 18px;
      font-weight: bold;
      letter-spacing: 0.05em;
      padding: 14px 30px;
      margin-bottom: 8px;
      text-transform: uppercase;
      border: none;
      color: #fff;
      background-color: #d9806d;
      border-radius: 6px;
    }

  </style>


  <style>️ /* 토글스위치 CSS */
  label {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
  }

  [type="checkbox"] {
    appearance: none;
    position: relative;
    border: max(2px, 0.1em) solid gray;
    border-radius: 1.75em; /* 크기를 조정한 부분입니다 */
    width: 3em; /* 크기를 조정한 부분입니다 */
    height: 1.75em; /* 크기를 조정한 부분입니다 */
  }

  [type="checkbox"]::before {
    content: "";
    position: absolute;
    left: 0;
    width: 1.25em; /* 크기를 조정한 부분입니다 */
    height: 1.25em; /* 크기를 조정한 부분입니다 */
    border-radius: 50%;
    transform: scale(0.8);
    background-color: gray;
    transition: left 250ms linear;
  }

  [type="checkbox"]:checked::before {
    background-color: white;
    left: 1.25em; /* 크기를 조정한 부분입니다 */
  }

  [type="checkbox"]:checked {
    background-color: #5eb95f;
    border-color: #5eb95f;
  }

  [type="checkbox"]:disabled {
    border-color: lightgray;
    opacity: 0.7;
    cursor: not-allowed;
  }

  [type="checkbox"]:disabled:before {
    background-color: lightgray;
  }

  [type="checkbox"]:disabled + span {
    opacity: 0.7;
    cursor: not-allowed;
  }

  [type="checkbox"]:focus-visible {
    outline-offset: max(2px, 0.1em);
    outline: max(2px, 0.1em) solid #0c7a0d;
  }

  [type="checkbox"]:enabled:hover {
    box-shadow: 0 0 0 max(4px, 0.2em) lightgray;
  }

  [type="checkbox"]::before {
    content: "";
    position: absolute;
    left: 0;
    width: 1.25em; /* 크기를 조정한 부분입니다 */
    height: 1.25em; /* 크기를 조정한 부분입니다 */
    border-radius: 50%;
    transform: scale(0.8);
    background-color: gray;
    transition: left 250ms linear;
  }

  /* 툴팁 스타일 */
  .switch-label[title]:hover::before {
    content: attr(title);
    position: absolute;
    top: -24px;
    left: 50%;
    transform: translateX(-50%);
    padding: 4px 8px;
    background-color: rgba(0, 0, 0, 0.8);
    color: white;
    font-size: 12px;
    white-space: nowrap;
    border-radius: 4px;
  }
  /* 공개여부 글자 정렬 */
  .switch-label span {
    display: block;
    line-height: 1;
    margin-top: -55px;
  }


  /* 토글스위치 CSS 끝*/

  </style>

  <style>
    #reviewThumbnail {
      transform: scale(1.3);
    }
  </style>





  <script type="text/javascript">
    function fncUpdateReview() {
      var reviewTitle = $("input[name='reviewTitle']").val();
      var reviewContents = $("textarea[name='reviewContents']").val();
      var reviewNo = ${reviewNo};

      if (reviewTitle == null || reviewTitle.length < 1) {
        alert("후기 제목을 반드시 입력하여야 합니다.");
        return;
      }
      if (reviewContents == null || reviewContents.length < 1) {
        alert("후기 본문을 반드시 입력하여야 합니다.");
        return;
      }

      $("form")
              .attr("method", "post")
              .attr("action", "/review/updateReview")
              .submit();
    }

    $(function () {
      $("#btnUpdateReview").on("click", function () {
        console.log("수정완료버튼을 눌렀습니다.");
        fncUpdateReview();
      });

      $("a[href='#']").on("click", function () {
        $("form")[0].reset();
      });
    });
  </script>

  <script>//토글 스위치 작동 함수
  $(document).ready(function () {
    $(".isReviewPublic").change(function () {
      var isChecked = $(this).prop("checked");
      if (isChecked) {
        $("#isReviewPublicInput").val("True");
      } else {
        $("#isReviewPublicInput").val("False");
      }
    });
    // 선택된 상태를 가져와서 스위치에 반영
    var isReviewPublic = ${review.isReviewPublic}; // 선택된 상태 값

    // isReviewPublic 값이 true일 경우 스위치를 선택된 상태로 설정
    if (isReviewPublic) {
      $('.isReviewPublic').prop('checked', true);
    }
  });
  //토글 스위치 작동 함수
  </script>





</head>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<body>
<div class="post-single left">
  <div class="page-img" style="background-image: url('/images/tripImage.jpg'); height: 400px;">
    <div class="page-img-txt container">
      <div class="row">
        <div class="col-sm-12">
          <div>

            <h2 class="main-head">후기 수정</h2>
            <p class="sub-head">후기를 수정합니다. </p>

            <div class="author-img">
              <img src="${user.userPhoto}" alt="">
            </div>
            <div class="tripPlanTitle">
              <p>TripPlan No. ${tripPlanNo}</p>
              <span style="font-size: 24px;">'</span>
              <span id="displayTripPlanTitle" style="font-size: 24px;">${tripPlan.tripPlanTitle}</span>
              <span style="font-size: 24px;">'</span>
              <span>&nbsp;&nbsp;에 대해 작성한 후기를 수정합니다. </span>
            </div>
            <div style="margin: 3px;"></div>


            <p class="byline">
              <span id="currentDate">${review.reviewRegDate}</span>

              <!--<a href="#">Adventure</a>, <a href="#">Asia</a>
              <span class="dot">·</span>
              <a href="#">4 Comments</a>-->
            </p>

            <button class="btn-default icon-camera" id="reviewThumbnailbtn"
                    style="font-size: 10px; margin-left: 0.8%">썸네일
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<main class="white">
  <form action="getReview?reviewNo=${review.reviewNo}" method="post">
    <div class="container" style="margin: 30px;">
      <div class="form-group" style="margin-left: 30px;">
        <div>
                                <span>
            <h4>
              <input type="text" id="reviewThumbnail" name="reviewThumbnail" value="" hidden>
                <input type="text" id="reviewTitle" name="reviewTitle" value="${review.reviewTitle}"  placeholder="제목을 입력하세요."
                       style="color: black; width: 82%; height: 40px; opacity: 0.5;">
            </h4>
        </span>

        </div>

        <h5>
          <label class="switch" title="타 회원에게 공개할지 비공개할지 설정할 수 있어요.">
            <input class="isReviewPublic" type="checkbox" name="isReviewPublic" checked="checked" />
            <span class="switch-label" data-on="True" data-off="False"></span>
            <span>공개여부</span>
            <span class="switch-handle"></span>
          </label>
          <!--<button type="button" class="btn btn-primary" id="checkStatusBtn">상태 확인</button>-->
        </h5>

      </div>


      <c:set var="i" value="0"/>
      <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
        <c:set var="i" value="${i+1}"/>
      <main class="white">
        <div class="container">
          <div display="flex;" style="margin-top: -3%">
            <span class="icon-map" style="font-size: 50px;"></span>
            <div class="day">${i}일차
              <button class="icon-locate-map" id="reset${i-1}" style="font-size: 20px; border-radius: 15px;"></button>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-9">
              <div id="map${i-1}" style="width: 100%; height: 600px; border-radius: 15px;"></div>
            </div>
            <div class="col-sm-3">
              <div class="sidebar">
                <div class="border-box" style="height: 600px; width: 100%; overflow-y: auto; overflow-x: hidden; border-radius: 15px;">
                  <div class="box-title">명소리스트
                    <c:if test="${dailyPlan.totalTripTime != 0 && dailyPlan.totalTripTime != null}">
                      <div class="card text-white mb-3 btn btn-sm btn-info" style="background-color: rgb(255,254,255); text-align: right; font-size: 11px; color: black; pointer-events: none;">
                        총 이동시간:
                        <c:if test="${dailyPlan.totalTripTime >= 60}">
                          <script>
                            totalTripTime = ${dailyPlan.totalTripTime};
                            var hours = Math.floor(totalTripTime / 60);
                            var minutes = totalTripTime % 60;
                            var formattedTime = hours + "시간 " + minutes + "분";
                            document.write(formattedTime);
                          </script>
                          ${formattedTime}
                        </c:if>
                        <c:if test="${dailyPlan.totalTripTime < 60}">
                          ${dailyPlan.totalTripTime}분
                        </c:if>
                      </div>
                    </c:if>
                  </div>
                  <c:set var="j" value="0"/>
                  <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                    <c:set var="j" value="${j+1}"/>
                    <div class="col-12 column" style="text-align: center;">
                      <div class="card text-white mb-3" id="tripTitle${i-1}" style="width: auto; height: auto; font-size: 9px;">
                        <div class="card-body btn btn-lg btn-info" style="background-color: rgba(164,255,193,0.22); width: 70%; height: auto;">
                          <h5 class="card-title" name="placeTitle" data-index="${j-1}">
                            <div style="color: black; width: 100%;">
                              <span class="icon-locate" style="color: #467cf1;" value="${place.placeCategory}"></span>&nbsp;&nbsp;#${place.placeTags}
                            </div>
                          </h5>
                        </div>
                      </div>
                      <c:if test="${place.tripTime != 0 && place.tripTime != null}">
                        <div class="card text-white mb-3 btn btn-sm btn-info" name="tripTime" style="background-color: rgb(255,255,255); width: auto; height: auto; pointer-events: none;">
                          <label class="icon-arrow-down" style="color: #88e0c6; font-size: 15px;"></label>
                          <div style="color: black; display: inline-block; font-size: 7px;">
                            <c:if test="${place.tripTime >= 60}">
                              <script>
                                totalTripTime = ${place.tripTime};
                                var hours = Math.floor((parseInt(totalTripTime)) / 60);
                                var minutes = totalTripTime % 60;
                                var formattedTime = hours + "시간 " + minutes + "분";
                                document.write(formattedTime);
                              </script>
                              ${formattedTime}
                            </c:if>
                            <c:if test="${place.tripTime < 60}">
                              ${place.tripTime}분
                            </c:if>
                          </div>
                        </div>
                      </c:if>
                    </div>
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
                      var tripPath = '${place.tripPath}';
                      var index = ${i-1};

                      if (!pathInfo[index]) {
                        pathInfo[index] = [];
                      }
                      pathInfo[index].push(tripPath);

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
                  </c:forEach> <!-- place for end -->
                </div>
              </div>
            </div>
          </div>
          <div style="margin: 3%"></div>
        </div>
      </main>
      </c:forEach> <!-- dailyPlan for end -->

      <div class="col-sm-9" >
        <textarea id="reviewContents" name="reviewContents" required><c:out value="${review.reviewContents}" /></textarea>
      </div>






      <div class="form-group" style="display: none;">
      <label for="reviewLikes">Review Likes:</label>
      <input type="number" id="reviewLikes" name="reviewLikes" value="0"><br><br>
    </div>

    <div class="form-group" style="display: none;">
      <label for="viewCount">View Count:</label>
      <input type="number" id="viewCount" name="viewCount" value="0"><br><br>
    </div>

    <!-- tripPlanTitle 숨겨진 입력 필드 -->
    <input type="hidden" name="tripPlanTitle" id="tripPlanTitleInput" value="${tripPlanTitle}">
    <input type="hidden" name="reviewAuthor" id="reviewAuthor" value="${reviewAuthor}">
    <!-- JavaScript를 사용하여 tripPlanTitle 값을 설정 -->
    <script>
      document.getElementById("tripPlanTitleInput").value = document.getElementById("displayTripPlanTitle").innerText;
    </script>

    <div class="form-group" style="display: none;">
      <label class="switch">
        <input class="isReviewDeleted" type="checkbox" name="isReviewDeleted" />
        <span class="switch-label" data-on="True" data-off="False"></span>
        <span>isReviewDeleted</span>
        <span class="switch-handle"></span>
      </label>
      <!--<button class="btn btn-primary" id="reviewDeleted">상태 확인</button>-->
    </div>

    <div class="form-group" style="display: none;">
      <label for="reviewDelDate">Review Delete Date:</label>
      <input type="date" id="reviewDelDate" name="reviewDelDate"><br><br>
    </div>
    <div class="col-sm-offset-4 col-sm-4 text-center">
      <button type="btnUpdateReview" class="btnUpdateReview" onclick="fncUpdateReview()">수정완료</button>

      <button class="btnNoUpdate" id="history">수정취소</button>

    </div>
</form>
</main>


<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
<!-- 아래는 설정용 스크립트입니다. -->

<script type="text/javascript">

  let tripDays = ${tripPlan.tripDays}; // 여행일수의 수량만큼 map 생성

  $(function () { // 저장되었던 맵의 갯수 만큼 출력하고 세팅

    for (var i = 0; i < tripDays; i++) { // map의 아이디를 동적으로 할당하여 생성
      var mapContainer = document.getElementById('map' + i);
      var mapOptions = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567),
        level: 3
      };
      var map = new kakao.maps.Map(mapContainer, mapOptions);

      maps.push(map);

      for(var j = 0; j < pathInfo[i].length; j++){
        if (pathInfo[i][j] !== "") {
          var path = JSON.parse(pathInfo[i][j]);

          var pathCoordinates = path.map(function (coord) {
            return new kakao.maps.LatLng(coord.Ma, coord.La);
          });

          var polyline = new kakao.maps.Polyline({
            path: pathCoordinates, // Initialize the path array
            strokeWeight: 5,
            strokeColor: '#e11f1f',
            strokeOpacity: 0.8,
            strokeStyle: 'shortdash'
          });
          polyline.setMap(map);
        }
      }
    }

    $(maps).each(function (index, map) { // 각 지도마다 들어있는 마커를 기준으로 화면 재구성
      var bounds = new kakao.maps.LatLngBounds();
      var mapId = 'map' + index;
      var mapMarkers = markers.filter(function (marker) {
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

      // 바운드의 범위를 한 단계만 더 가깝게 설정
      var extraPadding = 0.1; // 조절 가능한 추가 간격 (0.1은 10%를 의미)
      var ne = bounds.getNorthEast();
      var sw = bounds.getSouthWest();
      var deltaX = (ne.getLng() - sw.getLng()) * extraPadding;
      var deltaY = (ne.getLat() - sw.getLat()) * extraPadding;
      var extendedNE = new kakao.maps.LatLng(ne.getLat() + deltaY, ne.getLng() + deltaX);
      var extendedSW = new kakao.maps.LatLng(sw.getLat() - deltaY, sw.getLng() - deltaX);
      bounds.extend(extendedNE);
      bounds.extend(extendedSW);

      map.setBounds(bounds);
    });

  });

  $(function () { // 오버레이 표시
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

      var category = '';
      if (markers[i].placeCategory == 0) {
        category = '여행지';
      } else if (markers[i].placeCategory == 1) {
        category = '식당';
      } else if (markers[i].placeCategory == 2) {
        category = '숙소';
      }

      // 오버레이 정보창
      var content = '<div class="wrap custom-container">' +
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
              '                <div class="category">(카테고리) ' + category + ' (전화번호) ' + markers[i].placePhoneNumber + '</div>' +
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
        kakao.maps.event.addListener(marker, 'click', function () {
          maps[mapIndex].setLevel(3); // 확대 수준 설정 (1: 세계, 3: 도시, 5: 거리, 7: 건물)
          maps[mapIndex].panTo(marker.getPosition()); // 해당 마커 위치로 지도 이동
          overlay.setMap(maps[mapIndex]);
        });

        // 지도상 어디든 클릭했을 때 오버레이 숨김
        kakao.maps.event.addListener(maps[mapIndex], 'click', function () {
          overlay.setMap(null);
        });

        // 화면 초기화
        $('#reset' + mapIndex).click(function () {
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

  <!-- 아래는 버튼클릭시 동작되는 부분입니다 -->

  $(function () {
    $("button[id='reviewLikes']").on("click", function () {
      var reviewNo = "${review.reviewNo}";
      console.log("reviewNo 들어가니?".reviewNo)
      $.ajax({ // userID와 tripPlanNo가 필요하여 객체로 전달
        url: "/review/reviewLikes",
        type: "GET",
        data: {"reviewNo": reviewNo},
        success: function (data) {
          console.log(data);
          if (data == -1) {
            alert("이미 추천한 후기 입니다.");
          } else if (data == 0) {
            alert("비회원은 추천을 할수없습니다.");
          } else {
            alert("추천 완료");
            $("#reviewLikes").text(data);
          }
        },
        error: function (xhr, status, error) {
          console.log(error);
        }
      });
    });
  });





  // 여행플랜 썸네일
  $("#reviewThumbnailbtn").click(function () {
    var tripPlanNo = "${tripPlan.tripPlanNo}";
    Swal.fire({
      title: "썸네일 업로드",
      html: '<input type="file" id="fileInput">',
      showCancelButton: true,
      confirmButtonText: "저장",
      cancelButtonText: "취소",
      preConfirm: function () {
        return new Promise(function (resolve) {
          var file = document.getElementById("fileInput").files[0];
          if (file) {
            resolve(file);
          } else {
            Swal.showValidationMessage("파일을 선택해주세요.");
          }
        });
      }
    }).then(function (result) {
      if (result.isConfirmed) {
        var uploadedFile = result.value;
        console.log("파일 업로드 성공:", uploadedFile);

        // FormData 객체 생성
        var formData = new FormData();
        formData.append("file", uploadedFile);
        formData.append("tripPlanNo",tripPlanNo);
        console.log("tripPlanNo",tripPlanNo)

        // reviewThumbnail 값을 가져와서 formData에 추가
        //var reviewThumbnailInput = document.getElementById("reviewThumbnailInput").files[0];

        // 파일 업로드 AJAX 요청
        $.ajax({
          url: "/review/fileUpload",
          type: "POST",
          data: formData,
          processData: false,
          contentType: false,
          success: function (response) {
            console.log("파일 업로드 성공 니가 맞아?:", response);
            var imagePath = response;
            reviewThumbnail = imagePath.replace(/^\/imagePath\//, "");
            console.log("reviewThumnail>>>>>>>",reviewThumbnail);
            $(".page-img").css("background-image", "url('/imagePath/thumbnail/" + reviewThumbnail + "')");

            // 썸네일 값 input 요소에 저장
            $("#reviewThumbnail").val(reviewThumbnail);
          },
          error: function (xhr, status, error) {
            console.log("파일 업로드 실패:", error);
          }
        });
      }
    });

    $(function () { // '수정 취소'버튼 이전으로 돌아가기
      $("#history").on("click", function () {
        window.location.href = "/review/getMyReviewList";
      });
    });

  });

</script>
<!-- 부트스트랩 3.4.1 JavaScript 및 종속성 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>
<!-- 부트스트랩 3.4.1 JavaScript 및 종속성 -->

<!-- 아래는 템플릿용 스크립트입니다. -->


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