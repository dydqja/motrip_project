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
    <link rel="stylesheet" href="/css/tripplan/tripplan.css">
    <script src="/vendor/jquery/dist/jquery.min.js"></script>
    <script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <link rel="stylesheet" href="/summernote/summernote.css">
    <script src="/summernote/summernote.js"></script>
    <!-- 구분선 -->

    <link rel="icon" type="image/png" href="/assets/img/favicon.png"/>
    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

    <script type="text/javascript">
        let markers = []; // 마커 배열
        let maps = []; // 지도 배열
        let pathInfo = []; // 좌표 저장 배열
        let tripTime = ""; // 파싱할 시간
        let totalTripTime = "";
    </script>

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
        /* 버튼 스타일 조정 */
        .scroll-button {
            position: fixed;
            right: 10px;
            padding: 4px 8px;
            font-size: 12px;
            z-index: 9999; /* 맨 앞으로 배치 */
        }

        /* 첫 번째 버튼 위치 조정 */
        .scroll-button:first-child {
            top: 45%;
            transform: translateY(0%);
        }

        /* 중간 버튼 위치 조정 */
        .scroll-button:nth-child(2) {
            top: 45%;
            transform: translateY(100%);
        }

        .scroll-button:nth-child(3) {
            top: 45%;
            transform: translateY(200%);
        }

        /* 마지막 버튼 위치 조정 */
        .scroll-button:last-child {
            top: 45%;
            transform: translateY(300%);
        }

        .fixed-div {
            position: fixed;
            top: 30%;
            right: 10px;
            transform: translateY(-50%);
            background-color: #558B2F;
            color: #fff;
            padding: 2px 2px;
            border-radius: 5px;
        }

    </style>
    <script>
        window.addEventListener('DOMContentLoaded', (event) => {
            var scrollButtonTop = document.querySelectorAll('.scroll-button')[0];
            var scrollButtonBottom = document.querySelectorAll('.scroll-button')[3];
            var scrollMiddleButtonUp = document.querySelectorAll('.scroll-button')[1]; // 중간 위로 이동 버튼
            var scrollMiddleButtonDown = document.querySelectorAll('.scroll-button')[2]; // 중간 아래로 이동 버튼

            // 맨 위로 이동 버튼 클릭 시
            scrollButtonTop.addEventListener('click', function () {
                window.scrollTo(0, 0);
            });

            // 맨 아래로 이동 버튼 클릭 시
            scrollButtonBottom.addEventListener('click', function () {
                window.scrollTo(0, document.documentElement.scrollHeight || document.body.scrollHeight);
            });

            // 중간 위로 이동 버튼 클릭 시
            scrollMiddleButtonUp.addEventListener('click', function () {
                var windowHeight = window.innerHeight; // 브라우저 창의 높이
                var scrollPosition = window.scrollY || window.pageYOffset;
                window.scrollTo(0, scrollPosition - windowHeight * 0.7); // 70% 만큼 위로 이동
            });

            // 중간 아래로 이동 버튼 클릭 시
            scrollMiddleButtonDown.addEventListener('click', function () {
                var windowHeight = window.innerHeight; // 브라우저 창의 높이
                var scrollPosition = window.scrollY || window.pageYOffset;
                window.scrollTo(0, scrollPosition + windowHeight * 0.7); // 70% 만큼 아래로 이동
            });

        });
    </script>


    <script src="/vendor/jquery/dist/jquery.min.js"></script>
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

</head>

<body>

    <%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="post-single left">
    <c:if test="${tripPlan.tripPlanThumbnail != null && tripPlan.tripPlanThumbnail != ''}">
    <div class="page-img" style="background-image: url('/imagePath/thumbnail/${tripPlan.tripPlanThumbnail}');">
        </c:if>
