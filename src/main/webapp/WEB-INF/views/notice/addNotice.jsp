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

        <title>공지사항 등록</title>

        <link rel="icon" type="image/png" href="assets/img/favicon.png" />
        <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
        <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
        <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
        <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
        <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
        <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

        <link rel="stylesheet" href="/css/notice/addNotice.css">
        <!-- 썸머노트 스타일시트 -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.css" rel="stylesheet">
    </head>

    <body>

        <header class="nav-menu fixed">
            <%@ include file="/WEB-INF/views/layout/header.jsp" %>
        </header>

        <div class="page-img">
            <div class="container">
                <h1 class="main-head text-center board-title">${noticeTitle}</h1>
            </div>
        </div>

        <c:set var="formAction" value="${(noticeTitle == null && noticeContents == null) ? '/notice/addNotice' : '/notice/updateNotice'}" />

        <form action="${formAction}" method="post">

            <input type="hidden" name="noticeAuthor" value="${sessionScope.user.userId}" />

            <c:if test="${noticeNo != null}">

                <input type="hidden" name="noticeNo" value="${noticeNo}" />

            </c:if>

            <div>

                <input type="text" name="noticeTitle" id="noticeTitle" value="${noticeTitle}">

            </div>

            <br>

            <div>
                <!-- 썸머노트 입력란 -->
                <textarea name="noticeContents" id="summernote">${noticeContents}</textarea>
            </div>

            <br>

            <div>
                <button id="addNotice" type="submit">등록하기</button>
            </div>

            <br>

            <div>
                <button type="reset">초기화</button>
            </div>

            <br>

            <div>
                <button id="getNoticeList" type="button">목록보기</button>
            </div>

        </form>

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

        <!-- 썸머노트 스크립트 -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.js"></script>

        <script type="text/javascript">

            $(function() {

                // 썸머노트 초기화
                $('#summernote').summernote({
                    height: 300, // 입력창 높이 설정
                    minHeight: null, // 최소 높이 설정
                    maxHeight: null, // 최대 높이 설정
                    focus: true, // 포커스 설정
                    lang: 'ko-KR', // 언어 설정 (한국어)
                    toolbar: [
                        // 원하는 썸머노트 기능 추가 가능
                        ['style', ['bold', 'italic', 'underline', 'clear']],
                        ['font', ['strikethrough']],
                        ['fontsize', ['fontsize']],
                        ['color', ['color']],
                        ['para', ['ul', 'ol', 'paragraph']],
                        ['height', ['height']]
                    ]
                });

                $("#addNotice").on("click", function() {

                    var noticeTitle = $("#noticeTitle").val();
                    var noticeContents = $("#noticeContents").val();

                    if (!noticeTitle && !noticeContents) {

                        alert("제목과 내용을 입력해주세요.");
                        return false;

                    } else if (!noticeTitle) {

                        alert("제목을 입력해주세요.");
                        return false;

                    } else if (!noticeContents) {

                        alert("내용을 입력해주세요.");
                        return false;

                    } else {

                        $('form').submit();
                    }
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