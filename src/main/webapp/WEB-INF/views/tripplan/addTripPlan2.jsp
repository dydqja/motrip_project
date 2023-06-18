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

    <link rel="icon" type="image/png" href="assets/img/favicon.png"/>
    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">


    <!-- 설정용 변수 -->
    <script>
        let markers = []; // 오버레이 클릭시 보여줄 정보를 담은 배열
        let markersBound = []; // 마커가 여러개일 경우 버튼을 눌러서 화면을 재구성하기 위한 배열
        let maps = []; // 각 지도의 배열
        let placeTripPositions = []; // 이동시간 구하기 위한 명소의 좌표배열
        let placeTripTimes = []; // 좌표와 좌표사이의 이동시간들을 담아둔 배열
        let allPlaces = []; // 각 지도별 명소들의 배열로 저장되었었던 명소와 새로운 명소들
        let totalTripTimes = []; // 총 이동시간들의 배열
        let polylineArray = []; // 명소간 이동경로를 보여주기 위한 경로
        let pathArray = []; // 디비에 저장할 이동경로 패스값

        let placeData = [];

        let mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

        let idCheck = 1; // 늘어나거나 줄어나는 id의 값을 체크
        let isPlanPublic = false; // 공유여부
        let isPlanDownloadable = false; // 가져가기여부 (미구현)
        let tripPlanThumbnail = "";
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

        .map_wrap * {
            margin: 0;
            padding: 0;
            font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
            font-size: 12px;
        }

        .map_wrap a, .map_wrap a:hover, .map_wrap a:active {
            color: #000;
            text-decoration: none;
        }

        [id^="menu_wrap"] {
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            width: 250px;
            margin: 10px 0 30px 10px;
            padding: 5px;
            overflow-y: auto;
            background: rgba(255, 255, 255, 0.7);
            z-index: 1;
            font-size: 12px;
            border-radius: 10px;
        }

        .bg_white {
            background: rgba(255, 255, 255, 0.5); /* 투명도 조절 */
        }

        [id^="menu_wrap"] hr {
            display: block;
            height: 1px;
            border: 0;
            border-top: 2px solid #5F5F5F;
            margin: 3px 0;
        }

        [id^="menu_wrap"] .option {
            text-align: center;
        }

        [id^="menu_wrap"] .option p {
            margin: 10px 0;
        }

        [id^="menu_wrap"] .option button {
            margin-left: 5px;
        }

    </style>

</head>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<body>

