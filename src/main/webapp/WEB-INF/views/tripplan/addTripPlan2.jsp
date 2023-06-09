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
    <link rel="stylesheet" href="/css/tripplan/overlay.css">
    <script src="/vendor/jquery/dist/jquery.min.js"></script>
    <script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <link rel="stylesheet" href="/summernote/summernote.css">
    <script src="/summernote/summernote.js"></script>
    <!-- 구분선 -->

    <link rel="icon" type="image/png" href="assets/img/favicon.png"/>
    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">ㅅ
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

    <!-- sortable -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script>
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
                start: function (event, ui) {
                    $(this).css('background-color', 'rgb(213,222,232)');
                },
                // 모든 이동이 끝난 후에 마지막으로 실행
                stop: function (event, ui) {
                    $(this).css('background-color', 'transparent');
                }
            });
            // 해당 클래스 하위의 텍스트 드래그를 막는다.
            $(".column .card").disableSelection();
        });

        // 삭제 라벨
        $(document).on('click', ".deleteBox", function () {
            var id = $(this).attr('id');
            var indexCheck = id.slice("deleteBox".length);
            var index = $(this).data('index');

            console.log("id : " + indexCheck);
            console.log("index : " + index);

            if (index == 0) {
                alert("첫번째값은 다른 명소가 있는 경우에는 삭제시킬수없습니다. 나중에 앞서 다른 명소들 삭제후 삭제시킬수있게 만들것이며 이동순서를 바꿔서 삭제");
            } else {
                var prevTripTimeEl = document.querySelector('.card.text-white.mb-3[id="tripTime' + indexCheck + '"][data-index="' + (index - 1) + '"]'); // 명소를 삭제했을 때 이전 시간 리스트박스
                var newTripTimeEl = document.createElement('div'); // 대체할 새로운 시간 리스트박스
                newTripTimeEl.className = 'card text-white mb-3';
                newTripTimeEl.setAttribute('id', 'tripTime' + indexCheck);
                newTripTimeEl.setAttribute('name', 'tripTime');
                newTripTimeEl.style.backgroundColor = 'rgb(132, 200, 224)';
                newTripTimeEl.style.width = 'auto';
                newTripTimeEl.style.height = 'auto';
                newTripTimeEl.style.textAlign = 'center';
                newTripTimeEl.setAttribute('data-index', index - 1);
                console.log(prevTripTimeEl);

                var tripTimeEl = document.querySelector('.card.text-white.mb-3[id="tripTime' + indexCheck + '"][data-index="' + (index) + '"]'); // 명소를 삭제했을 때 시간 리스트박스
                console.log(tripTimeEl);

                // 배열에서 해당 명소 정보 삭제
                if (placeTripTimes['map' + indexCheck][index] != undefined || placeTripTimes['map' + indexCheck][index] != null) {
                    totalTripTimes[indexCheck] = totalTripTimes[indexCheck] - placeTripTimes['map' + indexCheck][index]; // 시간을 다시 구하기 위해 총 더한 시간에서 없어진 시간들을 지움
                    tripTimeEl.parentNode.replaceChild(newTripTimeEl, tripTimeEl); // 시간 리스트박스를 대체할 새로운 시간 리스트박스로 교체
                }

                totalTripTimes[indexCheck] = totalTripTimes[indexCheck] - placeTripTimes['map' + indexCheck][index - 1]; // 시간을 다시 구하기 총 더한 시간에서 없어진 시간들을 지움
                prevTripTimeEl.parentNode.removeChild(prevTripTimeEl);

                $("#totalTripTime" + indexCheck).text(totalTripTimes[indexCheck]);
                placeTripTimes['map' + indexCheck].splice(index - 1, index + 1); // 시간을 다시 구하기 위해서 앞뒤로 지워야함
                placeTripPositions[indexCheck].splice(index, index); // 삭제된 좌표 인덱스
                allPlaces['map' + indexCheck].splice(index, index); // 삭제된 명소정보
                var marker = markers[indexCheck][index];
                marker.setMap(null); // 마커를 지도에서 제거
                markers[indexCheck].splice(index, index); // 마커 삭제

                // 삭제된 화면을 재구성
                var bounds = new kakao.maps.LatLngBounds();
                for (var i = 0; i < markers[indexCheck].length; i++) {
                    bounds.extend(markers[indexCheck][i].getPosition());
                }
                markersBound[indexCheck] = bounds;
                maps[indexCheck].setBounds(bounds);

                // 이후 남아있는 리스트박스들의 id 값을 업데이트
                var elTripTimes = document.querySelectorAll('.card.text-white.mb-3[id="tripTime' + indexCheck + '"]');
                if (index != elTripTimes.length) {
                    for (var i = index; i < elTripTimes.length; i++) {
                        elTripTimes[i].setAttribute('data-index', i);
                    }
                } else {
                    elTripTimes[index - 1].setAttribute('data-index', index - 1);
                }
                var elCategory = document.querySelectorAll('.card-header[name="placeCategory"][id="placeCategory' + indexCheck + '"]');
                for (var i = index; i < elCategory.length; i++) {
                    elCategory[i].setAttribute('data-index', i - 1);
                    console.log(elCategory[i]);
                }
                var elDeleteBoxes = document.querySelectorAll('.deleteBox[id="deleteBox' + indexCheck + '"]');
                for (var i = index; i < elDeleteBoxes.length; i++) {
                    elDeleteBoxes[i].setAttribute('data-index', i - 1);
                    console.log(elDeleteBoxes[i]);
                }
                var elPlaceTitles = document.querySelectorAll('.card-title[name="placeTitle"][id="placeTitle' + indexCheck + '"]');
                for (var i = index; i < elPlaceTitles.length; i++) {
                    elPlaceTitles[i].setAttribute('data-index', i - 1);
                    console.log(elPlaceTitles[i]);
                }

                var start = placeTripPositions[indexCheck][index - 1];
                var end = placeTripPositions[indexCheck][index];
                if (end != null) { // 마지막 값이 없다면 시간을 다시 찾지않는다.
                    $.ajax({ // 명소간 이동시간 구하기(길찾기 API)
                        url: "/tripPlan/tripTime",
                        type: "GET",
                        data: {start: start, end: end},
                        dataType: "JSON",
                        success: function (data) {

                            var hour = parseInt(data.hour);
                            var minute = parseInt(data.minute);

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
                $(this).parent().parent().remove();
            }

        });
    </script>

    <!-- 설정용 변수 -->
    <script>
        let markers = []; // 오버레이 클릭시 보여줄 정보를 담은 배열
        let markersBound = []; // 마커가 여러개일 경우 버튼을 눌러서 화면을 재구성하기 위한 배열
        let maps = []; // 각 지도의 배열
        let placeTripPositions = []; // 이동시간 구하기 위한 명소의 좌표배열
        let placeTripTimes = []; // 좌표와 좌표사이의 이동시간들을 담아둔 배열
        let allPlaces = []; // 각 지도별 명소들의 배열로 저장되었었던 명소와 새로운 명소들
        let totalTripTimes = []; // 총 이동시간들의 배열
        //let overlays = []; // 기존 저장되어있던 마커

        let mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

        let idCheck = 1; // 늘어나거나 줄어나는 id의 값을 체크
        let isPlanPublic = false; // 공유여부
        let isPlanDownloadable = false; // 가져가기 여부

    </script>

    <c:if test="${empty sessionScope.user.userId}">
        <script>
            // 유저가 로그인되어 있지 않은 경우
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
                    <div class="author-img">
                        <img src="/images/tripImage.jpg" alt="">
                    </div>
                    <div class="author">
                        <h4>
                            <span class="italic">${user.userId}</span>
                            <span class="dot">·</span>
                            <span id="currentDate">${date}</span>
                        </h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <main class="white">
        <div class="container">

            <div>
                <span><h4><input type="text" id="tripPlanTitle" placeholder="여행플랜 제목"
                                 style="color: black; width: 57%; height: 40px; opacity: 0.5;"></h4></span>
                <h5>
                    공개<input type="checkbox" id="chbispublic" class="round" value="true"/>&nbsp;&nbsp;
                    비공개<input type="checkbox" id="chbpublic" class="round" value="false" checked="true" disabled/>
                    <span class="dot">·</span>
                    가져가기 가능<input type="checkbox" id="chbIsDownloadle" class="round" value="true" disabled/>&nbsp;&nbsp;
                    가져가기 불가능<input type="checkbox" id="chbDownloadle" class="round" value="false" disabled/>
                </h5>
            </div>

            <div class="row">
                <div class="col-sm-7">
                    <textarea id="dailyPlanContents0" name="dailyPlanContents" required></textarea>
                </div>

                <div class="col-sm-5">
                    <div class="sidebar">
                        <div style="text-align: center;">
                            <div class="tag-link">여행일수</div>
                            <button class="icon-triangle-up" id="btnAddTripDay"
                                    style="background-color: #558B2F;"></button>
                            <button class="icon-triangle-down" id="btnRemoveTripDay"
                                    style="background-color: #558B2F;"></button>
                        </div>
                        <div class="border-box">
                            <div id="menu_wrap0"></div>
                            <div class="box-title">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="placeName0"
                                           onkeypress="handleKeyPress(event, 0)" placeholder="명소 검색">
                                    <div class="input-group-btn">
                                        <button class="btn btn-primary" id="placeSearch0"
                                                onclick="handleKeyPress(event, 0)">Search
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <button class="icon-locate-map" id="reset0" onclick="reset(event, 0)"></button>
                            <div id="map0" style="width: 100%; height: 300px;"></div>
                            <ul id="placesList0"></ul>
                            <div id="pagination"></div>
                        </div>

                        <div class="border-box">
                            <div class="box-title">명소리스트
                                <div class="tag-link" style="text-align: right;" id="totalTripTime0"></div>
                            </div>
                            <ul class="list0">

                            </ul>
                        </div>

                    </div>
                </div>
            </div>
            <button class="btn btn-primary" id="btnAddTripPlan">저장</button>

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

<!-- 아래는 설정용 스크립트 입니다. -->

<script type="text/javascript">

    <!-- 서머노트기본생성 -->
    $(document).ready(function () {
        $('#dailyPlanContents0').summernote({
            height: '100vh',
            scrollingContainer: '.note-editor',
            lang: "ko-KR"
        });
    });

    function initializeSummernote(idCheck) {
        $('#dailyPlanContents' + idCheck).summernote({
            height: '100vh',
            scrollingContainer: '.note-editor',
            focus: true,
            lang: "ko-KR"
        });
    }

    <!-- 체크박스 true, false -->
    $("#chbispublic").click(function () {
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
    $("#chbpublic").click(function () {
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
    $("#chbIsDownloadle").click(function () {
        isPlanDownloadable = this.value;
        console.log(isPlanDownloadable);
        var chbIsDownloadle = $(this);
        var chbDownloadle = $("#chbDownloadle");

        chbIsDownloadle.prop("disabled", true);
        chbDownloadle.prop("disabled", false);
        chbDownloadle.prop("checked", false);
    });

    // 가져가기 불가능 체크박스 클릭 이벤트 핸들러
    $("#chbDownloadle").click(function () {
        isPlanDownloadable = this.value;
        console.log(isPlanDownloadable);
        var chbDownloadle = $(this);
        var chbIsDownloadle = $("#chbIsDownloadle");

        chbDownloadle.prop("disabled", true);
        chbIsDownloadle.prop("disabled", false);
        chbIsDownloadle.prop("checked", false);
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
                        marker = addMarker(placePosition, i),
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

                            var place = {
                                placeTags: doc.querySelector('.info h5').textContent.trim(),
                                placeAddress: doc.querySelector('.info span:not(.tel)').textContent.trim(),
                                placeCoordinates: positions[placePositionId - 1].coordinates,
                                placeCategory: 0,
                                placePhoneNumber: doc.querySelector('.info .tel').textContent.trim(),
                                tripTime: null
                            };
                            allPlaces['map' + indexCheck].push(place);

                            // 명소 사이 이동시간 구하기
                            if (placeTripPositions[indexCheck].length > 1) {
                                tripTime(placeTripPositions[indexCheck], varStatusIndex);
                            }

                            // 동적 생성
                            var newListBox = '<div class="col-12 column">' +
                                '<div class="card text-white mb-3" style="background-color: rgb(80, 250, 120); width: auto; height: auto; text-align: center;">' +
                                '<div class="card-header" name="placeCategory" id="placeCategory' + indexCheck + '" data-index="' + varStatusIndex + '">' +
                                '</div>' + '<label class="deleteBox" name="deleteBox" id="deleteBox' + indexCheck + '" data-index="' + varStatusIndex + '"> [삭제]</label>' +
                                '<div class="card-body">' + '<h4 class="card-title" name="placeTitle" id="placeTitle' + indexCheck + '" data-index=' + varStatusIndex + '></h4>' + title + '</div>' +
                                '</div>' + '</div>' +
                                '<div class="card text-white mb-3" name="tripTime" id="tripTime' + indexCheck + '" data-index=' + varStatusIndex + ' style="background-color: rgb(132, 200, 224); width: auto; height: auto; text-align: center;">' +
                                '<div></div></div>';

                            var newPlaceElement = document.createElement('div');
                            newPlaceElement.setAttribute('id', 'newPlaceElement' + indexCheck);
                            newPlaceElement.innerHTML = newListBox;

                            // 추가할 목록 요소 가져오기
                            var listElement = document.querySelector('.list' + indexCheck);

                            // 목록 요소에 동적 요소 추가
                            listElement.appendChild(newPlaceElement);
                            console.log(markers[indexCheck][0].getPosition());

                            // 마커가 여려개더라도 한화면으로 재구성
                            var bounds = new kakao.maps.LatLngBounds();
                            for (var i = 0; i < markers[indexCheck].length; i++) {
                                bounds.extend(markers[indexCheck][i].getPosition());
                            }
                            markersBound[indexCheck] = bounds;

                            maps[indexCheck].setBounds(bounds);
                        };
                    })(marker, places[i].place_name);
                    fragment.appendChild(itemEl);
                }
                // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
                listEl.appendChild(fragment);
                menuEl.scrollTop = 0;
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
                        console.log(hour + ":" + minute);

                        var tripTimeEl = document.querySelector('[name="tripTime"][id="tripTime' + indexCheck + '"][data-index="' + (varStatusIndex - 1) + '"]');
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

            dailyPlanContent = $('#dailyPlanContents' + i).val();
            totalTripTime = totalTripTimes[i];
            console.log("idCheck : " + idCheck);
            console.log("placeSum : " + placeSum);
            console.log(allPlaces['map' + i]);
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

        console.log(tripPlan);


        $.ajax({ // JSON 형태로 저장하여 RestContoller로 ajax통신
            url: "/tripPlan/addTripPlan",
            type: "POST",
            data: JSON.stringify(tripPlan),
            contentType: "application/json; charset=utf-8",
            success: function () {
                window.location.href = "/tripPlan/tripPlanList";
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
        }, 1500); // 1.5초 후에 버튼 활성화

        // 새로운 요소를 생성
        if (idCheck < 10) {

            var dynamicHTML = '<hr></hr><main class="white">' +
                '<div class="container">' + '<div class="row">' + '<div class="col-sm-7">' +
                '<textarea id="dailyPlanContents' + idCheck + '" name="dailyPlanContents" required></textarea>' +
                '</div>' + '<div class="col-sm-5">' + '<div class="sidebar">' +
                '<div class="border-box">' + '<div id="menu_wrap' + idCheck + '"></div>' + '<div class="box-title">' + '<div class="input-group">' +
                '<input type="text" class="form-control" id="placeName' + idCheck + '" onkeypress="handleKeyPress(event, ' + idCheck + ')" placeholder="명소 검색">' +
                '<div class="input-group-btn">' +
                '<button class="btn btn-primary" id="placeSearch' + idCheck + '" onclick="handleKeyPress(event, ' + idCheck + ')">Search</button>' +
                '</div>' + '</div>' + '</div><button class="icon-locate-map" id="reset' + idCheck + '" onclick="reset(event, ' + idCheck + ')"></button>' +
                '<div id="map' + idCheck + '" style="width: 100%; height: 300px;"></div>' + '<ul id="placesList' + idCheck + '"></ul>' + '<div id="pagination"></div>' +
                '</div>' + '<div class="border-box">' + '<div class="box-title">명소리스트 <div class="tag-link" style="text-align: right;" id="totalTripTime' + idCheck + '"></div></div>' +
                '<ul class="list' + idCheck + '">' + '</ul>' + '</div>' + '</div>' + '</div>' + '</div>' + '</div>' + '</main>';

            // 동적으로 생성한 요소들을 DOM에 추가
            var newElement = document.createElement('div');
            newElement.setAttribute('id', 'newElement' + idCheck);
            newElement.innerHTML = dynamicHTML;
            // addButton 요소 가져오기
            var btnElement = document.getElementById('btnAddTripPlan');

            // addButton 위에 동적 요소 추가
            btnElement.parentNode.insertBefore(newElement, btnElement);

            // 지도를 생성 및 옵션 설정
            var mapDiv = document.getElementById('map' + idCheck);
            mapDiv.setAttribute('id', 'map' + idCheck);
            maps.push(new kakao.maps.Map(mapDiv, mapOption));

            initializeSummernote(idCheck);
            idCheck++;
            console.log("idCheck 증가하였음");
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
        }, 1500); // 1.5초 후에 버튼 활성화

        if (idCheck > 1) {
            var elementToRemove = document.getElementById('newElement' + (idCheck - 1));
            if (elementToRemove) {
                elementToRemove.parentNode.removeChild(elementToRemove);
                idCheck--; // idCheck 감소
                console.log("idCheck 감소하였음");
            }
        } else {
            alert("하나의 여행플랜의 반드시 필요합니다.");
        }
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