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

        <title>질의응답 상세</title>

        <link rel="icon" type="image/png" href="/assets/img/favicon.png" />
        <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
        <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
        <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
        <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
        <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
        <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

        <link rel="stylesheet" href="/css/qna/getQna.css"/>
    </head>

    <body>

        <%@ include file="/WEB-INF/views/layout/header.jsp" %>

        <div class="container">

            <h1>질의응답 상세</h1>

            <br>
            <br>
            <br>

            <c:set var="formAction" value="${(sessionScope.user.userId eq 'admin') ? '/qna/addQnaAnswer' : '/qna/updateQnaView'}" />
            <form action="${formAction}" method="post">

                <input type="hidden" name="qnaNo" value="${qnaGetData.qnaNo}" />
                <input type="hidden" name="isQnaAnswered" value="${qnaGetData.isQnaAnswered}" />

                <div class="mb-3">

                    <input type="hidden" name="qnaTitle" value="${qnaGetData.qnaTitle}" />
                    ${qnaGetData.qnaTitle}

                    <input type="hidden" name="qnaCategory" value="${qnaGetData.qnaCategory}" />

                    <c:choose>
                        <c:when test="${qnaGetData.qnaCategory == 0}">계정문의</c:when>
                        <c:when test="${qnaGetData.qnaCategory == 1}">기타문의</c:when>
                        <c:when test="${qnaGetData.qnaCategory == 2}">여행플랜</c:when>
                        <c:when test="${qnaGetData.qnaCategory == 3}">채팅</c:when>
                        <c:when test="${qnaGetData.qnaCategory == 4}">메모</c:when>
                        <c:when test="${qnaGetData.qnaCategory == 5}">후기</c:when>
                    </c:choose>

                </div>

                <br>

                <div class="mb-3">

                    <input type="hidden" name="qnaContents" value="${qnaGetData.qnaContents}" />
                    ${qnaGetData.qnaContents}

                </div>

                <br>

                <c:if test="${sessionScope.user.userId ne 'admin' && qnaGetData.qnaAnswerContents != null}">

                    <div class="mb-3">

                        ${qnaGetData.qnaAnswerContents}

                    </div>

                </c:if>

                <c:if test="${sessionScope.user.userId eq 'admin' }">

                    <div class="mb-3">

                        <textarea name="qnaAnswerContents" id="qnaAnswerContents" class="form-control">${qnaGetData.qnaAnswerContents}</textarea>

                    </div>

                    <br>

                    <div>
                        <button id="addQnaAnswer" type="submit" class="btn btn-primary">응답 등록</button>
                    </div>

                </c:if>

                <c:if test="${sessionScope.user.userId ne 'admin' && not empty sessionScope.user.userId && empty qnaGetData.qnaAnswerContents && sessionScope.user.userId eq qnaGetData.qnaAuthor}">

                    <div>
                        <button id="updateQnaView" type="submit" class="btn btn-primary">질문 수정</button>
                    </div>

                </c:if>

                <c:if test="${sessionScope.user.userId eq 'admin' || not empty sessionScope.user.userId && empty qnaGetData.qnaAnswerContents && sessionScope.user.userId eq qnaGetData.qnaAuthor}">

                    <br>

                    <div>
                        <button id="deleteQna" type="button" class="btn btn-danger">삭제하기</button>
                    </div>

                </c:if>

                <br>

                <div>
                    <button id="getQnaList" type="button" class="btn btn-secondary">목록 보기</button>
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
                $('#addQnaAnswer').on('click', function() {

                    if ($('#qnaAnswerContents').val().trim() === '') {

                        alert('답변 내용을 입력해주세요.');
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

        </script>

    </body>

</html>