<div class="post-single left">
    <div class="page-img" style="background-image: url('/images/tripImage.jpg'); height: 400px;">
        <div class="page-img-txt container">
            <div class="row">
                <div style="margin-top: 5%"></div>
                <div class="col-sm-12">
                    <div class="author">
                        <div class="author-img">
                            <img src="${user.userPhoto}" alt="">
                        </div>
                        <h4><span class="italic">${user.nickname}</span></h4>
                        <div style="display: flex">
                            <span><h4><input type="text" id="tripPlanTitle" placeholder="여행플랜 제목을 입력해주세요"
                                             style="color: black; width: 600px; height: 30px; opacity: 0.8;"></h4></span>
                            <h5>
                                공개<input type="checkbox" id="chbispublic" class="round" value="true"/>&nbsp;&nbsp;
                                비공개<input type="checkbox" id="chbpublic" class="round" value="false" checked="true"
                                          disabled/>
                            </h5>
                        </div>
                    </div>
                    <button class="btn-default icon-camera" id="tripPlanThumbnail"
                            style="font-size: 5px; margin-left: 0.8%">썸네일
                    </button>
                </div>
            </div>
        </div>
    </div>

    <main class="white">
        <div class="container">
            <div>
                <div style="text-align: right;">
                    <div class="btn btn-sm btn-success icon-date">여행일수</div>
                    <div>
                        <button class="btn btn-sm btn-success icon-triangle-up" id="btnAddTripDay"
                                style="background-color: #558B2F;"></button>
                        <button class="btn btn-sm btn-success icon-triangle-down" id="btnRemoveTripDay"
                                style="background-color: #558B2F;"></button>
                    </div>
                </div>
            </div>
        </div>

        <div class="container" id="container0">
            <div display="flex;">
                <div class="day"> 1일차 여행플랜
                    <button class="icon-locate-map right" id="reset0" style="font-size: 20px; border-radius: 15px;"
                            onclick="reset(event, 0)"></button>
                </div>
            </div>


            <div class="row">
                <div class="col-sm-12">
                    <div id="map0" style="width: 100%; height: 300px; border-radius: 15px;"></div>
                    <div id="menu_wrap0" class="bg_white" style="height:90%; overflow:auto; margin: 0%;">
                        <div class="input-group">
                            <input type="text" class="form-control" id="placeName0"
                                   onkeypress="handleKeyPress(event, 0)" placeholder="명소 검색"
                                   style="width: 60%; font-size: 11px">
                            <button class="btn btn-primary" id="placeSearch0" style="width: 30%; font-size: 9px;"
                                    onclick="handleKeyPress(event, 0)">검색
                            </button>
                        </div>
                        <ul id="placesList0"></ul>
                        <div id="pagination"></div>
                    </div>
                </div>
            </div>
            <div style="margin-top: 3%"></div>

            <div class="row">

                <div class="col-sm-9">
                    <textarea id="dailyPlanContents0" name="dailyPlanContents" required style="width: 100%;"></textarea>
                </div>

                <div class="col-sm-3">
                    <div class="sidebar">

                        <div class="border-box list0"
                             style="height: 600px; width: 100%; overflow-y: auto; overflow-x: hidden; border-radius: 15px;">
                            <div class="box-title ">명소리스트
                                <div class="card text-white mb-3 btn btn-sm btn-info"
                                     id="totalTripTime0"
                                     style="background-color: rgb(255,254,255); color: black; text-align: right; display: inline-block; border: none;"></div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <div class="addDaily" id="addDaily" style="text-align: right;">
                <button class="btn btn-primary" id="btnAddTripPlan" style="text-align: right;">저장</button>
                <button class="btn btn-primary" id="history" style="text-align: right;">취소</button>
            </div>

        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

<!-- 아래는 설정용 스크립트 입니다. -->

