<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML>

<html lang="ko">

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>질의응답 상세</title>

        <%-- CSS START --%>
        <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
              integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

        <style>

            .selector-for-some-widget {
                box-sizing: content-box;
            }

        </style>
        <%-- CSS END --%>

    </head>

    <body>

        <h1>질의응답 상세</h1>

        <br>
        <br>
        <br>

        <c:set var="formAction" value="${(sessionScope.user.userId eq 'admin') ? '/qna/addQnaAnswer' : '/qna/updateQnaView'}" />
        <form action="${formAction}" method="post">

            <input type="hidden" name="qnaNo" value="${qnaGetData.qnaNo}" />
            <input type="hidden" name="isQnaAnswered" value="${qnaGetData.isQnaAnswered}" />

            <div>
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

            <div>
                <input type="hidden" name="qnaContents" value="${qnaGetData.qnaContents}" />
                ${qnaGetData.qnaContents}
            </div>

            <br>

            <c:if test="${sessionScope.user.userId ne 'admin' && qnaGetData.qnaAnswerContents != null}">

                <div>
                    ${qnaGetData.qnaAnswerContents}
                </div>

            </c:if>

            <c:if test="${sessionScope.user.userId eq 'admin' }">

                <div>
                    <textarea name="qnaAnswerContents" id="qnaAnswerContents">${qnaGetData.qnaAnswerContents}</textarea>
                </div>

                <br>

                <div>
                    <button id="addQnaAnswer" type="submit">응답 등록</button>
                </div>

            </c:if>

            <c:if test="${sessionScope.user.userId ne 'admin' && not empty sessionScope.user.userId && empty qnaGetData.qnaAnswerContents && sessionScope.user.userId eq qnaGetData.qnaAuthor}">

                <div>
                    <button id="updateQnaView" type="submit">질문 수정</button>
                </div>



            </c:if>

            <c:if test="${sessionScope.user.userId eq 'admin' || not empty sessionScope.user.userId && empty qnaGetData.qnaAnswerContents && sessionScope.user.userId eq qnaGetData.qnaAuthor}">

                <br>

                <div>
                    <button id="deleteQna" type="button">삭제하기</button>
                </div>

            </c:if>

            <br>

            <div>
                <button id="getQnaList" type="button">목록 보기</button>
            </div>

        </form>

        <%-- Bootstrap --%>
        <script src="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <%-- Jquery --%>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
