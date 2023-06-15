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

        <title>질의 상세</title>

        <link rel="icon" type="image/png" href="/assets/img/favicon.png" />
        <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
        <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
        <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
        <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
        <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
        <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
        <link rel="stylesheet" href="/css/qna/getQna.css"/>

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
        <c:set var="formAction" value="${(sessionScope.user.userId eq 'admin') ? '/qna/addQnaAnswer' : '/qna/updateQnaView'}" />
        <form action="${formAction}" method="post">

            <input type="hidden" name="qnaNo" value="${qnaGetData.qnaNo}" />
            <input type="hidden" name="qnaTitle" value="${qnaGetData.qnaTitle}" />
            <input type="hidden" name="qnaContents" value="${qnaGetData.qnaContents}" />
            <input type="hidden" name="isQnaAnswered" value="${qnaGetData.isQnaAnswered}" />
            <input type="hidden" name="qnaCategory" value="${qnaGetData.qnaCategory}" />

            <%@ include file="/WEB-INF/views/layout/header.jsp" %>

            <div class="page-img" style="background-image: url('/images/board/qnaTop.jpg');">
                <div class="container">
                    <h1 class="main-head text-center board-title Zooming">${qnaGetData.qnaTitle}</h1>
                </div>
            </div>

            <div class="page-img" style="background-image: url('/images/board/qnaBack.jpg');">

                <div class="container">

                    <div class="qLine">
                        <div >
                            <h3>Q.&nbsp;<span class="category">${qnaGetData.qnaCategory == 0 ? '계정문의' : qnaGetData.qnaCategory == 1 ? '기타문의' : qnaGetData.qnaCategory == 2 ? '여행플랜' : qnaGetData.qnaCategory == 3 ? '채팅' : qnaGetData.qnaCategory == 4 ? '메모' : '후기'}</span></h3>
                            <hr>
                        </div>

                        <div class="col-md-11 qna-content">
                            ${qnaGetData.qnaContents}
                        </div>
                    </div>

                    <div class="text-right">
                        <div class="d-inline-block">

                            <!--유저만 볼 수 있음-->
                            <c:if test="${sessionScope.user.userId ne 'admin' && not empty sessionScope.user.userId && empty qnaGetData.qnaAnswerContents && sessionScope.user.userId eq qnaGetData.qnaAuthor}">
                                <div>
                                    <button id="updateQnaView" class="btn btn-primary" type="button">내용 수정</button>
                                </div>
                            </c:if>

                            <!--운영자나 유저가 볼 수 있음-->
                            <c:if test="${sessionScope.user.userId eq 'admin' || not empty sessionScope.user.userId && empty qnaGetData.qnaAnswerContents && sessionScope.user.userId eq qnaGetData.qnaAuthor}">
                                    <br>
                                <div>
                                    <button id="deleteQna" class="btn btn-danger" type="button">삭제하기</button>
                                </div>
                            </c:if>
                                <br>
                            <div>
                                <button id="getQnaList" class="btn btn-secondary" type="button">처음으로</button>
                            </div>

                            <!--운영자만 볼 수 있음-->
                            <c:if test="${sessionScope.user.userId eq 'admin' }">
                                    <br>
                                <div>
                                    <button id="addQnaAnswer" class="btn btn-primary" type="button">응답 등록</button>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!--유저만 볼 수 있음-->
                    <c:if test="${sessionScope.user.userId ne 'admin' && qnaGetData.qnaAnswerContents != null}">
                        <div class="aLine">
                            <div>
                                <h3>A.</h3>
                                <hr>
                            </div>

                            <div class="qnaAnswer">
                                ${qnaGetData.qnaAnswerContents}
                            </div>
                        </div>
                    </c:if>

                    <!--운영자만 볼 수 있음-->
                    <c:if test="${sessionScope.user.userId eq 'admin' }">
                        <div class="aLine">
                            <div>
                                <h3>A.</h3>
                                <hr>
                            </div>

                            <div class="qnaAnswerContents">
                                <label for="qnaAnswerContents"></label><textarea name="qnaAnswerContents" id="qnaAnswerContents">${qnaGetData.qnaAnswerContents}</textarea>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </form>

        <%@ include file="/WEB-INF/views/layout/footer.jsp" %>

        <script type="text/javascript">

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $('#addQnaAnswer').on('click', function() {

                    if ($('#qnaAnswerContents').val().trim() === '') {

                        Swal.fire({
                            title: '안녕하세요!',
                            text: '답변을 입력해주세요.',
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
                $("#deleteQna").on("click", function() {

                    var qnaNo = "${qnaGetData.qnaNo}";

                    window.location.href = "/qna/deleteQna?qnaNo=" + qnaNo;
                });
            });

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#updateQnaView").on("click", function() {

                    $('form').submit();
                });
            });

            $(function() {

                // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                $("#getQnaList").on("click", function() {

                    window.location.href = "/qna/qnaList";
                });
            });

            <!-- 서머노트 기본생성 -->
            $(document).ready(function () {
                $('#qnaAnswerContents').summernote({
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
                    height: 150,
                    width: 1010,
                    disableResizeEditor: true
                });
            });

            // 썸머노트 초기화 함수
            function resetSummernote() {
                $('#qnaAnswerContents').summernote('code', '');
            }

            // 초기화 버튼 클릭 시 썸머노트 초기화
            $('#reset').on('click', function () {
                resetSummernote();
            });
        </script>

    </body>

</html>