<script type="text/javascript">

    <!-- 서머노트기본생성 -->
    $(document).ready(function () {
        $('#dailyPlanContents0').summernote({
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
            height: 550,
            disableResizeEditor: true
        });
    });

    function initializeSummernote(idCheck) {
        $('#dailyPlanContents' + idCheck).summernote({
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
            height: 550,
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

<!-- 지도 관련 부분 -->

<script type="text/javascript">

    // 초기 지도 생성
    var startMapContainer = document.getElementById('map0'); // 초기 지도를 표시할 div
    startMapContainer.setAttribute('id', 'map0'); // id값 설정
    var startMap = new kakao.maps.Map(startMapContainer, mapOption);
    maps.push(startMap);

    // 명소 검색 관련
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

                if (!allPlaces['map' + indexCheck]) {
                    allPlaces['map' + indexCheck] = [];
                }

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
                        marker = addMarker(placePosition, allPlaces['map' + indexCheck].length),
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
                            marker.setMap(maps[indexCheck]);
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
                            if (!placeData[indexCheck]) {
                                placeData[indexCheck] = [];
                            }

                            marker.setMap(maps[indexCheck]); // 해당 지도에 마커를 표출합니다
                            markers[indexCheck].push(marker); // 해당 지도의 마커 배열에 추가합니다
                            console.log(markersBound);

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
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'KakaoAK ' + '6e3c7aaa8069d3ffebbb72c6865fb977');
                                },
                                success: function (response) {
                                    if (response.documents.length > 0) {
                                        var placeImage = response.documents[0].thumbnail_url;
                                        console.log(placeImage);

                                        // 이미지를 받아온 후에 다음 작업을 진행
                                        setTimeout(function () {
                                            var place = {
                                                placeTags: doc.querySelector('.info h5').textContent.trim(),
                                                placeAddress: doc.querySelector('.info span:not(.tel)').textContent.trim(),
                                                placeCoordinates: positions[placePositionId - 1].coordinates,
                                                placeImage: placeImage,
                                                placeCategory: 0,
                                                placePhoneNumber: doc.querySelector('.info .tel').textContent.trim(),
                                                tripPath: null,
                                                tripTime: null
                                            };
                                            allPlaces['map' + indexCheck].push(place);
                                            placeData[indexCheck].push(place);
                                            console.log("1번 저장 확인")
                                            console.log(placeData[indexCheck]);
                                        }, 1500); // 1.5초 지연 후에 다음 작업을 수행합니다.
                                    } else {
                                        console.log('검색 결과가 없습니다.');
                                        placeImage = '';
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.error(error); // 에러 발생시에도 이미지를 제외하고 저장해야함
                                    var place = {
                                        placeTags: doc.querySelector('.info h5').textContent.trim(),
                                        placeAddress: doc.querySelector('.info span:not(.tel)').textContent.trim(),
                                        placeCoordinates: positions[placePositionId - 1].coordinates,
                                        placeImage: placeImage,
                                        placeCategory: 0,
                                        placePhoneNumber: doc.querySelector('.info .tel').textContent.trim(),
                                        tripPath: null,
                                        tripTime: null
                                    };
                                    allPlaces['map' + indexCheck].push(place);
                                    placeData[indexCheck].push(place);
                                    console.log("2번 저장 확인")
                                    console.log(placeData[indexCheck]);
                                }
                            });


                            // 명소 사이 이동시간 구하기
                            if (placeTripPositions[indexCheck].length > 1) {
                                tripTime(placeTripPositions[indexCheck], varStatusIndex);
                            }

                            // 동적 생성
                            var newListBox = '<div class="col-12 column" style="text-align: center; border: none;">' +
                                '<div class="card text-white mb-3" style="width: auto; height: auto; font-size: 9px;">' +
                                '<div class="card-header" name="placeCategory" id="placeCategory' + indexCheck + '" data-index="' + varStatusIndex + '">' +
                                '<label class="deleteBox" name="deleteBox" id="deleteBox' + indexCheck + '" data-index="' + varStatusIndex + '">[삭제]</label>' +
                                '</div>' +
                                '<div class="card-body btn btn-lg btn-info" style="background-color: rgba(164,255,193,0.22); width: 70%; height: auto;">' +
                                '<h5 class="card-title" name="placeTitle" id="placeTitle' + indexCheck + '" data-index="' + varStatusIndex + '">' +
                                '<div style="color: black; width: 100%;">' +
                                '<span class="icon-locate" style="color: #467cf1;" value="' + 0 + '"></span>&nbsp;&nbsp;#' + title +
                                '</div>' +
                                '</h5>' +
                                '</div>' +
                                '</div>' +
                                '<div class="card text-white mb-3 btn btn-sm btn-info" name="tripTime" id="tripTime' + indexCheck + '" data-index="' + varStatusIndex + '"' +
                                'style="background-color: rgb(255,255,255); color: black; width: auto; height: auto; ">' +
                                '<div style="color: black; display: inline-block;"></div>' +
                                '</div>' +
                                '</div>';

                            var newPlaceElement = document.createElement('div');
                            newPlaceElement.setAttribute('id', 'newPlaceElement' + indexCheck);
                            newPlaceElement.innerHTML = newListBox;

                            // 추가할 목록 요소 가져오기
                            var listElement = document.querySelector('.list' + indexCheck);

                            // 목록 요소에 동적 요소 추가
                            listElement.appendChild(newPlaceElement);

                            // 마커가 여려개더라도 한화면으로 재구성
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
                        console.log("여기가 문제여 문제~~~~")
                        placeData[indexCheck][varStatusIndex - 1].tripPath = JSON.stringify(path);
                        console.log("세번째확인");
                        console.log(placeData[indexCheck]);

                        var polyline = new kakao.maps.Polyline({
                            map: maps[indexCheck],
                            path: path,
                            strokeWeight: 5,
                            strokeColor: '#e11f1f',
                            strokeOpacity: 0.8,
                            strokeStyle: 'shortdash'
                        });
                        polylineArray[indexCheck].push(polyline);

                        polyline.setMap(maps[indexCheck]);

                        var tripTimeEl = document.querySelector('[name="tripTime"][id="tripTime' + indexCheck + '"][data-index="' + (varStatusIndex - 1) + '"]');
                        if (hour == 0) {
                            if (minute === 30) {
                                tripTimeEl.textContent = "30분";
                            } else {
                                tripTimeEl.textContent = minute + "분";
                            }
                            placeData[indexCheck][varStatusIndex - 1].tripTime = minute;
                            placeTripTimes['map' + indexCheck].push(minute);
                            totalTripTimes[indexCheck] = (parseInt(totalTripTimes[indexCheck] || 0)) + minute;
                        } else {
                            var tripTimeText = "";
                            if (hour > 0) {
                                tripTimeText += hour + "시간";
                            }
                            if (minute > 0) {
                                if (minute >= 60) {
                                    hour++; // 분이 60 이상인 경우 시간을 1 증가시킴
                                    minute -= 60; // 분에서 60을 뺀 나머지를 계산
                                }
                                tripTimeText += " " + minute + "분";
                            }
                            tripTimeEl.textContent = tripTimeText;
                            placeData[indexCheck][varStatusIndex - 1].tripTime = ((hour * 60) + minute);
                            placeTripTimes['map' + indexCheck].push((hour * 60) + minute);
                            totalTripTimes[indexCheck] = (parseInt(totalTripTimes[indexCheck] || 0)) + (hour * 60) + minute;
                        }
                        $("#totalTripTime" + indexCheck).text(formatTime(totalTripTimes[indexCheck]));

                        function formatTime(minutes) {
                            var hours = Math.floor(minutes / 60);
                            var remainingMinutes = minutes % 60;
                            var formattedTime = "";

                            if (hours > 0) {
                                formattedTime += hours + "시간 ";
                            }
                            if (remainingMinutes > 0) {
                                formattedTime += remainingMinutes + "분";
                            }

                            return formattedTime;
                        }

                    },
                    error: function (xhr, status, error) {
                        console.log(error);
                    }
                });
            }

            function addMarker(position, idx, title) {  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
                var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                    imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                    imgOptions =  {
                        spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                        spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                    marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage
                    });

                return marker;
            }

            function overlays(place) { // 오버레이 표시
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
            };

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
                var overlayContent = '<div style="padding:5px; display: inline-block;">' + title + '</div>';
                infowindow.setContent(overlayContent); // 오버레이에 내용 설정
                infowindow.open(maps[indexCheck], marker); // 오버레이 표시
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

