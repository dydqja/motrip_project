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

        <title>공지 등록</title>

        <link rel="icon" type="image/png" href="assets/img/favicon.png" />
        <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
        <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
        <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
        <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
        <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
        <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
        <link rel="stylesheet" href="/css/notice/addNotice.css">

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

        <!-- alert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

        <!-- 서머노트 CDN 링크 -->
        <link rel="stylesheet" href="/summernote/summernote.css">
        <script src="/summernote/summernote.js"></script>
    </head>

    <body>
        <c:set var="formAction" value="${(noticeTitle == null && noticeContents == null) ? '/notice/addNotice' : '/notice/updateNotice'}" />
        <form action="${formAction}" method="post">

            <input type="hidden" name="noticeAuthor" value="${sessionScope.user.userId}" />

            <c:if test="${noticeNo != null}">

                <input type="hidden" name="noticeNo" value="${noticeNo}" />

            </c:if>

            <%@ include file="/WEB-INF/views/layout/header.jsp" %>

            <div class="page-img" style="background-image: url('/images/board/noticeTop.jpg');">
                <div class="container">
                    <h1 class="main-head text-center board-title noticeZooming">공지 등록</h1>
                </div>
            </div>

            <div class="page-img page-back" style="background-image: url('/images/board/noticeBack.jpg');">

                <div class="container">
                    <div>
                        <select name="isNoticeImportant">
                            <option value="0" ${isNoticeImportant == 0 ? 'selected' : ''}>일반</option>
                            <option value="1" ${isNoticeImportant == 1 ? 'selected' : ''}>중요</option>
                        </select>
                        <input type="text" name="noticeTitle" id="noticeTitle" placeholder="제목을 입력해주세요" value="${noticeTitle}" style="color: black; width: 89%; height: 40px;">
                    </div>

                    <br>

                    <div>
                        <!-- 썸머노트 입력란 -->
                        <textarea name="noticeContents" id="noticeContents">${noticeContents}</textarea>
                    </div>

                    <div class="row">

                        <div class="col-md-2">
                            <button id="reset" class="btn btn-primary" type="reset">초기화</button>
                        </div>

                        <div class="text-right">
                            <div class="d-inline-block">
                                <!-- 공지 등록 버튼 -->

                                <button id="addNotice" class="btn btn-primary" type="button">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    등록하기
                                </button>

                                <!-- 목록보기 버튼 -->
                                <button id="getNoticeList" class="btn btn-primary" type="button">목록보기</button>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

        </form>

        <%@ include file="/WEB-INF/views/layout/footer.jsp" %>

        <script type="text/javascript">

            $(function() {

                $("#addNotice").on("click", function() {

                    var noticeTitle = $("#noticeTitle").val();
                    var noticeContents = $("#noticeContents").val();

                    if (!noticeTitle && !noticeContents) {

                        Swal.fire({
                            title: '안녕하세요!',
                            text: '제목과 내용을 입력해주세요.',
                            icon: 'warning'
                        });
                        return false;

                    } else if (!noticeTitle) {

                        Swal.fire({
                            title: '안녕하세요!',
                            text: '제목을 입력해주세요.',
                            icon: 'warning'
                        });
                        return false;

                    } else if (!noticeContents) {

                        Swal.fire({
                            title: '안녕하세요!',
                            text: '내용을 입력해주세요.',
                            icon: 'warning'
                        });
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

            <!-- 서머노트 기본생성 -->
            $(document).ready(function () {
                $('#noticeContents').summernote({
                    toolbar: [
                        ['fontname', ['fontname']],
                        ['fontsize', ['fontsize']],
                        ['style', ['bold', 'italic', 'underline']],
                        ['color', ['forecolor', 'color']],
                        ['table', ['table']],
                        ['para', ['ul', 'ol', 'paragraph']],
                        ['height', ['height']],
                    ],
                    fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
                    fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72'],
                    height: 370,
                    disableResizeEditor: true
                });
            });

            // 썸머노트 초기화 함수
            function resetSummernote() {
                $('#noticeContents').summernote('code', '');
            }

            // 초기화 버튼 클릭 시 썸머노트 초기화
            $('#reset').on('click', function () {
                resetSummernote();
            });
        </script>

    </body>

</html>