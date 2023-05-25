<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML>

<html lang="ko">

    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>공지 상세 조회</title>

        <%--CSS START--%>
        <style>

            .selector-for-some-widget {
                box-sizing: content-box;
            }

        </style>
        <%--CSS END--%>

    </head>

    <body>

        <h1>공지사항</h1>

        <br>
        <br>
        <br>

        <form action="/notice/addNotice" method="post">

            <div>

                <input type="text" name="noticeTitle" id="noticeTitle" value="${noticeGetData.noticeTitle}">

                <select name="isNoticeImportant">
                    <option value="0">안중요</option>
                    <option value="1">중요</option>
                </select>

            </div>

            <br>

            <div>
                <textarea name="noticeContents" id="noticeContents">${noticeGetData.noticeContents}</textarea>
            </div>

            <br>

            <div>
                <input type="submit" id="addNotice" value="등록">
            </div>

        </form>

    <%-- Jquery --%>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">

        $(function() {
            // DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("form").on("#addNotice", function(e) {
                var noticeTitle = $("#noticeTitle").val();
                var noticeContents = $("#noticeContents").val();

                if (!noticeTitle) {
                    e.preventDefault();
                    $("#noticeTitle").focus();
                    alert("제목을 입력해주세요.");
                } else if (!noticeContents) {
                    e.preventDefault();
                    $("#noticeContents").focus();
                    alert("내용을 입력해주세요.");
                }
            });
        });

    </script>
</body>
</html>