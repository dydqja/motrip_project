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

        <title>문의 등록</title>

        <link rel="icon" type="image/png" href="assets/img/favicon.png" />
        <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
        <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
        <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
        <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
        <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
        <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
        <link rel="stylesheet" href="/css/qna/addQna.css"/>

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
        <c:set var="formAction" value="${(qnaTitle == null && qnaContents == null) ? '/qna/addQna' : '/qna/updateQna'}" />
        <form action="${formAction}" method="post">

            <input type="hidden" name="qnaAuthor" value="${sessionScope.user.userId}" />

            <c:if test="${qnaNo != null}">

                <input type="hidden" name="qnaNo" value="${qnaNo}" />

            </c:if>

            <%@ include file="/WEB-INF/views/layout/header.jsp" %>

            <div class="page-img" style="background-image: url('/images/board/noticeTop.jpg');">
                <div class="container">
                    <h1 class="main-head text-center board-title Zooming">문의 등록</h1>
                </div>
            </div>

            <div class="page-img page-back" style="background-image: url('/images/board/noticeBack.jpg');">

                <div class="container">
                    <div>
                        <select name="qnaCategory">
                            <option value="0" ${qnaCategory == 0 ? 'selected' : ''}>계정문의</option>
                            <option value="1" ${qnaCategory == 1 ? 'selected' : ''}>기타문의</option>
                            <option value="2" ${qnaCategory == 2 ? 'selected' : ''}>여행플랜</option>
                            <option value="3" ${qnaCategory == 3 ? 'selected' : ''}>채팅</option>
                            <option value="4" ${qnaCategory == 4 ? 'selected' : ''}>메모</option>
                            <option value="5" ${qnaCategory == 5 ? 'selected' : ''}>후기</option>
                        </select>

                        <input type="text" name="qnaTitle" id="qnaTitle" placeholder="제목을 입력해주세요" value="${qnaTitle}">
                    </div>

                    <br>

                    <div>
                        <!-- 썸머노트 입력란 -->
                        <textarea name="qnaContents" id="qnaContents">${qnaContents}</textarea>
                    </div>

                    <div class="row">

                        <div class="col-md-2">
                            <button id="reset" class="btn btn-primary" type="reset">초기화</button>
                        </div>

                        <div class="text-right">
                            <div class="d-inline-block">

                                <!-- 문의 등록 버튼 -->
                                <button id="addQna" class="btn btn-primary" type="button">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                    등록하기
                                </button>

                                <!-- 목록보기 버튼 -->
                                <button id="getQnaList" class="btn btn-primary" type="button">목록보기</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </form>

        <script type="text/javascript">

            $(function() {

                $("#addQna").on("click", function() {

                    var qnaTitle = $("#qnaTitle").val();
                    var qnaContents = $("#qnaContents").val();

                    if (!qnaTitle && !qnaContents) {

                        Swal.fire({
                            title: '안녕하세요!',
                            text: '제목과 내용을 입력해주세요.',
                            icon: 'warning'
                        });
                        return false;

                    } else if (!qnaTitle) {

                        Swal.fire({
                            title: '안녕하세요!',
                            text: '제목을 입력해주세요.',
                            icon: 'warning'
                        });
                        return false;

                    } else if (!qnaContents) {

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
                $("#getQnaList").on("click" , function() {

                    window.location.href = "/qna/qnaList";
                });
            });

            <!-- 서머노트 기본생성 -->
            $(document).ready(function () {
                $('#qnaContents').summernote({
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
                $('#qnaContents').summernote('code', '');
            }

            // 초기화 버튼 클릭 시 썸머노트 초기화
            $('#reset').on('click', function () {
                resetSummernote();
            });
        </script>
    </body>
</html>