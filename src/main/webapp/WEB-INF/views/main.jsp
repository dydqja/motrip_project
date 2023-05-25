<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <title>Motrip</title>
    <script type="text/javascript">

        // 로그인 화면이동
        // $( function() {
        //     $('#login').on("click" , function() {
        //         self.location = "/user/login"
        //     });
        // });

        $(function() {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("a:contains('공지사항')").on("click" , function() {

                self.location = "/notice/getNoticeList"
            });

            $("a:contains('질의응답')").on("click" , function() {

                self.location = "/qna/getQnaList"
            });
        });






    </script>
</head>
<body>

    <div>
        <h1>여긴 메인페이지다.</h1>
    </div>

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




</body>
</html>