<!-- 아래는 버튼 클릭시 동작되는 부분입니다 -->

<script type="text/javascript">

    // 지도 화면 초기화
    function reset(event, indexCheck) {
        console.log(indexCheck);
        console.log(markersBound[indexCheck]);
        var bounds = markersBound[indexCheck];
        maps[indexCheck].setBounds(bounds);
    };

    // 여행플랜 저장
    $("#btnAddTripPlan").click(function () {

        var tripPlanTitle = $('#tripPlanTitle').val(); // 여행플랜 제목
        var dailyPlanContents = []; // 일차별 여행플랜 본문과 명소들을 모두 저장하는곳

        for (var i = 0; i < idCheck; i++) {
            var dailyPlanContent; // 일차별 여행플랜 본문
            var totalTripTime; // 일차별 명소간 총 이동시간
            var placeInfo = [] // 명소를 저장하는 배열
            var placeSum = 0; // 명소의 갯수 파악

            if (($('#dailyPlanContents' + i).val() != "" && $('#dailyPlanContents' + i).val() != null) && (allPlaces['map' + i] != undefined && allPlaces['map' + i] != null && allPlaces['map' + i].length != 0)) {

                dailyPlanContent = $('#dailyPlanContents' + i).val();
                totalTripTime = totalTripTimes[i];
                placeSum = allPlaces['map' + i].length;

                for (var j = 0; j < placeSum; j++) {
                    placeInfo.push(JSON.stringify(placeData[i][j]));
                }
                console.log("값을 찾아라!!!")
                console.log(placeData);
                console.log(placeData[i][j]);
                console.log("값을 찾아라!!!")

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
            tripPlanTitle: tripPlanTitle,
            tripPlanThumbnail: tripPlanThumbnail,
            tripDays: idCheck,
            isPlanPublic: isPlanPublic,
            isPlanDownloadable: isPlanDownloadable,
            dailyplanResultMap: dailyPlanContents.map(function (dailyPlan) {
                return {
                    dailyPlanContents: dailyPlan.dailyPlanContents,
                    totalTripTime: dailyPlan.totalTripTime,
                    placeResultMap: dailyPlan.placesInfo.map(place => JSON.parse(place)), // JSON 문자열을 객체로 변환
                };
            }),
        };

        console.log("저장전 확인");
        console.log(tripPlan);

        Swal.fire({
            title: '작성한 여행플랜을 저장합니다.',
            icon: 'info',
            showCancelButton: true,
            confirmButtonText: '저장',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({ // JSON 형태로 저장하여 RestContoller로 ajax통신
                    url: "/tripPlan/addTripPlan",
                    type: "POST",
                    data: JSON.stringify(tripPlan),
                    contentType: "application/json; charset=utf-8",
                    success: function () {
                        Swal.fire({
                            title: '저장 완료',
                            text: '여행플랜이 성공적으로 저장되었습니다.',
                            icon: 'success',
                            confirmButtonText: '확인'
                        }).then(() => {
                            window.location.href = "/tripPlan/tripPlanList";
                        });
                    },
                    error: function (xhr, status, error) {
                        console.log(error);
                        Swal.fire({
                            title: '저장 실패',
                            text: '여행플랜 저장 중에 오류가 발생했습니다.',
                            icon: 'error',
                            confirmButtonText: '확인'
                        });
                    }
                });
            }
        });

    });

    $(function () {
        $("#history").on("click", function () {
            Swal.fire({
                title: '이전으로 돌아가시겠습니까?',
                text: '지금까지 입력한 내용은 저장되지 않습니다.',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: '이동',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "/tripPlan/tripPlanList?type=all";
                }
            });
        });
    });

    $("#btnAddTripDay").click(function () { // 추가 지도 생성 최대 10개까지
        // 버튼 비활성화
        $(this).prop('disabled', true);

        // 일정 시간후에 버튼 활성화
        setTimeout(function () {
            $("#btnAddTripDay").prop('disabled', false);
        }, 500); // 0.5초 후에 버튼 활성화

        if (($('#dailyPlanContents' + (idCheck - 1)).val() == "" || $('#dailyPlanContents' + (idCheck - 1)).val() == null) || (allPlaces['map' + (idCheck - 1)] == undefined || allPlaces['map' + (idCheck - 1)] == null || allPlaces['map' + (idCheck - 1)].length == 0)) {
            alert("이전 여행플랜에 내용이 없다면 새로운 여행플랜을 작성할 수 없습니다.")
            return;
        }

        console.log(idCheck);
        // 새로운 요소를 생성
        if (idCheck < 5) {

            var dynamicHTML = '<hr></hr><div class="container" id="container' + idCheck + '">' +
                '<div display="flex;">' + '<div class="day">' + (idCheck + 1) + '일차 여행플랜' +
                '<button class="icon-locate-map right" id="reset' + idCheck + '" style="font-size: 20px; border-radius: 15px;" onclick="reset(event, ' + idCheck + ')"></button>' +
                '</div>' + '</div>' + '<div class="row">' + '<div class="col-sm-12">' +
                '<div id="map' + idCheck + '" style="width: 100%; height: 300px; border-radius: 15px;"></div>' +
                '<div id="menu_wrap' + idCheck + '" class="bg_white" style="height:90%; overflow:auto; margin: 0%;">' + '<div class="input-group">' +
                '<input type="text" class="form-control" id="placeName' + idCheck + '" onkeypress="handleKeyPress(event, ' + idCheck + ')" placeholder="명소 검색" style="width: 60%; font-size: 11px">' +
                '<button class="btn btn-primary" id="placeSearch' + idCheck + '" style="width: 30%; font-size: 9px;" onclick="handleKeyPress(event, ' + idCheck + ')">검색</button>' +
                '</div>' + '<ul id="placesList' + idCheck + '"></ul>' + '<div id="pagination"></div>' + '</div>' + '</div>' + '</div>' +
                '<div style="margin-top: 3%"></div>' + '<div class="row">' + '<div class="col-sm-9">' +
                '<textarea id="dailyPlanContents' + idCheck + '" name="dailyPlanContents" required style="width: 100%;"></textarea>' +
                '</div>' + '<div class="col-sm-3">' + '<div class="sidebar">' +
                '<div class="border-box list' + idCheck + '" style="height: 600px; width: 100%; overflow-y: auto; overflow-x: hidden; border-radius: 15px;">' +
                '<div class="box-title">명소리스트' +
                '<div class="card text-white mb-3 btn btn-sm btn-info" id="totalTripTime' + idCheck + '" style="background-color: rgb(255,254,255); color: black; text-align: right; display: inline-block; border: none;"></div>' +
                '</div>' + '</div>' + '</div>' + '</div>' + '</div>';

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
            maps.push(new kakao.maps.Map(mapDiv, mapOption));

            console.log(placeTripTimes['map' + idCheck]);
            console.log(totalTripTimes[idCheck]);
            console.log(placeTripPositions[idCheck]);
            console.log(allPlaces['map' + idCheck]);
            console.log(markers[idCheck]);
            console.log(markersBound[idCheck]);
            console.log(maps[idCheck]);
            console.log(maps);

            // 서머노트 추가생성
            initializeSummernote(idCheck);
            idCheck++;
            console.log("idCheck 증가하였음");

        } else {
            alert("하나의 여행플랜의 일정은 5개가 최대입니다. \n추가적인 일정은 새로운 여행플랜을 작성하여 이용해주시기 바랍니다.");
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
            var elementToRemove = document.getElementById('container' + (idCheck - 1));
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
                        idCheck--; // idCheck 감소
                        console.log("idCheck 감소하였음");
                    }
                } else {
                    // 내용이 없을 경우 바로 삭제
                    elementToRemove.parentNode.removeChild(elementToRemove);
                    delDailyPlan((idCheck - 1));
                    idCheck--; // idCheck 감소
                    console.log("idCheck 감소하였음");
                }
            }
        } else {
            alert("하나의 여행플랜의 반드시 필요합니다.");
        }
    });

    function delDailyPlan(indexCheck) {
        // 배열에서 전체 삭제
        console.log("삭제하겠습니다");
        console.log(indexCheck);

        console.log(placeTripTimes['map' + indexCheck]);
        console.log(totalTripTimes[indexCheck]);
        console.log(placeTripPositions[indexCheck]);
        console.log(allPlaces['map' + indexCheck]);
        console.log(markers[indexCheck]);
        console.log(markersBound[indexCheck]);
        console.log(maps[indexCheck]);
        console.log(placeData[indexCheck]);

        delete placeTripTimes['map' + indexCheck];
        totalTripTimes.splice(indexCheck, 1);
        delete placeTripPositions[indexCheck];
        delete allPlaces['map' + indexCheck];
        delete markers[indexCheck];
        delete markersBound[indexCheck];
        delete placeData[indexCheck];
        maps.splice(indexCheck, 1);

        console.log(maps);
    }

