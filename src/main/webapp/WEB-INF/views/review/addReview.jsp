
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // reviewRegDate 값 가져오기
    String reviewRegDate = request.getParameter("reviewRegDate");
    if (reviewRegDate == null) {
        reviewRegDate = request.getAttribute("reviewRegDate").toString();
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>✈️Motrip🚤</title>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c6ffa2721e097b8c38f9548c63f6e31a"></script>
    <script type="text/javascript">

        $(function () {
            $( "button.btn.btn-primary" ).on("click" , function() { //확인
                self.location = "/review/getMyReviewList.jsp";
            });

            $("a[href='#' ]").on("click" , function() {
                self.location = "../review/addReviewView.jsp"; //추가등록
            });
        });
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

</head>
<body>

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">후기가 등록되었습니다.</h3>
        <h5 class="text-muted">등록한 후기를 확인하세요.</h5>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>Trip Plan No:</strong></div>
        <div class="col-xs-8 col-md-4">${review.tripPlanNo}</div>
        <div class="col-xs-4 col-md-2"><strong>Trip Plan Title:</strong></div>
        <div class="col-xs-8 col-md-4">${tripPlan.tripPlanTitle}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>Review Author:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewAuthor}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>후기 등록일:</strong></div>
        <div class="col-xs-8 col-md-4"><%= reviewRegDate %></div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>제목:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewTitle}</div>
    </div>

    <hr/>
    <!--Kakao Map Api-->
    <div id="map" style="width:100%;height:350px;"></div>
    <hr/>

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

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>인스타그램 링크:</strong></div>
        <div class="col-xs-8 col-md-4">${review.instaPostLink}</div>
    </div>

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
        </div>
    </div>

    <br/>

</div>
<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>
