<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>공지사항</title>

        <link rel="icon" type="image/png" href="/assets/img/favicon.png" />
        <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
        <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
        <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
        <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
        <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
        <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

        <link rel="stylesheet" href="/css/notice/getNotice.css">
    </head>

    <body>

    <div class="page-img" style="background-image: url('/images/board/noticeTop.jpg');">

        <header class="nav-menu fixed">
            <%@ include file="/WEB-INF/views/layout/header.jsp" %>
        </header>

        <div class="container">
            <h1 class="main-head text-center board-title noticeZooming">${noticeGetData.noticeTitle}</h1>
        </div>
    </div>

    <div class="page-img" style="background-image: url('/images/board/noticeBack.jpg');">

        <div class="container">

            <form action="/notice/updateNoticeView" method="post">

                <input type="hidden" name="noticeTitle" value="${noticeGetData.noticeTitle}" />
                <input type="hidden" name="noticeNo" value="${noticeGetData.noticeNo}" />
                <input type="hidden" name="noticeContents" value="${noticeGetData.noticeContents}" />

                <div>
                    <div class="col-md-8 notice-content">
                        <div class="centered-content">
                            ${noticeGetData.noticeContents}
                        </div>
                    </div>

                    <div class="text-right">
                        <div class="d-inline-block">

                            <c:if test="${sessionScope.user.userId eq 'admin'}">

                                <div>
                                    <button id="updateNoticeView" class="btn btn-primary">내용 수정</button>
                                </div>

                                <br>

                                <div>
                                    <button id="deleteNotice" class="btn btn-primary">삭제하기</button>
                                </div>

                            </c:if>

                            <br>

                            <div>
                                <button id="getNoticeList" class="btn btn-primary">목록보기</button>
                            </div>

                        </div>
                    </div>
                </div>
            </form>

        </div>

    </div>

        <%@ include file="/WEB-INF/views/layout/footer.jsp" %>

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
        <script src="/assets/js/min/home.min.js"></script>

        <script type="text/javascript">

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#updateNoticeView").on("click", function (e) {
                    e.preventDefault();
                    $('form').submit();
                });

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#deleteNotice").on("click", function(e) {
                    e.preventDefault();
                    var noticeNo = "${noticeGetData.noticeNo}";
                    window.location.href = "/notice/deleteNotice?noticeNo=" + noticeNo;
                });

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#getNoticeList").on("click" , function(e) {
                    e.preventDefault();
                    window.location.href = "/notice/noticeList?currentPage=1";
                });
            });

        </script>

    </body>

</html>