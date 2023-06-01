<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML>

<html lang="ko">

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>공지사항 상세</title>

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

        <h1>공지사항 상세</h1>

        <br>
        <br>
        <br>

        <form action="/notice/updateNoticeView" method="post">

            <input type="hidden" name="noticeNo" value="${noticeGetData.noticeNo}" />

            <div>
                <input type="hidden" name="noticeTitle" value="${noticeGetData.noticeTitle}" />
                ${noticeGetData.noticeTitle}

                <input type="hidden" name="isNoticeImportant" value="${noticeGetData.isNoticeImportant}" />
                <c:if test="${noticeGetData.isNoticeImportant == 1}">
                    중요
                </c:if>
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

        <%-- Bootstrap --%>
        <script src="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <%-- Jquery --%>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
