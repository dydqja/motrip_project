<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.bit.motrip.domain.Review" %>

<body>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>✈️Motrip🚤</title>

<script type="text/javascript">

    $(function () {
        $( "button.btn.btn-primary" ).on("click" , function() { //확인
            self.location = "/review/getMyReviewList.jsp";
        });

        $("a[href='#' ]").on("click" , function() {
            self.location = "../review/addReviewView.jsp"; //추가등록
        });
        $("a[href='#' ]").on("click" , function() {
            self.location = "../review/reviewList"; //모든 리뷰목록
        });
    });
</script>

<!-- Bootstrap, jQuery CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a&libraries=services"></script>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);
</script>


<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">후기가 등록되었습니다.</h3>
        <h5 class="text-muted">등록한 후기를 확인하세요.</h5>
    </div>

    <hr/>

    <div class="row">
        <c:set var="tripPlanNo" value="${selectedTripPlanNo}" />
        <p>Trip Plan Number: ${tripPlanNo}</p>
        <div class="col-xs-4 col-md-2"><strong>Trip Plan Title:</strong></div>
        <div class="col-xs-8 col-md-4">${tripPlan.tripPlanTitle}</div>
    </div>

    <hr/>

    <c:set var="nickname" value="${user.nickname}"/>
    <div class="form-group">
        <label for="nickname">ReviewAuthor's nickname:</label>
        <span id="nickname"><c:out value="${nickname}" /></span>
    </div>
    <!-- <div class="col-xs-4 col-md-2"><strong>Review Author:</strong></div>
    <div class="col-xs-8 col-md-4">${review.reviewAuthor}</div> -->



    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>제목:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewTitle}</div>
    </div>

    <hr/>
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

    <!-- JavaScript로 서버에서 받아온 게시물 링크를 임베드하는 스크립트 -->
    <script>
        // 서버에서 전달받은 인스타그램 게시물 링크
        var instagramLink = "<c:out value="${instagramLink}" />";

        // 인스타그램 게시물 임베드 함수
        function embedInstagramPost(link) {
            // 인스타그램 게시물을 임베드할 코드 작성
            var embedCode = "<!-- 인스타그램 게시물 임베드 코드 -->";

            // 게시물을 보여줄 영역에 임베드 코드 삽입
            $("#instagramEmbed").html(embedCode);
        }

        // 페이지 로드 시 게시물 임베드 함수 호출
        $(document).ready(function() {
            embedInstagramPost(instagramLink);
        });
    </script>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>내용:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewContents}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>썸네일:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewThumbnail}</div>
    </div>

    <hr/>

    <!-- 인스타그램 게시물을 보여줄 영역 -->
    <div id="instagramEmbed"></div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>공개 여부:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewPublic}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>Review Likes:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewLikes}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>View Count:</strong></div>
        <div class="col-xs-8 col-md-4">${review.viewCount}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>삭제 처리 여부:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewDeleted}</div>
    </div>

    <hr/>

    <div class="form-group">
        <div class="col-sm-offset-4  col-sm-4 text-center">
            <button type="button" class="btn btn-primary">확&nbsp;인</button>
            <a class="btn btn-primary btn" href="#" role="button">추가등록</a>
            <a class="btn btn-primary btn2" href="#" role="button">다른 후기들 보러가기</a>
        </div>
    </div>


    <br/>

</div>

</body>

