<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML>

<html lang="ko">

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>공지사항 등록</title>

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

        <h1>공지사항 등록</h1>

        <br>
        <br>
        <br>

        <c:set var="formAction" value="${(noticeTitle == null && noticeContents == null) ? '/notice/addNotice' : '/notice/updateNotice'}" />

        <form action="${formAction}" method="post">

            <input type="hidden" name="noticeAuthor" value="${sessionScope.user.userId}" />

            <c:if test="${noticeNo != null}">

                <input type="hidden" name="noticeNo" value="${noticeNo}" />

            </c:if>

            <div>

                <input type="text" name="noticeTitle" id="noticeTitle" value="${noticeTitle}">

                <select name="isNoticeImportant">

                    <option value="0" ${isNoticeImportant == 0 ? 'selected' : ''}>비중요</option>
                    <option value="1" ${isNoticeImportant == 1 ? 'selected' : ''}>중요</option>

                </select>

            </div>

            <br>

            <div>
                <textarea name="noticeContents" id="noticeContents">${noticeContents}</textarea>
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

        <%-- Bootstrap --%>
        <script src="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <%-- Jquery --%>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script type="text/javascript">

            $(function() {

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