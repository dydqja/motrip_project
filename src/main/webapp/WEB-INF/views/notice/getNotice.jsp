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

        <form action="/notice/updateNoticeView" method="post">

            <div>
                ${noticeGetData.noticeTitle}
                ${noticeGetData.isNoticeImportant}
            </div>

            <br>

            <div>
                ${noticeGetData.noticeContents}
            </div>

            <br>

            <div>
                <input type="submit" value="수정" />
            </div>

            <br>

            <div>
                <button id="deleteNotice">삭제</button>
            </div>

        </form>

        <%--Jquery--%>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script type="text/javascript">


        </script>
    </body>
</html>
