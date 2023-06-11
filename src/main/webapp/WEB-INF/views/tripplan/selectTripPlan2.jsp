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
    </style>

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
                        <div class="author">
                            <span>${tripPlan.tripPlanTitle}</span>
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
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
            <div class="day">${i}일차 여행플랜</div>
            <div class="row">
                <div class="col-sm-7">
                    <div class="post" >
                        <div>${dailyPlan.dailyPlanContents}</div>
                    </div>
                </div>


                <div class="col-sm-5">

                    <div class="sidebar">
                        <div class="input-group">
                            <div class="input-group-btn">
                            </div>
                        </div>

                        <div class="border-box"> <!-- 지도부분 -->
                            <h4>
                                <span class="icon-map"><span>Day-${i}</span></span>
                                <button class="icon-locate-map" id="reset${i-1}"></button>
                            </h4>
                            <div class="recent-post-list">
                                <div id="map${i-1}" style="width: 100%; height: 300px;"></div>
                            </div>
                        </div>

                        <div class="border-box">
                            <div class="box-title">명소리스트
                                <div class="tag-link" style="text-align: right;">총 이동시간
                                    : ${dailyPlan.totalTripTime}</div>
                            </div>
                            <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                                <div class="col-12 column">
                                    <div class="card text-white mb-3"
                                         style="background-color: rgb(80, 250, 120); width: auto; height: auto;">
                                        <div class="card-body">
                                            <h4 class="card-title" name="placeTitle">
                                                <div style="text-align: center;"><span class="icon-locate"
                                                                                       value="${place.placeCategory}"></span>&nbsp;&nbsp;&nbsp;#${place.placeTags}
                                                </div>
                                            </h4>
                                        </div>
                                    </div>
                                    <div class="card text-white mb-3" name="tripTime"
                                         style="background-color: rgb(132, 200, 224); width: auto; height: auto;">
                                        <c:if test="${place.tripTime != null}">
                                            <div style="text-align: center;">이동시간: ${place.tripTime}</div>
                                        </c:if>
                                    </div>
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

                                        <%--var tripPath = ${place.tripPath};--%>

                                        <%--var polyline = new kakao.maps.Polyline({--%>
                                        <%--    path: tripPath,--%>
                                        <%--    strokeWeight: 3, // 폴리라인의 두께--%>
                                        <%--    strokeColor: '#FF0000', // 폴리라인의 색상--%>
                                        <%--    strokeOpacity: 0.7 // 폴리라인의 투명도--%>
                                        <%--});--%>

                                        <%--// 폴리라인을 지도에 표시--%>
                                        <%--polyline.setMap(map);--%>


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
            </c:forEach> <!-- dailyPlan for end -->

            <div class="review-comment">
                <div class="add-comment">
                    <div class="form-group">
                        <button class="btn btn-primary" id="history">확인</button>
                        <c:if test="${user.userId == tripPlan.tripPlanAuthor}">
                            <button class="btn btn-primary" id="updateTripPlan">수정하기</button>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
    </main>
</div>

<footer id="footer">
    <div class="container">
        <div class="row">
            <div class="col-sm-7 col-md-3">
                <h3>Mold Discover</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequuntur, quia, architecto? A,
                    reiciendis eveniet! Esse est eaque adipisci natus rerum laudantium accusamus magni.</p>
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

</body>
</html>