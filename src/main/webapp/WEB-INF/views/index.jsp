<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <title>Motrip에 오신걸 환영합니다.</title>
    <script type="text/javascript">

        // 로그인 화면이동
        $( function() {
            $('#login').on("click" , function() {
                self.location = "/user/login"
            });
        });






    </script>
</head>
<body>
<h1>MoTrip index</h1>

    <div>
        <button id="login">로그인/회원가입</button>
    </div>


</body>
</html>