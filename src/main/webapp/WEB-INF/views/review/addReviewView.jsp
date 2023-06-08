<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>✈️Motrip🚤</title>

    <!-- Bootstrap, jQuery CDN -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"><!--모달창-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script><!--모달창-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a&libraries=services"></script>

    <!-- Summernote CDN -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    <!-- Summernote CSS 파일 추가 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.css" rel="stylesheet">

    <style>
        /* 모달 스타일 */
        .modal {
            display: none; /* 기본적으로 숨겨진 상태로 시작 */
            position: fixed; /* 고정 위치 */
            z-index: 9999; /* 다른 요소보다 위에 표시 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto; /* 스크롤 가능하도록 설정 */
            background-color: rgba(0, 0, 0, 0.6); /* 배경색 및 투명도 설정 */
        }

        .modal-content {
            background-color: #fff; /* 모달 내용 배경색 */
            margin: 10% auto; /* 모달을 수직 및 수평 가운데로 위치 */
            padding: 20px;
            width: 500px; /* 모달 너비 */
            max-width: 90%; /* 최대 너비 */
            max-height: 80vh; /* 최대 높이 */
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
            overflow: auto; /* 내용이 넘칠 경우 스크롤 가능하도록 설정 */
        }

        .modal-content table {
            width: 100%;
            border-collapse: collapse;
        }

        .modal-content th,
        .modal-content td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .modal-content th {
            background-color: #f2f2f2; /* 헤더 배경색 */
        }

        .modal-content .trip-plan-item:hover {
            background-color: #f2f2f2; /* 아이템 호버 시 배경색 */
            cursor: pointer;
        }
    </style>

    <style>/* 모달 작성취소버튼 */
        .cancel-button-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }

        .cancel-button-container button {
            padding: 5px 10px;
        }
    </style>
    <style>
        /* 에디터의 높이를 500px로 설정*/
        .note-editor .note-editing-area .note-editable {
            height: 500px;
        }
    </style>
    <style>️
        /* 토글스위치 CSS */
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
    /* 토글스위치 CSS */
    </style>
    <style>
        .overlaybox {position:relative;width:360px;height:350px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px;}
        .overlaybox div, ul {overflow:hidden;margin:0;padding:0;}
        .overlaybox li {list-style: none;}
        .overlaybox .boxtitle {color:#fff;font-size:16px;font-weight:bold;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png') no-repeat right 120px center;margin-bottom:8px;}
        .overlaybox .first {position:relative;width:247px;height:136px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumb.png') no-repeat;margin-bottom:8px;}
        .first .text {color:#fff;font-weight:bold;}
        .first .triangle {position:absolute;width:48px;height:48px;top:0;left:0;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png') no-repeat; padding:6px;font-size:18px;}
        .first .movietitle {position:absolute;width:100%;bottom:0;background:rgba(0,0,0,0.4);padding:7px 15px;font-size:14px;}
        .overlaybox ul {width:247px;}
        .overlaybox li {position:relative;margin-bottom:2px;background:#2b2d36;padding:5px 10px;color:#aaabaf;line-height: 1;}
        .overlaybox li span {display:inline-block;}
        .overlaybox li .number {font-size:16px;font-weight:bold;}
        .overlaybox li .title {font-size:13px;}
        .overlaybox ul .arrow {position:absolute;margin-top:8px;right:25px;width:5px;height:3px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png') no-repeat;}
        .overlaybox li .up {background-position:0 -40px;}
        .overlaybox li .down {background-position:0 -60px;}
        .overlaybox li .count {position:absolute;margin-top:5px;right:15px;font-size:10px;}
        .overlaybox li:hover {color:#fff;background:#d24545;}
        .overlaybox li:hover .up {background-position:0 0px;}
        .overlaybox li:hover .down {background-position:0 -20px;}
    </style>

    <script>
        $(document).ready(function() {
            $('#reviewContents').summernote();
        });
    </script>

</head>
<body>

<script type="text/javascript">
    function fncAddReview() {
        var reviewTitle = $("input[name='reviewTitle']").val();
        var reviewContents = $("textarea[name='reviewContents']").val();
        var tripPlanNo = parseInt($("input[name='tripPlanNo']").val());
        console.log("tripPlanNo: >>>>",tripPlanNo);

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
            .attr("action", "/review/addReview?tripPlanNo=" + tripPlanNo) // tripPlanNo를 URL의 쿼리 파라미터로 전달
            .submit();
    }

    $(function () {
        $("button.btn.btn-primary").on("click", function () {
            console.log("작성완료버튼을 눌렀습니다.")
            fncAddReview();
        });

        $("a[href='#']").on("click", function () {
            $("form")[0].reset();
        });
    });
</script>


<script>
    $(function () {
        $("#checkStatusBtn").on("click", function (event) {
            event.preventDefault(); // 폼 제출 기본 동작 막기

            var isPublic = $(".reviewPublic").prop("checked");
            var status = isPublic ? "True" : "False";
            alert("현재 공개여부: " + status);
        });
    });

</script>


<script>
    $(document).ready(function() {
        $(".isReviewPublic").change(function() {
            var isChecked = $(this).prop("checked");
            if (isChecked) {
                $("#isReviewPublicInput").val("True");
            } else {
                $("#isReviewPublicInput").val("False");
            }
        });

        $("#checkStatusBtn").click(function() {
            var isChecked = $(".isReviewPublic").prop("checked");
            if (isChecked) {
                console.log("공개여부: True");
            } else {
                console.log("공개여부: False");
            }
        });
    });
</script>

<!-- 화면구성 div Start -->
<!-- 모달 창 내용 -->
<script>
    // 모달 창이 열릴 때 자동으로 실행되는 함수
    $(document).ready(function() {
        // 모달 창 열기
        $("#myModal").modal({
            backdrop: "static",
            keyboard: false
        });

        // 모달 창 외부 클릭 시 경고창 띄우기
        $(document).on("click", ".modal-backdrop", function() {
            alert("여행플랜을 반드시 선택해야 합니다.");
        });

        // 모달 창에서 tripPlanTitle 클릭 시 처리
        $(document).ready(function() {
            // 모달 창에서 tripPlanTitle 클릭 시 처리
            $("#tripPlansTableBody").on("click", ".tripPlanTitle", function() {
                // 선택한 tripPlan의 정보 가져오기
                var tripPlanNo = $(this).closest("tr").find(".tripPlanNo").text();
                var tripPlanTitle = $(this).text();

                // addReviewView.jsp에 tripPlan 정보 전달
                $("#tripPlanNo").val(tripPlanNo);
                $("#tripPlanTitle").val(tripPlanTitle);

                // 콘솔에 선택한 값 출력
                console.log("선택한 Trip Plan No:",tripPlanNo);
                console.log("선택한 Trip Plan 제목:", tripPlanTitle);

                // 선택한 tripPlanTitle을 표시
                $("#displaySelectedTripPlanTitle").text(tripPlanTitle);

                // 선택한 tripPlanTitle을 표시
                $("#displayTripPlanNo").text(tripPlanNo);

                // 모달 창 닫기
                $("#myModal").modal("hide");
            });
        });

        // 작성 취소 버튼 클릭 시 뒤로 가기
        $("#cancelButton").click(function() {
            history.back();
        });
    });
</script>



</script>
<!-- 모달 창 내용 붛러오기 시작 -->
<script>
    $(document).ready(function () {
        // AJAX 요청을 통해 tripPlans 목록을 가져옴
        $.ajax({
            url: "/review/getCompletedTripPlan",
            method: "GET",
            dataType: "json",
            contentType: 'application/json; charset=utf-8',
            headers: { "Accept": "application/json" },
            success: function (data, textStatus, jqXHR)  {

                console.log("상태 코드: ", jqXHR.status);
                console.log("상태 메시지: ", textStatus);

                // 테이블에 동적으로 표시할 tbody
                var tbody = $("#tripPlansTableBody");
                // tbody 내용 비우기
                tbody.empty();
                // tripPlans 목록을 받아와 테이블에 동적으로 표시
                for (var i = 0; i < data.length; i++) {
                    var tripPlan = data[i];
                    var tripPlanNo = tripPlan.tripPlanNo;
                    var tripPlanTitle = tripPlan.tripPlanTitle;

                    // 테이블에 동적으로 추가
                    var tripPlanItem = "<tr class='trip-plan-item'><td class='tripPlanNo'>" + tripPlanNo + "</td><td class='tripPlanTitle' data-tripPlanNo='" + tripPlanNo + "'>" + tripPlanTitle + "</td></tr>";


                    tbody.append(tripPlanItem);
                }

                // tripPlan 선택 시 이벤트 처리
                $(".trip-plan-item").click(function() {
                    var tripPlanNo = $(this).find(".tripPlanTitle").data("tripPlanNo");
                    var tripPlanTitle = $(this).find(".tripPlanTitle").text();

                    // 선택한 tripPlanNo와 tripPlanTitle을 숨겨진 입력 폼에 설정
                    $("#tripPlanNo").val(tripPlanNo);
                    $("#tripPlanTitle").val(tripPlanTitle);
                });

                // 모달 창 보이기
                $("#myModal").modal({
                    backdrop: "static",
                    keyboard: false
                });
            },
            error: function (xhr, status, error) {
                console.log("AJAX Error: " + error);
                console.log("상태 코드: ", jqXHR.status);
                console.log("상태 메시지: ", textStatus);
                console.log("AJAX 에러: ", errorThrown);
            }
        });
    });


</script>
<!-- 모달 창 내용 붛러오기 끝 -->
<!-- 모달 창 내용 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <div class="modal-guide">후기를 작성할 여행플랜을 선택하세요.</div>
        <table>
            <thead>
            <tr>
                <th>Trip Plan No</th>
                <th>Trip Plan 제목</th>
            </tr>
            </thead>
            <tbody id="tripPlansTableBody">
            <!-- 각 여행 계획 목록 항목을 출력 -->
            </tbody>
        </table>
        <div class="cancel-button-container">
            <button id="cancelButton">작성취소</button>
        </div>
    </div>
</div>
<script>
    // 모달 창에서 전달받은 tripPlanNo와 tripPlanTitle 가져오는 함수 정의
    function getSelectedTripPlanInfo() {
        var tripPlanNo = $("#tripPlanNo").val();
        var tripPlanTitle = $("#tripPlanTitle").val();

        // 가져온 값 확인
        console.log("선택한 Trip Plan No:", tripPlanNo);
        console.log("선택한 Trip Plan 제목:", tripPlanTitle);
        // 선택된 Trip Plan 제목을 출력
        $("#displayTripPlanNo").text(tripPlanNo);
        $("#displaySelectedTripPlanTitle").text(tripPlanTitle);
    }

    // 문서가 로드된 후 실행
    $(document).ready(function() {
        getSelectedTripPlanInfo();
    });
</script>

<div class="container">
    <h1>후기 작성</h1>
    <!-- form Start -->
    <form action="/review/addReview" method="post">
        <div class="row">
            <div class="col-xs-4 col-md-2">
                <strong>TripPlanNo:</strong>
            </div>
            <div class="col-xs-8 col-md-4">
                <span id="displayTripPlanNo"></span>
                <input type="hidden" name="tripPlanNo" value="${selectedTripPlanNo}" />
                <input type="hidden" name="reviewAuthor" value="${loggedInUser.userId}" />
            </div>
            <!-- addReviewView.jsp에서 표시할 tripPlanTitle -->
            <div class="col-xs-4 col-md-2">
                <strong>TripPlanTitle:</strong>
            </div>
            <div class="col-xs-8 col-md-4">
                <span id="displaySelectedTripPlanTitle"></span>
            </div>
        </div>
        <hr/>
        <c:set var="nickname" value="${user.nickname}"/>
        <div class="form-group">
            <label for="nickname">ReviewAuthor's nickname:</label>
            <span id="nickname"><c:out value="${nickname}" /></span>
        </div>


        <hr/>

        <div class="form-group">
            <label for="reviewTitle">제목:</label>
            <input type="text" id="reviewTitle" name="reviewTitle" required /><br><br>
        </div>

        <!-- 지도를 표시할 div 입니다 -->
        <div id="map" style="width:100%;height:350px;"></div>
        <script>
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                mapOption = {
                    center: new kakao.maps.LatLng(37.502, 127.026581), // 지도의 중심좌표
                    level: 4 // 지도의 확대 레벨
                };

            var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

            // 커스텀 오버레이에 표시할 내용입니다
            // HTML 문자열 또는 Dom Element 입니다
            var content = '<div class="overlaybox">' +
                '    <div class="boxtitle">금주 영화순위</div>' +
                '    <div class="first">' +
                '        <div class="triangle text">1</div>' +
                '        <div class="movietitle text">드래곤 길들이기2</div>' +
                '    </div>' +
                '    <ul>' +
                '        <li class="up">' +
                '            <span class="number">2</span>' +
                '            <span class="title">명량</span>' +
                '            <span class="arrow up"></span>' +
                '            <span class="count">2</span>' +
                '        </li>' +
                '        <li>' +
                '            <span class="number">3</span>' +
                '            <span class="title">해적(바다로 간 산적)</span>' +
                '            <span class="arrow up"></span>' +
                '            <span class="count">6</span>' +
                '        </li>' +
                '        <li>' +
                '            <span class="number">4</span>' +
                '            <span class="title">해무</span>' +
                '            <span class="arrow up"></span>' +
                '            <span class="count">3</span>' +
                '        </li>' +
                '        <li>' +
                '            <span class="number">5</span>' +
                '            <span class="title">안녕, 헤이즐</span>' +
                '            <span class="arrow down"></span>' +
                '            <span class="count">1</span>' +
                '        </li>' +
                '    </ul>' +
                '</div>';

            // 커스텀 오버레이가 표시될 위치입니다
            var position = new kakao.maps.LatLng(37.49887, 127.026581);

            // 커스텀 오버레이를 생성합니다
            var customOverlay = new kakao.maps.CustomOverlay({
                position: position,
                content: content,
                xAnchor: 0.3,
                yAnchor: 0.91
            });

            // 커스텀 오버레이를 지도에 표시합니다
            customOverlay.setMap(map);
        </script>

        <div class="form-group">
            <label for="reviewContents">내용:</label><br>
            <textarea id="reviewContents" name="reviewContents" required></textarea><br><br>
        </div>
        <div class="form-group">
            <label for="reviewThumbnail">썸네일:</label>
            <input type="text" id="reviewThumbnail" name="reviewThumbnail"  /><br><br>
        </div>
        <div class="form-group">
            <label for="instaPostLink">인스타그램 링크:</label>
            <input type="text" id="instaPostLink" name="instaPostLink"  /><br><br>
        </div>

        <div class="form-group">
            <label class="switch">
                <input class="reviewPublic" type="checkbox" name="reviewPublic"/>
                <span class="switch-label" data-on="True" data-off="False"></span>
                <span>공개여부</span>
                <span class="switch-handle"></span>
            </label>
            <button type="button" class="btn btn-primary" id="checkStatusBtn">상태 확인</button>

        </div>
        <div class="form-group">
            <label for="reviewLikes">Review Likes:</label>
            <input type="number" id="reviewLikes" name="reviewLikes" required><br><br>
        </div>
        <div class="form-group">
            <label for="viewCount">View Count:</label>
            <input type="number" id="viewCount" name="viewCount" required><br><br>
        </div>


        <div class="form-group">
            <label class="switch">
                <input class="reviewDeleted" type="checkbox" name="reviewDeleted"/>
                <span class="switch-label" data-on="True" data-off="False"></span>
                <span>isReviewDeleted</span>
                <span class="switch-handle"></span>
            </label>
            <button class="btn btn-primary" id="reviewDeleted">상태 확인</button>
        </div>

        <div class="form-group">
            <label for="reviewDelDate">Review Delete Date:</label>
            <input type="date" id="reviewDelDate" name="reviewDelDate"><br><br>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-4 col-sm-4 text-center">
                <button type="submit" class="btn btn-primary mr-2">작성완료</button>
                <a class="btn btn-primary" href="#" role="button">취소</a>
            </div>
        </div>
    </form>
    <!-- form End -->
</div>
<!-- 화면구성 div End -->
</body>
