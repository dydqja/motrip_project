<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <link rel="icon" type="image/png" href="/assets/img/favicon.png">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
    <%--    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">--%>
    <%--    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">--%>

    <script src="https://kit.fontawesome.com/b2ece947c7.js" crossorigin="anonymous"></script>






    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }
        .fa-solid,
        .fa-regular,
        .icon-setting,
        .icon-heart {
            font-size: 20px;
            margin-left: 1rem;
        }

        .blacklist-button {
            /* 버튼의 너비와 높이 설정 */
            width: 50px;
            height: 25px;
            /* 버튼 배경색을 검정색으로 설정 */
            background-color: black;
            /* 버튼의 글자 색상을 흰색으로 설정 */
            color: white;
            /* 글자 크기를 조절 */
            font-size: 10px;
            /* 버튼의 패딩 (내부 여백)을 설정 */
            padding: 2px 4px;
            /* 버튼의 테두리를 둥글게 만듭니다 */
            border-radius: 5px;
            /* 버튼 테두리 색상 */
            border: 1px solid white;
            /* 커서를 올렸을 때의 스타일 */
            transition: background-color 0.5s, color 0.5s;
        }

        .secession-button {
            /* 버튼의 너비와 높이 설정 */
            width: 50px;
            height: 25px;
            /* 버튼 배경색을 검정색으로 설정 */
            background-color: #ff4444;
            /* 버튼의 글자 색상을 흰색으로 설정 */
            color: white;
            /* 글자 크기를 조절 */
            font-size: 10px;
            /* 버튼의 패딩 (내부 여백)을 설정 */
            padding: 2px 4px;
            /* 버튼의 테두리를 둥글게 만듭니다 */
            border-radius: 5px;
            /* 버튼 테두리 색상 */
            border: 1px solid white;
            /* 커서를 올렸을 때의 스타일 */
            transition: background-color 0.5s, color 0.5s;
        }

        .blacklist-button:hover {
            /* 커서를 올렸을 때 배경색과 글자색을 바꾸어 주는 부분 */
            background-color: white;
            color: black;
        }

        .secession-button:hover {
            /* 커서를 올렸을 때 배경색과 글자색을 바꾸어 주는 부분 */
            background-color: #cc0000;
        }

        .btn:hover {
            opacity: 1 !important;
        }

        #likeUser:disabled img,
        #likeUserCancle:disabled img,
        #disLikeUser:disabled img,
        #disLikeUserCancle:disabled img {
            background-color: transparent;
        }

        .box {
            flex: 1;
        }

        .profile-bio p {
            width: 33.33%; /* div 요소의 1/3 크기 */
        }

        .update-user-icon {
            font-size: 20px;
            margin-left: 1rem;
        }

        :root {
            font-size: 10px;
        }

        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        body {
            font-family: "Open Sans", Arial, sans-serif;
            min-height: 100vh;
            background-color: #fafafa;
            color: #262626;
            padding-bottom: 3rem;
        }

        img {
            display: block;
            opacity: 1;
        }

        .container {
            max-width: 93.5rem;
            margin-right: auto;
            margin-left: 0;
            padding: 0 2rem;
        }

        .container .container-left {
            margin-left: 2rem;
        }

        .btn {
            opacity: 1;
            /*display: block; */
            display: inline-block;
            font: inherit;
            background: none;
            border: none;
            color: inherit;
            padding: 0;
            cursor: pointer;
        }

        .btn:focus {
            outline:0.5rem auto #000000;
        }

        .visually-hidden {
            position: absolute !important;
            height: 1px;
            width: 1px;
            overflow: hidden;
            clip: rect(1px, 1px, 1px, 1px);
        }

        /* Profile Section */

        .profile {
            padding: 5rem 0;
        }

        .profile::after {
            content: "";
            display: block;
            clear: both;
        }

        .profile-image {
            float: left;
            width: calc(33.333% - 1rem);
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 3rem;
        }

        .profile-image img {
            border-radius: 50%;
        }

        .profile-user-settings,
        .profile-stats,
        .profile-bio {
            float: left;
            width: calc(66.666% - 2rem);
        }

        .profile-user-settings {
            margin-top: 1.1rem;
        }

        .profile-user-name {
            display: inline-block;
            /*font-size: 3.2rem;*/
            font-weight: 300;
        }

        .nickname1,
        .nickname2 {
            font-size: 3.2rem;
            font-weight: 300;
        }

        .welcome-msg {
            font-size: 1.6rem;
            display: flex;
        }

        .profile-edit-btn {
            font-size: 1.4rem;
            line-height: 1.8;
            border: 0.1rem solid #dbdbdb;
            border-radius: 0.3rem;
            padding: 0 2.4rem;
            margin-left: 2rem;
        }

        .profile-settings-btn {
            font-size: 2rem;
            margin-left: 1rem;
        }

        .profile-stats {
            margin-top: 2.3rem;
        }

        .profile-stats li {
            display: inline-block;
            font-size: 1.6rem;
            line-height: 1.5;
            margin-right: 4rem;
            cursor: pointer;
        }

        .profile-stats li:last-of-type {
            margin-right: 0;
        }

        /*.profile-bio {*/
        /*    font-size: 1.6rem;*/
        /*    font-weight: 400;*/
        /*    line-height: 1.5;*/
        /*    margin-top: 2.3rem;*/
        /*    display: flex; !* 좋아요 영역 추가 *!*/
        /*} ---- 원래 css */

        .profile-bio {
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-template-rows: 1fr 1fr;
            grid-template-areas:
                "box1 box2"
                "box3 box3";
            font-size: 1.6rem;
            font-weight: 400;
            line-height: 1.5;
            margin-top: 2.3rem;
        }


        .profile-real-name,
        .profile-stat-count,
        .profile-edit-btn {
            font-weight: 600;
        }

        /* Gallery Section */

        .gallery {
            display: flex;
            flex-wrap: wrap;
            margin: -1rem -1rem;
            padding-bottom: 3rem;
        }

        .gallery-item {
            position: relative;
            flex: 1 0 22rem;
            margin: 1rem;
            color: #fff;
            cursor: pointer;
        }

        .gallery-item:hover .gallery-item-info,
        .gallery-item:focus .gallery-item-info {
            display: flex;
            justify-content: center;
            align-items: center;
            position: absolute;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.3);
        }

        .gallery-item-info {
            display: none;
        }

        .gallery-item-info li {
            display: inline-block;
            font-size: 1.7rem;
            font-weight: 600;
        }

        .gallery-item-likes {
            margin-right: 2.2rem;
        }

        .gallery-item-type {
            position: absolute;
            top: 1rem;
            right: 1rem;
            font-size: 2.5rem;
            text-shadow: 0.2rem 0.2rem 0.2rem rgba(0, 0, 0, 0.1);
        }

        .fa-clone,
        .fa-comment {
            transform: rotateY(180deg);
        }

        .gallery-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Loader */

        .loader {
            width: 5rem;
            height: 5rem;
            border: 0.6rem solid #999;
            border-bottom-color: transparent;
            border-radius: 50%;
            margin: 0 auto;
            animation: loader 500ms linear infinite;
        }

        /* Media Query */

        @media screen and (max-width: 40rem) {
            .profile {
                display: flex;
                flex-wrap: wrap;
                padding: 4rem 0;
            }

            .profile::after {
                display: none;
            }

            .profile-image,
            .profile-user-settings,
            .profile-bio,
            .profile-stats {
                float: none;
                width: auto;
            }

            .profile-image img {
                width: 7.7rem;
            }

            .profile-user-settings {
                flex-basis: calc(100% - 10.7rem);
                display: flex;
                flex-wrap: wrap;
                margin-top: 1rem;
            }

            .profile-user-name {
                font-size: 2.2rem;
            }

            .profile-edit-btn {
                order: 1;
                padding: 0;
                text-align: center;
                margin-top: 1rem;
            }

            .profile-edit-btn {
                margin-left: 0;
            }

            .profile-bio {
                font-size: 1.4rem;
                margin-top: 1.5rem;
            }

            .profile-edit-btn,
            .profile-bio,
            .profile-stats {
                flex-basis: 100%;
            }

            .profile-stats {
                order: 1;
                margin-top: 1.5rem;
            }

            .profile-stats ul {
                display: flex;
                text-align: center;
                padding: 1.2rem 0;
                border-top: 0.1rem solid #dadada;
                border-bottom: 0.1rem solid #dadada;
            }

            .profile-stats li {
                font-size: 1.4rem;
                flex: 1;
                margin: 0;
            }

            .profile-stat-count {
                display: block;
            }
        }

        /* Spinner Animation */

        @keyframes loader {
            to {
                transform: rotate(360deg);
            }
        }

        /*

        The following code will only run if your browser supports CSS grid.

        Remove or comment-out the code block below to see how the browser will fall-back to flexbox & floated styling.

        */

        @supports (display: grid) {
            .profile {
                display: grid;
                grid-template-columns: 1fr 2fr;
                grid-template-rows: repeat(3, auto);
                grid-column-gap: 3rem;
                align-items: center;
            }

            .profile-image {
                grid-row: 1 / 3;
            }

            .gallery {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(22rem, 1fr));
                grid-gap: 2rem;
            }

            .profile-image,
            .profile-user-settings,
            .profile-stats,
            .profile-bio,
            .gallery-item,
            .gallery {
                width: auto;
                margin: 0;
            }

            @media (max-width: 40rem) {
                .profile {
                    grid-template-columns: auto 1fr;
                    grid-row-gap: 1.5rem;
                }

                .profile-image {
                    grid-row: 1 / 2;
                }

                .profile-user-settings {
                    display: grid;
                    grid-template-columns: auto 1fr;
                    grid-gap: 1rem;
                }

                .profile-edit-btn,
                .profile-bio {
                    grid-column: 1 / -1;
                }
                .with-icon,
                .profile-stats {
                    grid-row: 2 / 4;
                }

                .profile-user-settings,
                .profile-edit-btn,
                .profile-settings-btn,
                .profile-bio,
                .profile-stats {
                    margin: 0;
                }
            }
        }

        @font-face {
            font-family: 'Material Icons';
            font-style: normal;
            font-weight: 400;
            src: url(https://example.com/MaterialIcons-Regular.eot); /* For IE6-8 */
            src: local('Material Icons'),
            local('MaterialIcons-Regular'),
            url(https://example.com/MaterialIcons-Regular.woff2) format('woff2'),
            url(https://example.com/MaterialIcons-Regular.woff) format('woff'),
            url(https://example.com/MaterialIcons-Regular.ttf) format('truetype');
        }

        .material-icons {
            font-family: 'Material Icons';
            font-weight: normal;
            font-style: normal;
            font-size: 24px;  /* Preferred icon size */
            display: inline-block;
            line-height: 1;
            text-transform: none;
            letter-spacing: normal;
            word-wrap: normal;
            white-space: nowrap;
            direction: ltr;

            /* Support for all WebKit browsers. */
            -webkit-font-smoothing: antialiased;
            /* Support for Safari and Chrome. */
            text-rendering: optimizeLegibility;

            /* Support for Firefox. */
            -moz-osx-font-smoothing: grayscale;

            /* Support for IE. */
            font-feature-settings: 'liga';
        }

        .welcome-row {
            display: flex;
            align-items: center; /* 이미지와 텍스트를 중앙정렬합니다. */
            gap: 10px; /* 요소들 사이에 간격을 줍니다. */
        }

    </style>




</head>

<body>

<%--<div class="page-img" style="background-image: url('/images/user/getUserTop.jpg');">--%>

<%--<header class="nav-menu fixed">--%>
<%--<%@ include file="/WEB-INF/views/layout/header.jsp" %>--%>
<%--</header>--%>


<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">



    <div class="page-header">
        <h3  style="background-color: #558B2F; color: #F5F1E3;">profile</h3>
    </div>




    <div class="profile">

        <div class="profile-image">

            <img src="/images/user/khunam.png" style="width: 200px; height: 200px;" alt="">




        </div>

        <div class="profile-user-settings" style="display: inline-block; align-items: center;">

            <div class="welcome-row">
                <c:if test="${sessionScope.user.userId eq getUser.userId}" >
                    <span class="nickname1" id="nickname1">${getUser.nickname}</span>
                    <span class="welcome-msg">님, 환영합니다!
                        <c:if test="${getUser.gender eq 'M'}">
                            <img class="text-right get-user-male" style="max-width: 25px; max-height: 25px; margin: 0;" src="/images/male.png">
                        </c:if>
                        <c:if test="${getUser.gender eq 'F'}">
                            <img class="text-right get-user-female" style="max-width: 25px; max-height: 25px; margin: 0;" src="/images/female.png">
                        </c:if>
                    </span>
                </c:if>
                <c:if test="${sessionScope.user.userId ne getUser.userId}" >
                    <span class="nickname2" id="nickname2">${getUser.nickname}</span>
                    <span class="welcome-msg">님의 회원정보입니다.
                        <c:if test="${getUser.gender eq 'M'}">
                            <img class="text-right get-user-male" style="max-width: 25px; max-height: 25px; margin: 0;" src="/images/male.png">
                        </c:if>
                        <c:if test="${getUser.gender eq 'F'}">
                            <img class="text-right get-user-female" style="max-width: 25px; max-height: 25px; margin: 0;" src="/images/female.png">
                        </c:if>
                    </span>
                </c:if>
            </div>

            <div id="imgs" style="opacity: 1; display: inline-block; font: inherit; background: none; border: none; color: inherit; padding: 0; cursor: pointer;">
                <%--                <span class="icon-heart" id="evaluateCount" style="opacity: 1;">${getUser.evaluateCount}</span>--%>
                <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px; cursor: default;" src="/images/redheart.png">
                <span style="cursor: default; font-size: 20px;" id="evaluateCount">${getUser.evaluateCount}</span>

                <c:if test="${sessionScope.user.userId eq getUser.userId}">
                    <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px; cursor: pointer;" src="/images/gear.png">
                </c:if>

                <c:if test="${sessionScope.user.userId ne getUser.userId}">
                    <%--                    <i class="fa-regular fa-circle-xmark" name="blacklist" id="blacklist" title="블랙리스트 등록" style="opacity: 1;"></i>--%>
                    <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px;" src="/images/userban.png" name="blacklist" id="blacklist" title="블랙리스트 등록">
                </c:if>

                <c:if test="${sessionScope.user.userId eq getUser.userId}">
                    <button type="button" class="blacklist-button" name="listBlack" id="listBlack">Blacklist</button>
                    <button type="button" class="secession-button" name="secessionUser" id="secessionUser">회원탈퇴</button>
                </c:if>

            </div>

        </div>

        <div class="profile-stats">
            <blockquote class="with-icon">
                <c:if test="${getUser.selfIntroPublic}">
                    <h3 id="selfIntro">${getUser.selfIntro}</h3>
                </c:if>
                <c:if test="${!getUser.selfIntroPublic}">
                    <h3 id="selfIntro">"비공개정보입니다."</h3>
                </c:if>
            </blockquote>
        </div>



        <div class="profile-bio">
            <%--            //style="display: flex; justify-content: flex-end"--%>
            <div class="box" style="grid-area: box1; display: flex; justify-content: flex-end">
                <c:if test="${sessionScope.user.userId ne getUser.userId}">
                    <button type="button" class="btn" name="likeUser" id="likeUser">
                        <img class="text-right" style="max-width: 25px; max-height: 25px;" src="/images/like.png">
                    </button>
                    <button type="button" class="btn" name="likeUserCancle" id="likeUserCancle" style=" background-color: transparent; outline: none; box-shadow: none; border: none;">
                        <img class="text-right" style="background-color: white; max-width: 25px; max-height: 25px;" src="/images/likePush.png">
                    </button>
                </c:if>
            </div>

            <div class="box" style="grid-area: box2;">
                <c:if test="${sessionScope.user.userId ne getUser.userId}">
                    <button type="button" class="btn" name="disLikeUser" id="disLikeUser">
                        <img class="text-right" style="max-width: 25px; max-height: 25px;" src="/images/dislike.png">
                    </button>
                    <button type="button" class="btn" name="disLikeUserCancle" id="disLikeUserCancle" style=" background-color: transparent; outline: none; box-shadow: none; border: none;">
                        <img class="text-right" style="background-color: white; max-width: 25px; max-height: 25px;" src="/images/dislikePush.png">
                    </button>
                </c:if>
            </div>

            <div class="box" style="grid-area: box3;">

            </div>



        </div>

    </div>





</div>


<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/vendor/jquery/dist/jquery.min.js"></script>
<script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
<script src="/vendor/jquery.ui.touch-punch.min.js"></script>
<script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
<script src="/vendor/owlcarousel/owl.carousel.min.js"></script>
<script src="/vendor/retina.min.js"></script>
<script src="/vendor/jquery.imageScroll.min.js"></script>
<script src="/assets/js/min/responsivetable.min.js"></script>
<script src="/assets/js/bootstrap-tabcollapse.js"></script>
<%--<script src="/assets/js/min/countnumbers.min.js"></script>--%>
<%--<script src="/assets/js/main.js"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="UTF-8"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>



<script type="text/javascript">


    //페이지가 로드될 시 실행되어 좋아요,싫어요 버튼 state 값을 가져온다.
    $(document).ready(function(){

        evaluateButtonState();

        if("${getUser.gender eq 'M'}") {
            $(".get-user-male").show()
            $(".get-user-female").hide()
        }else if("${getUser.gender eq 'F'}") {
            $(".get-user-female").show()
            $(".get-user-male").hide()
        }

        if("${sessionScope.user.userId}" != "${getUser.userId}") {
            blacklistState();
        }
    });

    function evaluateButtonState() {

        console.log("${sessionScope.user.userId}");
        console.log("${getUser.userId}");

        $.ajax({
            url: "/user/evaluateState",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                sessionUserId: "${sessionScope.user.userId}",
                getUserId: "${getUser.userId}"
            }),
            dataType: "text",
            success: function (response) {

                if (response == "0" || response == "") {
                    console.log("response 값 0이거나 null일 때 실행됨");
                    $("#likeUserCancle").hide();
                    $("#disLikeUserCancle").hide();
                    $("#likeUser").show();
                    $("#dislikeUser").show();

                } else if (response == "1") {
                    console.log("response 값 1 일 때 실행됨");
                    $("#likeUser").hide();
                    $("#disLikeUserCancle").hide();
                    $('#disLikeUser').prop('disabled', true);
                    $("#likeUserCancle").show();

                } else {
                    console.log("response 값 -1 일 때 실행됨");
                    $("#likeUserCancle").hide();
                    $("#disLikeUser").hide();
                    $("#likeUser").prop('disabled', true);
                    $("#disLikeUserCancle").show();
                }
            },
            error: function (error) {
                alert("실패");
            }
        });
    }

    function blacklistState() {

        if("${sessionScope.user.userId}" != "${getUser.userId}") {

            console.log("${sessionScope.user.userId}");
            console.log("${getUser.userId}");

            $.ajax({
                url: "/user/blacklistState",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${getUser.userId}"
                }),
                dataType: "text",
                success: function (response) {

                    if (response == "${getUser.userId}") {
                        console.log("blacklist 값이 있을 때 실행됨  " +response);
                        $("#blacklist").attr('src','/images/userbancancle.png');
                        $("#blacklist").attr('title', '블랙리스트 취소');

                    } else {
                        console.log("blacklist  값이 없을 때 실행됨  " +response);
                        $("#blacklist").attr('src', '/images/userban.png');
                        $("#blacklist").attr('title', '블랙리스트 추가');
                    }
                },
                error: function (error) {
                    alert("실패");
                }
            });
        }
    }

    $(document).ready(function(){

        //좋아요취소 클릭이벤트
        $("#likeUserCancle").on("click" , function() {

            $.ajax({
                url: "/user/userEvaluateCancle",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${getUser.userId}"
                }),
                dataType: "text",
                success: function (response) {

                    $("#likeUserCancle").hide();
                    $("#likeUser").show();
                    $("#disLikeUser").prop('disabled', false).show();
                    $("#evaluateCount").text(response);

                    if(response == "") {
                        $("#evaluateCount").text("0");
                    }

                },
                error: function (error) {
                    alert("실패");
                }
            });
        });

        //좋아요 클릭이벤트
        $("#likeUser").on("click" , function() {

            $.ajax({
                url: "/user/addEvaluation",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    evaluaterId: "${sessionScope.user.userId}",
                    evaluatedUserId: "${getUser.userId}",
                    isScorePlus: 1
                }),
                dataType: "text",
                success: function (response) {

                    $("#likeUser").hide();
                    $("#likeUserCancle").show();
                    $("#disLikeUser").hide();
                    $("#disLikeUser").prop('disabled', true).show();
                    $("#evaluateCount").text(response);
                },
                error: function (error) {
                    alert("실패");
                }
            });
        });

        //싫어요 클릭이벤트
        $("#disLikeUser").on("click" , function() {

            $.ajax({
                url: "/user/addEvaluation",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    evaluaterId: "${sessionScope.user.userId}",
                    evaluatedUserId: "${getUser.userId}",
                    isScorePlus: -1
                }),
                dataType: "text",
                success: function (response) {

                    $("#disLikeUser").hide();
                    $("#disLikeUserCancle").show();
                    $("#likeUser").hide();
                    $("#likeUser").prop('disabled', true).show();
                    $("#evaluateCount").text(response);
                },
                error: function (error) {
                    alert("실패");
                }
            });
        });

        //싫어요취소 클릭이벤트
        $("#disLikeUserCancle").on("click" , function() {

            $.ajax({
                url: "/user/userEvaluateCancle",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${getUser.userId}"
                }),
                dataType: "text",
                success: function (response) {

                    $("#disLikeUserCancle").hide();
                    $("#disLikeUser").show();
                    $("#likeUser").prop('disabled', false).show();
                    $("#evaluateCount").text(response);

                    if(response == "") {
                        $("#evaluateCount").text("0");
                    }
                },
                error: function (error) {
                    alert("실패");
                }
            });
        });

        //블랙리스트 추가 클릭이벤트
        $("#blacklist").on("click" , function() {
            if($(this).attr('src') === '/images/userban.png') {

                $.ajax({
                    url: "/user/addBlacklist",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        evaluaterId: "${sessionScope.user.userId}",
                        blacklistedUserId: "${getUser.userId}"
                    }),
                    dataType: "text",
                    success: function (response) {

                        if(response == "") {
                            $("#blacklist").attr('src', '/images/userbancancle.png');
                            $("#blacklist").attr('title', '블랙리스트 취소');

                        }
                    },
                    error: function (error) {
                        alert("실패");
                    }
                });
            } else if($(this).attr('src') === '/images/userbancancle.png') {

                $.ajax({
                    url: "/user/deleteBlacklist",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        evaluaterId: "${sessionScope.user.userId}",
                        blacklistedUserId: "${getUser.userId}"
                    }),
                    dataType: "text",
                    success: function (response) {

                        $("#blacklist").attr('src', '/images/userban.png');
                        $("#blacklist").attr('title', '블랙리스트 등록');
                    },
                    error: function (error) {
                        alert("실패");
                    }
                });

            }
        });
    });

    //블랙리스트보기
    $( function() {

        $("#listBlack").on("click" , function() {
            console.log("블랙리스트목록보기 클릭");

            $('#listBlackModal').modal('show');
            console.log("'#listBlackModal' 모달이 표시되었어야 합니다.");
        });
    });

    //회원정보수정
    $( function() {

        $('#imgs img[src="/images/gear.png"]').on("click" , function() {

            $('#updateUserModal').modal('show');
        });
    });

    //회원탈퇴확인
    $( function() {

        $("#secessionUser").on("click", function () {

            Swal.fire({
                title: '정말 탈퇴하시겠습니까?',
                text: "이 동작은 되돌릴 수 없습니다!",
                icon: 'warning',
                showCancelButton: true,  // 취소 버튼 활성화
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '네, 탈퇴하겠습니다.',
                cancelButtonText: '아니오, 취소합니다.'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 사용자가 확인을 눌렀을 때의 동작
                    console.log('탈퇴를 확인하였습니다.')
                    self.location.href = "/user/secessionUser";
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    // 사용자가 취소를 눌렀을 때의 동작
                    console.log('탈퇴를 취소하였습니다.')
                }
            })
        });
    });



</script>

<!-- 회원정보수정 모달 인클루드 -->
<jsp:include page="updateUserModal.jsp"/>

<!-- 블랙리스트 모달 인클루드 -->
<jsp:include page="listBlackModal.jsp"/>

<!-- 회원탈퇴확인 모달 인클루드 -->
<jsp:include page="secessionUserModal.jsp"/>


</body>

</html>