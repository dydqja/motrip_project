<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>

<head>
    <title>모여행</title>
</head>

<body>

<h1>모여행</h1>

<div>
    <a href="#">
        <h2>공지사항</h2>
    </a>
</div>
<div>
    <a href="#">
        <h2>질의응답</h2>
    </a>
</div>

<%--Jquery--%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

    $(function() {

        //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
        $("a:contains('공지사항')").on("click" , function() {

            self.location = "/notice/getNoticeList"
        });
    });

</script>

</body>

</html>