<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML>

<html lang="ko">

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>공지사항 생성</title>

        <%--CSS START--%>
        <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
              integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
        <style>

            .selector-for-some-widget {
                box-sizing: content-box;
            }

        </style>
        <%--CSS END--%>

    </head>

    <body>

        <h1>공지사항 생성</h1>

        <br>
        <br>
        <br>


        <c:set var="formAction" value="${(noticeTitle != null && noticeContents != null) ? '/notice/updateNotice' : '/notice/addNotice'}" />
        <form action="${formAction}" method="post">

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
                <input type="submit" value="등록">
            </div>

        </form>

        <%--Bootstrap--%>
        <script src="http://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

        <%-- Jquery --%>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script type="text/javascript">

        $(function() {

            // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("form").submit(function(e) {

                var noticeTitle = $("#noticeTitle").val();
                var noticeContents = $("#noticeContents").val();

                if (!noticeTitle) {

                    e.preventDefault();

                    alert("제목을 입력해주세요.");

                    $("#noticeTitle").focus();

                } else if (!noticeContents) {

                    e.preventDefault();

                    alert("내용을 입력해주세요.");

                    $("#noticeTitle").focus();
                }
            });
        });

    </script>
</body>
</html>