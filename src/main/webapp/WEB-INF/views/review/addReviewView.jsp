<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>✈️Motrip🚤</title>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a"></script>
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
    <!-- Form 유효성 검증 -->
    <script type="text/javascript">

        function fncAddReview() {
            var reviewTitle = $("input[name='reviewTitle']").val();
            var reviewContents = $("textarea[name='reviewContents']").val();


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
                .attr("action", "/review/addReview")
                .submit();
        }

        $(function () {
            $("button.btn.btn-primary").on("click", function () {
                fncAddReview();
            });

            $("a[href='#']").on("click", function () {
                $("form")[0].reset(); 0
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

    <!-- 모달 JavaScript 코드 -->
    <script>
        $(document).ready(function() {
            $("#tripPlanModal").modal({backdrop: 'static', keyboard: false}); // Prevent closing the modal by clicking outside or pressing ESC key

            $(document).on('click', function(event) {
                if ($(event.target).closest("#tripPlanModal").length === 0) {
                    if ($("#selectedTripPlanTitle").val() === "") {
                        alert("후기를 작성할 여행 플랜을 선택하세요 !");
                    }
                }
            });
        });

    </script>
    <script>
        function selectTripPlan(tripPlanTitle, tripPlanNo) {
            $("#selectedTripPlanTitle").val(tripPlanTitle);
            $("#selectedTripPlanNo").val(tripPlanNo); // Set the tripPlanNo value
            $("#displaySelectedTripPlanNo").text(tripPlanNo);
            $("#displaySelectedTripPlanTitle").text(tripPlanTitle);
            $("#tripPlanModal").modal("hide");
        }

    </script>

    <!-- Bootstrap, jQuery CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script>
        $(this).find('ul').toggleClass('carousel');

        var photo = $(event.target).closest('li').data('photo');
        var modal = new kakao.maps.InfoWindow({
            content: '<img src="' + photo.url + '" />'
        });
        modal.open(map, event.target);
    </script>

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
            '    <div class="boxtitle">사진 앨범</div>' +
            '    <ul>';

        // DB에서 사진을 가져와서 커스텀 오버레이에 표시합니다
        $.ajax({
            url: '/api/photos',
            type: 'GET',
            dataType: 'json',
            success: function(photos) {
                $.each(photos, function(index, photo) {
                    content += '<li>' +
                        '<img src="' + photo.url + '" />' +
                        '</li>';
                });
            }
        });

        content += '</ul>' +
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

        // 마우스를 갖다대면 카로셀처럼 보여지도록 이벤트를 등록합니다
        customOverlay.on('mouseover', function() {
            $(this).find('ul').toggleClass('carousel');
        });

        // 사진을 클릭하면 모달창으로 크게 보이도록 이벤트를 등록합니다
        customOverlay.on('click', function(event) {
            var photo = $(event.target).closest('li').data('photo');
            var modal = new kakao.maps.InfoWindow({
                content: '<img src="' + photo.url + '" />'
            });
            modal.open(map, event.target);
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


</head>
<body>
<!-- 화면구성 div Start -->
<!-- 모달 창 내용 -->
<div id="tripPlanModal" class="modal">
    <div class="modal-content">
        <h4>✈️✈️Trip Plans✈️✈️</h4>
        <ul>
            <c:if test="${not empty tripPlanList['tripPlanList']}">
                <ul>
                    <c:forEach items="${tripPlanList['tripPlanList']}" var="tripPlan">
                        <li>
                            <a href="#" onclick="selectTripPlan('${tripPlan.tripPlanTitle}', '${tripPlan.tripPlanNo}')">${tripPlan.tripPlanTitle}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </ul>
    </div>
</div>

<div class="container">
    <h1>후기 작성</h1>
    <!-- form Start -->
    <form action="/review/addReview" method="post">
        <div class="row">

            <div class="col-xs-4 col-md-2"><strong>TripPlanTitle:</strong></div>
            <div class="col-xs-8 col-md-4">
                <input type="hidden" id="selectedTripPlanTitle" name="selectedTripPlanTitle" value="${TripPlan.tripPlanTitle}" />
                <input type="hidden" id="selectedTripPlanNo" name="tripPlanNo" value="${TripPlan.tripPlanNo}" />
                <input type="hidden" name="reviewRegDate" id="reviewRegDate" value="${review.reviewRegDate}">
                <span id="displaySelectedTripPlanTitle"></span>
            </div>
        </div>
        <hr/>
        <div class="form-group">
            <label for="reviewAuthor">Review Author:</label>
            <input type="text" id="reviewAuthor" name="reviewAuthor" required><br><br>
        </div>
        <div class="form-group">
            <label for="reviewTitle">제목:</label>
            <input type="text" id="reviewTitle" name="reviewTitle" required /><br><br>
        </div>

        <hr/>
        <!--Kakao Map Api-->
        <div id="map" style="width:100%;height:350px;"></div>
        <hr/>

        <div class="form-group">
            <label for="reviewContents">내용:</label><br>
            <textarea id="reviewContents" name="reviewContents" required></textarea><br><br>
        </div>
        <div class="form-group">
            <label for="reviewThumbnail">썸네일:</label>
            <input type="text" id="reviewThumbnail" name="reviewThumbnail" required /><br><br>
        </div>
        <div class="form-group">
            <label for="instaPostLink">인스타그램 링크:</label>
            <input type="text" id="instaPostLink" name="instaPostLink" required /><br><br>
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
</html>