<c:if test="${tripPlan.tripPlanThumbnail == ''}">
<div class="page-img" style="background-image: url('/images/tripImage.jpg');">
    </c:if>
        <div class="page-img-txt container">
            <div class="row">
                <div class="col-sm-12">
                    <h2>
                        <c:if test="${userPhoto == null}">
                            <div class="author-img" style="margin-top: 2%">
                                <img src="/images/tripImage.jpg" alt="">
                            </div>
                        </c:if>
                        <c:if test="${userPhoto != null}">
                            <div class="author-img" style="margin-top: 2%">
                                <img src="${userPhoto}" alt="">
                            </div>
                        </c:if>
                        <div class="author">
                            <span style="font-size: 25px">${tripPlan.tripPlanTitle}</span>
                        </div>
                    </h2>
                    <p class="byline">
                    <h4>
                        <span class="italic">${tripPlan.tripPlanNickName}</span>
                        <span class="dot">·</span>
                        <span>${tripPlan.strDate}</span>
                        <span class="icon-hand-like" style="margin-left: 2%"></span>
                        <span id="likes" align="center" width="200">${tripPlan.tripPlanLikes}</span>
                        <span class="icon-eye" style="margin-left: 1%"></span>
                        <span>${tripPlan.tripPlanViews}</span>&nbsp;&nbsp;
                        <button class="btn btn-primary" id="tripPlanLikes" value="${tripPlan.tripPlanNo}"
                                style="width: auto; height: auto; box-sizing: border-box; padding: 5px 10px;">추천
                        </button>
                        <c:if test="${tripPlan.isPlanDownloadable == true}">
                            <span class="dot">·</span>
                            <button class="btn btn-primary" id="tripPlanDown" value="${tripPlan.tripPlanNo}"
                                    style="width: auto; height: auto; box-sizing: border-box; padding: 5px 5px;">가져가기
                            </button>
                        </c:if>
                    </h4>
                    </p>
                </div>
                <div class="colsm-4">
                </div>
            </div>
        </div>
    </div>

    <c:set var="i" value="0"/>
    <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
    <c:set var="i" value="${ i+1 }"/>
    <main class="white">
        <div class="container">

            <div display="flex;" style="margin-top: -3%">
                <span class="icon-map" style="font-size: 50px; "></span><div class="day">${i}일차 여행플랜 <button class="icon-locate-map" id="reset${i-1}"
                                                                                                             style="font-size: 20px; border-radius: 15px; "></button></div>
            </div>

            <div class="row" >
                <div class="col-sm-12">
                    <div id="map${i-1}" style="width: 100%; height: 400px; border-radius: 15px;" ></div>
                </div>
            </div>

            <div style="margin: 5%"></div>

            <div class="row">
                <div class="col-sm-9">
                    <div class="post" style="height: 600px; overflow: auto; border-radius: 15px; ">
                        <div>${dailyPlan.dailyPlanContents}</div>
                    </div>
                </div>


                <div class="col-sm-3">

                    <div class="sidebar">

                        <div class="border-box" style="height: 600px; width: 100%; overflow-y: auto; overflow-x: hidden; border-radius: 15px; ">
                            <div class="box-title">명소리스트
                                <c:if test="${dailyPlan.totalTripTime != 0 && dailyPlan.totalTripTime != null}">
                                <div class="card text-white mb-3 btn btn-sm btn-info" style="background-color: rgb(255,254,255); text-align: right; font-size: 11px; color: black; pointer-events: none;">총 이동시간
                                    :
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
                                <c:set var="j" value="${ j+1 }"/>

                                <div class="col-12 column" style="text-align: center; ">
                                    <div class="card text-white mb-3" id="tripTitle${i-1}"
                                         style="width: auto; height: auto; font-size: 9px;">
                                        <div class="card-body btn btn-lg btn-info" style="background-color: rgba(164,255,193,0.22); width: 70%; height: auto;">
                                            <h5 class="card-title" name="placeTitle" data-index="${j-1}">
                                                <div style="color: black; width: 100%;">
                                                    <span class="icon-locate" style="color: #467cf1;" value="${place.placeCategory}"></span>&nbsp;&nbsp;#${place.placeTags}
                                                </div>
                                            </h5>
                                        </div>
                                    </div>
                                    <c:if test="${place.tripTime != 0 && place.tripTime != null}">
                                    <div class="card text-white mb-3 btn btn-sm btn-info" name="tripTime"
                                         style="background-color: rgb(255,255,255); width: auto; height: auto; pointer-events: none;">
                                            <label class="icon-arrow-down" style=" color: #88e0c6; font-size: 15px;"></label>
                                            <div style=" color: black; display: inline-block; font-size: 7px;">
                                                <c:if test="${place.tripTime >= 60}">
                                                    <script>
                                                        console.log(${place.tripTime});
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

                                <!-- place 반복문이 내부에있어서 해당 장소에 선언하였으며 마커와 오버레이를 보여주기 위한 스크립트 -->

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


                                    console.log("latitude>>>>>>>>>>>>>>", latitude);
                                    console.log("longitude>>>>>>>>>>>>>", longitude);
                                    console.log("mapId>>>>",mapId);


                                    var index = ${i-1};
                                    if(!pathInfo[index]) {
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
            <hr style="margin-bottom: -100%"/>

        </div>
    </main>
    </c:forEach> <!-- dailyPlan for end -->

    <main class="white">
        <div class="container" style="margin-top: -6%">
            <div class="review-comment">
                <div class="add-comment">
                    <div class="addDaily" style="text-align: right;">
                        <button class="btn btn-primary" id="history">확인</button>
                        <c:if test="${user.userId == tripPlan.tripPlanAuthor}">
                            <button class="btn btn-primary" id="updateTripPlan">수정하기</button>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </main>


    <div style="display: flex">
        <button class="scroll-button btn btn-sm btn-success icon-arrow-up" style="width: 70px; margin-top: 2px; font-size: 10px"></button>
        <button class="scroll-button btn btn-sm btn-success icon-arr-up" style="width: 70px; margin-top: 2px; font-size: 10px"></button>
        <button class="scroll-button btn btn-sm btn-success icon-arr-down" style="width: 70px; margin-top: 2px; font-size: 10px"></button>
        <button class="scroll-button btn btn-sm btn-success icon-arrow-down" style="width: 70px; margin-top: 2px; font-size: 10px"></button>
    </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

<!-- 아래는 설정용 스크립트입니다. -->

<script type="text/javascript">

    let tripDays = ${tripPlan.tripDays}; // 여행일수의 수량만큼 map 생성
    let indexCheck = [];

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

            if (!indexCheck[mapId]) {
                indexCheck[mapId] = [];
            }

            $(mapMarkers).each(function (index, marker) {
                var newMarker = addMarker(marker.position, index);
                newMarker.setMap(map);

                indexCheck[mapId].push(index);
                bounds.extend(marker.position);
            });

            console.log("test")
            console.log(indexCheck);

            map.setBounds(bounds);
        });

    });

    function addMarker(position, idx) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
        var imageSize = new kakao.maps.Size(36, 37);
        var imgOptions = {
            spriteSize: new kakao.maps.Size(36, 691),
            spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
            offset: new kakao.maps.Point(13, 37)
        };
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
        var marker = new kakao.maps.Marker({
            position: position,
            image: markerImage
        });

        return marker;
    }

    $(function () { // 오버레이 표시
        var overlays = [];
        var position = [];
        var makerIndex = 0;

        for (var i = 0; i < markers.length; i++) { // 각 지도에 맞춰서 마커들을 표시
            var mapId = markers[i].mapId;
            var mapIndex = parseInt(mapId.replace("map", ""));
            var markerOptions = {
                position: markers[i].position,
                map: maps[mapIndex]
            };

            var marker = addMarker(markerOptions.position, makerIndex);
            marker.setMap(markerOptions.map);

            makerIndex++;
            if (makerIndex >= indexCheck[mapId].length) {
                makerIndex = 0;  // index가 indexCheck[mapId].length보다 크거나 같으면 0으로 초기화
            }

            if (!position[mapIndex]) {
                position[mapIndex] = [];
            }
            if (!overlays[mapIndex]) {
                overlays[mapIndex] = [];
            }

            position[mapIndex].push(marker);

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
                '                <div class="category">(전화번호) ' + markers[i].placePhoneNumber + '</div>' +
                '    </div></div></div></div>';

            var overlay = new kakao.maps.CustomOverlay({  // 마커 위에 커스텀오버레이를 표시합니다, 마커를 중심으로 커스텀 오버레이를 표시하기 위해 CSS를 이용해 위치를 설정했습니다
                content: content,
                map: maps[mapIndex],
                position: marker.getPosition(),
                yAnchor: 1
            });

            overlay.setMap(null); // 오버레이 초기 상태는 숨김으로 설정
            overlays[mapIndex].push(overlay);

            (function (marker, overlay, mapIndex) {

                // 마커를 클릭했을 때 오버레이 표시
                kakao.maps.event.addListener(marker, 'click', function () {
                    maps[mapIndex].setLevel(5); // 확대 수준 설정 (1: 세계, 3: 도시, 5: 거리, 7: 건물)
                    maps[mapIndex].panTo(marker.getPosition()); // 해당 마커 위치로 지도 이동
                    overlay.setMap(maps[mapIndex]);
                });

                // 지도상 어디든 클릭했을 때 오버레이 숨김
                kakao.maps.event.addListener(maps[mapIndex], 'click', function () {
                    overlay.setMap(null);
                });

                // $('.card-title' + mapIndex).click(function() {
                //
                //     var dataIndex = parseInt($(this).attr('data-index'));
                //     console.log(dataIndex);
                //     console.log(position[mapIndex][dataIndex]);
                //
                //     // 해당 마커를 클릭한 것처럼 동작
                //     maps[mapIndex].setLevel(5);
                //     maps[mapIndex].panTo(position[mapIndex][dataIndex].getPosition());
                //     overlay.setMap(null);
                //     overlay.setMap(maps[mapIndex]);
                //
                // });

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

                    // // 확장할 수 있는 마진 값을 지정합니다.
                    // var margin = 0.001; // 예시로 0.1(10%)로 설정하였습니다.
                    // var southWest = bounds.getSouthWest();
                    // var northEast = bounds.getNorthEast();
                    // var latDiff = northEast.getLat() - southWest.getLat();
                    // var lngDiff = northEast.getLng() - southWest.getLng();
                    //
                    // // 확장된 영역으로 bounds를 설정합니다.
                    // bounds.extend(new kakao.maps.LatLng(southWest.getLat() - latDiff * margin, southWest.getLng() - lngDiff * margin));
                    // bounds.extend(new kakao.maps.LatLng(northEast.getLat() + latDiff * margin, northEast.getLng() + lngDiff * margin));

                    maps[mapIndex].setBounds(bounds);
                });

            })(marker, overlay, mapIndex);
        }

        $(document).on('click', '[id^="tripTitle"]', function() {
            var mapIndex = $(this).attr('id').replace('tripTitle', ''); // 클릭한 태그의 인덱스 추출
            var dataIndex = $(this).find('.card-title').attr('data-index');
            console.log("클릭한 태그의 인덱스:", index);
            console.log("확인: ", dataIndex);
            // 원하는 작업 수행

            console.log(overlays[mapIndex])

            maps[mapIndex].setLevel(5);
            maps[mapIndex].panTo(position[mapIndex][dataIndex].getPosition());

            for(var i=0; i<overlays[mapIndex].length; i++){
                overlays[mapIndex][i].setMap(null);
            }
            overlays[mapIndex][dataIndex].setMap(maps[mapIndex]);
        });

    });


    <!-- 아래는 버튼클릭시 동작되는 부분입니다 -->

    $(function () {
        $("button[id='tripPlanLikes']").on("click", function () {
            var tripPlanNo = "${tripPlan.tripPlanNo}";
            $.ajax({ // userID와 tripPlanNo가 필요하여 객체로 전달
                url: "/tripPlan/tripPlanLikes",
                type: "GET",
                data: {"tripPlanNo": tripPlanNo},
                success: function (data) {
                    console.log(data);
                    if (data == -1) {
                        alert("이미 추천한 여행플랜입니다.");
                    } else if (data == 0) {
                        alert("비회원은 추천을 할수없습니다.");
                    } else {
                        alert("추천 완료");
                        $("#likes").text(data);
                    }
                },
                error: function (xhr, status, error) {
                    console.log(error);
                }
            });
        });
    });

    $(function () { // 업데이트 하러가기
        $("button[id='updateTripPlan']").on("click", function () {
            var tripPlanNo = "${tripPlan.tripPlanNo}";
            window.location.href = "/tripPlan/updateTripPlanView?tripPlanNo=" + tripPlanNo;
        });
    });

    $(function () { // 이전으로 돌아가기
        $("#history").on("click", function () {
            window.history.back();
        });
    });

    // 유저닉네임, 프로필 클릭시 이동
    $(document).ready(function() {
        $('.author-img').hover(
            function() {
                $(this).css('cursor', 'pointer');
                /* 마우스를 올렸을 때의 스타일 변경 */
            },
            function() {
                $(this).css('cursor', 'auto');
                /* 마우스가 벗어났을 때의 스타일 변경 */
            }
        );

        $('.italic').hover(
            function() {
                $(this).css('cursor', 'pointer');
                /* 마우스를 올렸을 때의 스타일 변경 */
            },
            function() {
                $(this).css('cursor', 'auto');
                /* 마우스가 벗어났을 때의 스타일 변경 */
            }
        );

        $('.author-img').click(function() {
            window.location.href = '/user/getUser?userId=${tripPlan.tripPlanAuthor}';
        });

        $('.italic').click(function() {
            window.location.href = '/user/getUser?userId=${tripPlan.tripPlanAuthor}';
        });
    });

</script>

<!-- 아래는 템플릿용 스크립트입니다. -->


</body>
</html>