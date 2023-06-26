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



</head>

<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>


<div class="post-single left" style="margin-bottom: 70px">
    <c:if test="${review.reviewThumbnail != null && review.reviewThumbnail != ''}">
    <div class="page-img" style="background-image: url('/imagePath/thumbnail/${review.reviewThumbnail}');"  height: 400px;">
        </c:if>
        <c:if test="${review.reviewThumbnail == ''}">
        <div class="page-img" style="background-image: url('/images/tripImage.jpg');"  height: 400px;">
            </c:if>
            <div class="page-img-txt container">
                <div class="row">
                    <div class="col-sm-12">
                        <h2 class="main-head">작성  완료</h2>
                        <p class="sub-head">작성한 후기를 확인해보세요.</p>
                        <h3>
                            <div class="author-img" style="margin-top: 1%">
                                <img src="${user.userPhoto}" alt="">
                            </div>
                            <div class="author">
                                <h5>Review No. ${reviewNo}</h5>
                                <span style="font-size: 18px">${review.reviewTitle}</span>
                            </div>
                        </h3>
                        <p class="byline">
                        <h4>
                            <span>By</span>
                            <span><c:out value="${user.nickname}"/></span></a>
                            <span class="italic"></span>
                            <span>${review.reviewRegDate}</span>
                            <span>${review.strDate}</span>

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
                </c:forEach> <!-- dailyPlan for end -->

    </main>

                <div class="col-sm-9">
                    <div class="post" style="height: 600px; overflow: auto; border-radius: 15px;">
                        <div>${review.reviewContents}</div>
                    </div>
                </div>
            </div>
            <div style="margin: 3%"></div>
        </div>






            <div class="review-comment">
                <div class="add-comment">
                    <div class="addDaily" style="text-align: right;">
                        <button class="btn btn-primary" id="history">확인</button>
                        <c:if test="${user.userId == review.reviewAuthor}">
                            <button class="btn btn-primary" id="updateReview">수정</button>
                        </c:if>
                        <c:if test="${user.userId == review.reviewAuthor}">
                            <button class="btn btn-primary" id="deleteReview">삭제</button>
                        </c:if>
                    </div>
                </div>
            </div>

    </div>
    </main>
</div>
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

    $(function() {

        // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
        $("#deleteReview").on("click", function() {

            var reviewNo = "${review.reviewNo}";

            window.location.href = "/review/deleteReview?reviewNo=" + reviewNo;
        });
    });



    $(function () { // 나의 목록으로가기 : 비공개 설정하고 등록하면 모든 목록에서 조회되지 않으므로
        $("#history").on("click", function () {
            window.location.href = "/review/getMyReviewList";
        });
    });

</script>

<!-- 아래는 템플릿용 스크립트입니다. -->

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


</div>
</body>
</html>
