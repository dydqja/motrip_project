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


        //여행플랜리스트
        $(function() {
                $("button[id='tripPlanList']").on("click", function() {
                    window.location.href = "/tripPlan/tripPlanList";
                });
            });


         //공지사
         $(function() {
                   //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                   $("a:contains('공지사항')").on("click" , function() {

                       self.location = "/notice/getNoticeList"
                   });
        });


    </script>
</head>
<body>
<h1>MoTrip index</h1>

    <div>
        <button id="login">로그인/회원가입</button>
    </div>

    <button type="button" id="tripPlanList">여행플랜 목록이동</button>

    <div>
        <a href="#">
            <h2>공지사항</h2>
        </a>
    </div>


</body>
</html>