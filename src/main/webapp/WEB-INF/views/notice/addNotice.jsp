<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>공지사항 등록</title>

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