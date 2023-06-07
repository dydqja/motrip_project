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

        <title>공지사항 상세</title>

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

        <%@ include file="/WEB-INF/views/layout/header.jsp" %>

        <div class="container">

            <h1>공지사항 상세</h1>

            <br>
            <br>
            <br>

            <form action="/notice/updateNoticeView" method="post">

                <input type="hidden" name="noticeNo" value="${noticeGetData.noticeNo}" />

                <div>
                    <input type="hidden" name="noticeTitle" value="${noticeGetData.noticeTitle}" />
                    ${noticeGetData.noticeTitle}
                </div>

                <br>

                <div>
                    <input type="hidden" name="noticeContents" value="${noticeGetData.noticeContents}" />
                    ${noticeGetData.noticeContents}
                </div>

                <br>

                <c:if test="${sessionScope.user.userId eq 'admin'}">

                    <div>
                        <button id="updateNoticeView" type="submit">내용 수정</button>
                    </div>

                    <br>

                    <div>
                        <button id="deleteNotice" type="button">삭제하기</button>
                    </div>

                </c:if>

                <br>

                <div>
                    <button id="getNoticeList" type="button">목록보기</button>
                </div>

            </form>

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
                $("#updateNoticeView").on("click", function() {

                    $('form').submit();
                });
            });

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#deleteNotice").on("click", function() {

                    var noticeNo = "${noticeGetData.noticeNo}";

                    window.location.href = "/notice/deleteNotice?noticeNo=" + noticeNo;
                });
            });

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#getNoticeList").on("click" , function() {

                    window.location.href = "/notice/noticeList";
                });
            });

        </script>

    </body>

</html>