</script>

<script>

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

        if (index == 0) {

            console.log("0으로 시작")

            totalTripTimes[indexCheck] = (parseInt(totalTripTimes[indexCheck])) - placeTripTimes['map' + indexCheck][index];
            if (totalTripTimes[indexCheck] == 0 && totalTripTimes[indexCheck] == NaN) {
                $("#totalTripTime" + indexCheck).text("");
            } else {
                $("#totalTripTime" + indexCheck).text(formatTime(totalTripTimes[indexCheck])); // 앞뒤 시간을 모두 삭제하고 새롭게 표시
            }

            placeTripTimes['map' + indexCheck].splice(index, index + 1); // 시간 다시 구해서 넣기 위해 앞뒤로 지워야함
            placeTripPositions[indexCheck].splice(index, index + 1); // 삭제된 좌표 인덱스
            allPlaces['map' + indexCheck].splice(index, index + 1); // 삭제된 명소정보
            pathArray[indexCheck].splice(index, index + 1); // 폴리라인 경로 삭제

            var marker = markers[indexCheck][index];
            marker.setMap(null); // 마커를 지도에서 제거
            markers[indexCheck].splice(index, index + 1); // 마커 삭제

            var polyline = polylineArray[indexCheck][index]
            if (polyline != null) {
                polyline.setMap(null);
            }
            polylineArray[indexCheck].splice(index, index + 1); // 폴리라인 삭제

            console.log("지웠을때 어디인지 확인해야하고 고치자")
            placeData[indexCheck].splice(index, index + 1); // 최종 데이터값인데 처음부터 이걸로할걸...
            console.log(placeData[indexCheck]);

            // 이후 남아있는 리스트박스들의 id 값을 업데이트
            var elTripTimes = document.querySelectorAll('.card.text-white.mb-3[id="tripTime' + indexCheck + '"]');
            console.log(elTripTimes)
            console.log(elTripTimes.length)
            console.log("위에가 남아있는 리스트 크기임")

            if (elTripTimes.length == 0) {
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

            // 이부분은 맨마지막 항목을 제외했을때에도 체크하기 위해서 급하게 작성되었음
            var safeTripTime = document.querySelector('[name="tripTime"][id="tripTime' + indexCheck + '"][data-index="' + (index - 1) + '"]');
            var content = safeTripTime.innerHTML;
            var numbers = content.match(/\d+/g);
            var minutes = parseInt(numbers[0]);

            var safeTotalTripTime = (totalTripTimes[indexCheck] - minutes); // 맨마지막 항목을 제외했을때 비교하는
            console.log(safeTotalTripTime);


            totalTripTimes[indexCheck] = (parseInt(totalTripTimes[indexCheck])) - placeTripTimes['map' + indexCheck][index - 1];
            totalTripTimes[indexCheck] = (parseInt(totalTripTimes[indexCheck])) - placeTripTimes['map' + indexCheck][index];
            console.log(totalTripTimes[indexCheck])
            if (isNaN()) {
                $("#totalTripTime" + indexCheck).text("");
            } else {
                $("#totalTripTime" + indexCheck).text(formatTime(totalTripTimes[indexCheck])); // 앞뒤 시간을 모두 삭제하고 새롭게 표시
            }

            placeTripTimes['map' + indexCheck].splice(index - 1, index + 1); // 시간 다시 구해서 넣기 위해 앞뒤로 지워야함
            placeTripPositions[indexCheck].splice(index, index); // 삭제된 좌표 인덱스
            allPlaces['map' + indexCheck].splice(index, index); // 삭제된 명소정보
            pathArray[indexCheck].splice(index - 1, index + 1);

            var marker = markers[indexCheck][index];
            marker.setMap(null); // 마커를 지도에서 제거
            markers[indexCheck].splice(index, index); // 마커 삭제

            var polyline = polylineArray[indexCheck][index - 1] // 앞뒤로 지우기
            if (polylineArray[indexCheck][index] != null) {
                var polyline2 = polylineArray[indexCheck][index]
                polyline2.setMap(null);
            }
            polyline.setMap(null);

            polylineArray[indexCheck].splice(index - 1, index + 1); // 폴리라인 삭제

            placeData[indexCheck].splice(index, index); // 최종 데이터값인데 처음부터 이걸로할걸...

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

            if(end == null){

                allPlaces['map' + indexCheck][index-1].tripTime = "";
                allPlaces['map' + indexCheck][index-1].tripPath = "";

                console.log("이부분체크필요함")
                console.log(allPlaces['map' + indexCheck])

                $("#totalTripTime" + indexCheck).text(formatTime(safeTotalTripTime));
                var tripTimeEl = document.querySelector('[name="tripTime"][id="tripTime' + indexCheck + '"][data-index="' + (index - 1) + '"]');
                tripTimeEl.textContent = "";
                totalTripTimes[indexCheck] = safeTotalTripTime;
            }
        }


        if (end !== null && start !== null && start !== end && end !== undefined && start !== undefined && end !== 'undefined' && start !== 'undefined') { // 마지막 값이 없거나 명소가 같을 경우에는 찾지않음
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
                    console.log("여기가 문제여 문제~~~~")
                    placeData[indexCheck][index - 1].tripPath = JSON.stringify(path);


                    var polyline = new kakao.maps.Polyline({
                        map: maps[indexCheck],
                        path: path,
                        strokeWeight: 5,
                        strokeColor: '#e11f1f',
                        strokeOpacity: 0.8,
                        strokeStyle: 'shortdash'
                    });
                    polylineArray[indexCheck].push(polyline);

                    polyline.setMap(maps[indexCheck]);

                    var tripTimeEl = document.querySelector('[name="tripTime"][id="tripTime' + indexCheck + '"][data-index="' + (index - 1) + '"]');
                    console.log(tripTimeEl);
                    if (hour == 0) {
                        if (minute === 30) {
                            tripTimeEl.textContent = "30분";
                        } else {
                            tripTimeEl.textContent = minute + "분";
                        }
                        placeData[indexCheck][index - 1].tripTime = minute;
                        placeTripTimes['map' + indexCheck].push(minute);
                        totalTripTimes[indexCheck] = (parseInt(totalTripTimes[indexCheck] || 0)) + minute;
                    } else {
                        if (minute > 0) {
                            if (minute >= 60) {
                                hour++; // 분이 60 이상인 경우 시간을 1 증가시킴
                                minute -= 60; // 분에서 60을 뺀 나머지를 계산
                            }
                            tripTimeText += " " + minute + "분";
                        }
                        tripTimeEl.textContent = tripTimeText;
                        placeData[indexCheck][index - 1].tripTime = ((hour * 60) + minute);
                        placeTripTimes['map' + indexCheck].push((hour * 60) + minute);
                        totalTripTimes[indexCheck] = (parseInt(totalTripTimes[indexCheck] || 0)) + (hour * 60) + minute;
                    }
                    $("#totalTripTime" + indexCheck).text(formatTime(totalTripTimes[indexCheck]));

                    console.log(placeData[indexCheck]);
                },
                error: function (xhr, status, error) {
                    console.log(error);
                }
            });
        }
    });

    function formatTime(minutes) {
        var hours = Math.floor(minutes / 60);
        var remainingMinutes = minutes % 60;
        var formattedTime = "";

        if (hours > 0) {
            formattedTime += hours + "시간 ";
        }
        if (remainingMinutes > 0) {
            formattedTime += remainingMinutes + "분";
        }

        return formattedTime;
    }

    // 여행플랜 썸네일
    $("#tripPlanThumbnail").click(function () {
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

                // 파일 업로드 AJAX 요청
                $.ajax({
                    url: "/tripPlan/fileUpload",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        console.log("파일 업로드 성공:", response);
                        var imagePath = response;
                        tripPlanThumbnail = imagePath.replace(/^\/imagePath\//, "");
                        console.log(tripPlanThumbnail);
                        $(".page-img").css("background-image", "url('/imagePath/thumbnail/" + tripPlanThumbnail + "')");
                    },
                    error: function (xhr, status, error) {
                        console.log("파일 업로드 실패:", error);
                    }
                });
            }
        });
    });

</script>

<!-- 아래는 템플릿용 스크립트입니다. -->

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