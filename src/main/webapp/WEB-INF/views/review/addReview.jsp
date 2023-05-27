<!--//////////////////////////////////////////////////////////////////////////-->
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
        <div class="col-xs-4 col-md-2"><strong>Selected Trip Plan No:</strong></div>
        <div class="col-xs-8 col-md-4">${review.tripPlanNo}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>Review Author:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewAuthor}</div>
    </div>

    <hr/>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>제목:</strong></div>
        <div class="col-xs-8 col-md-4">${review.reviewTitle}</div>
    </div>

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
        <div class="col-xs-8 col-md-4">
            <div class="col-xs-8 col-md-4">${review.reviewPublic}</div>
        </div>
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
        <div class="col-xs-8 col-md-4">
            <div class="col-xs-8 col-md-4">${review.reviewDelDate}</div>
        </div>
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
