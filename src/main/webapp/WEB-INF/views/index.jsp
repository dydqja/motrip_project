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

                 $("button[id='addReview']").on("click", function() {
                     window.location.href = "/review/addReviewView";
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

    <div>
        <p>
            이미지 테스트용
            이것은 프로젝트 폴더 내부의 이미지를 불러오는 것입니다.
            <img src="images/vpvp.jpg" width="100" height="100">
            이것은 업로드되는 이미지를 불러오는 것입니다.
            <img src="images/mountpoint/pika.jpg" width="100" height="100">
        </p>
    </div>

    <div>
        <button id="addReview">후기작성</button>
    </div>


</body>
</html>