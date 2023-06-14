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
    .btnAddReview {
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
        border-radius: 1.25em;
        width: 2.25em;
        height: 1.25em;
    }

    [type="checkbox"]::before {
        content: "";
        position: absolute;
        left: 0;
        width: 1em;
        height: 1em;
        border-radius: 50%;
        transform: scale(0.8);
        background-color: gray;
        transition: left 250ms linear;
    }

    [type="checkbox"]:checked::before {
        background-color: white;
        left: 1em;
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
        width: 1em;
        height: 1em;
        border-radius: 50%;
        transform: scale(0.8);
        background-color: gray;
        transition: left 250ms linear;
    }

    /* 토글스위치 CSS 끝*/
    </style>


</head>



<header class="nav-menu fixed">
    <%@ include file="/WEB-INF/views/layout/header.jsp" %>
</header>


<script type="text/javascript">
    function fncAddReview() {
        var reviewTitle = $("input[name='reviewTitle']").val();
        var reviewContents = $("textarea[name='reviewContents']").val();
        var tripPlanNo = "<c:out value='${tripPlanNo}' />";


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
            .attr("action", "/review/addReview?tripPlanNo=" + tripPlanNo +
                "&tripPlanTitle=" + encodeURIComponent("${tripPlanTitle}"))
            .submit();
    }

    $(function () {
        $("#btnAddReview").on("click", function () {
            console.log("작성완료버튼을 눌렀습니다.");
            fncAddReview();
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

});
//토글 스위치 작동 함수
</script>


<body>

<div class="post-single left">
    <div class="page-img" style="background-image: url('http://placehold.it/1200x400');">
        <div class="page-img-txt container">
            <div class="row">
                <div class="col-sm-8">
                    <h1 class="main-head">후기 작성</h1>
                    <p class="sub-head">다녀온 여행을 기록하세요.</p>
                    <form action="/review/addReview" method="post">

                        <div class="author-img">
                            <img src="http://placehold.it/70x70" alt="">
                        </div>
                        <div class="tripPlanTitle">
                            <p>TripPlan No. ${tripPlanNo}</p>
                            <span style="font-size: 24px;">'</span>
                            <span id="displayTripPlanTitle" style="font-size: 24px;">${tripPlan.tripPlanTitle}</span>
                            <span style="font-size: 24px;">'</span>
                            <span>&nbsp;&nbsp;에 대한 후기를 작성합니다. </span>
                        </div>

                        <div class="author">
                            <c:set var="nickname" value="${user.nickname}"/>
                            <span>By</span><a href="#"><span id="nickname">
                            <c:out value="${nickname}"/></span></a>
                        </div>

                        <p class="byline">
                            <span id="currentDate">${date}</span>

                            <!--<a href="#">Adventure</a>, <a href="#">Asia</a>
                            <span class="dot">·</span>
                            <a href="#">4 Comments</a>-->
                        </p>

                        <div class="col-sm-4"></div>
                    </form>
                </div>
            </div>
        </div>
    </div>



    <main class="white">
        <form action="/review/addReview" method="post">
            <div class="container">
                <div class="form-group">
                <span>
                    <h4>
                        <input type="text" id="reviewTitle" name="reviewTitle" placeholder="제목을 입력하세요."
                               style="color: black; width: 57%; height: 40px; opacity: 0.5;">
                    </h4>
                </span>
                </div>

                <h5>
                    <label class="switch">
                        <input class="isReviewPublic" type="checkbox" name="isReviewPublic" checked="checked" />
                        <span class="switch-label" data-on="True" data-off="False"></span>
                        <span>공개여부</span>
                        <span class="switch-handle"></span>
                    </label>
                    <!--<button type="button" class="btn btn-primary" id="checkStatusBtn">상태 확인</button>-->
                </h5>


                <c:set var="i" value="0"/>
                <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
                    <c:set var="i" value="${i+1}"/>
                <main class="white">
                    <div class="container">

                        <!-- 지도와 탭을 담을 컨테이너 -->
                        <div class="container">
                            <!--탭 컨테이너-->
                            <div class="row">
                                <div class="col-md-12">
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#qwe">QWE</a></li>
                                        <li><a data-toggle="tab" href="#asd">ASD</a></li>
                                        <li><a data-toggle="tab" href="#zxc">ZXC</a></li>
                                    </ul>


                                    <div class="tab-content">
                                        <div id="qwe" class="tab-pane fade in active">
                                            <div id="map${i-1}" style="align-items: center; width: 100%; height: 400px; border-radius: 15px;" ></div>
                                        </div>
                                        <div id="asd" class="tab-pane fade">
                                            <h4>ASD Content</h4>
                                            <div id="map${i-1}" style="align-items: center; width: 100%; height: 400px; border-radius: 15px;" ></div>
                                        </div>
                                        <div id="zxc" class="tab-pane fade">
                                            <h4>ZXC Content</h4>
                                            <div id="map${i-1}" style="align-items: center; width: 100%; height: 400px; border-radius: 15px;" ></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>






                        <div class="row">
                            <div class="col-sm-9">
                                <div>
                                    <textarea id="reviewContents" name="reviewContents" required></textarea>
                                </div>
                            </div>


                            <div class="col-sm-3">


                                <div class="sidebar">
                                    <div class="input-group">
                                        <div class="input-group-btn">
                                        </div>
                                    </div>

                                    <div class="border-box"  >
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

                                                console.log("placeTags:", placeTags);
                                                console.log("placePhoneNumber:", placePhoneNumber);
                                                console.log("placeAddress:", placeAddress);
                                                console.log("placeCategory:", placeCategory);
                                                console.log("placeImage:", placeImage);
                                                console.log("latitude:", latitude);
                                                console.log("longitude:", longitude);
                                                console.log("markerPosition:", markerPosition);
                                                console.log("mapId:", mapId);

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
                    <button type="submit" class="btnAddReview" onclick="fncAddReview()">작성완료</button>
                </div>
        </form>
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
    console.log("maps>>>>>>>>>>>>>>>>>>",maps)
    let tripDays = ${tripPlan.tripDays}; // 여행일수의 수량만큼 map 생성
    console.log("tripDays",tripDays);
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
            console.log("mapId:", mapId);
            console.log("mapIndex:", mapIndex);
            console.log("markerOptions:", markerOptions);

            var marker = new kakao.maps.Marker(markerOptions);
            marker.setMap(markerOptions.map);
            console.log("marker", marker);

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
        $("button[id='reviewLikes']").on("click", function () {
            var reviewNo = "${review.reviewNo}";
            $.ajax({ // userID와 tripPlanNo가 필요하여 객체로 전달
                url: "/review/reviewLikes",
                type: "GET",
                data: {"reviewLikes": reviewNo},
                success: function (data) {
                    console.log(data);
                    if (data == -1) {
                        alert("이미 추천한 후기입니다.");
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