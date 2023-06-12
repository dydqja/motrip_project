<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="EUC-KR"%>
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
            /* ��ư�� �ʺ�� ���� ���� */
            width: 50px;
            height: 25px;
            /* ��ư ������ ���������� ���� */
            background-color: black;
            /* ��ư�� ���� ������ ������� ���� */
            color: white;
            /* ���� ũ�⸦ ���� */
            font-size: 10px;
            /* ��ư�� �е� (���� ����)�� ���� */
            padding: 2px 4px;
            /* ��ư�� �׵θ��� �ձ۰� ����ϴ� */
            border-radius: 5px;
            /* ��ư �׵θ� ���� */
            border: 1px solid white;
            /* Ŀ���� �÷��� ���� ��Ÿ�� */
            transition: background-color 0.5s, color 0.5s;
        }

        .blacklist-button:hover {
            /* Ŀ���� �÷��� �� ������ ���ڻ��� �ٲپ� �ִ� �κ� */
            background-color: white;
            color: black;
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
            width: 33.33%; /* div ����� 1/3 ũ�� */
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
            font-weight: 300;
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
        /*    display: flex; !* ���ƿ� ���� �߰� *!*/
        /*} ---- ���� css */

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
    </style>




</head>

<body>

<%--<div class="page-img" style="background-image: url('/images/user/getUserTop.jpg');">--%>

<%--<header class="nav-menu fixed">--%>
<%--<%@ include file="/WEB-INF/views/layout/header.jsp" %>--%>
<%--</header>--%>


<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
<div class="container">



    <div class="page-header">
        <h3  style="background-color: #558B2F; color: #F5F1E3;">profile</h3>
    </div>




    <div class="profile">

        <div class="profile-image">

            <img src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&amp;h=152&amp;fit=crop&amp;crop=faces" alt="">


                <img class="text-right get-user-male" style="max-width: 25px; max-height: 25px;" src="/images/male.png">

                <img class="text-right get-user-female" style="max-width: 25px; max-height: 25px;" src="/images/female.png">


        </div>

        <div class="profile-user-settings">

            <div class="profile-user-name">
                <c:if test="${sessionScope.user.userId eq getUser.userId}" >
                    <span class="nickname1" id="nickname1">${getUser.nickname}</span>
                    <span class="welcome-msg">��, ȯ���մϴ�!</span>
                </c:if>
                <c:if test="${sessionScope.user.userId ne getUser.userId}" >
                    <span class="nickname2" id="nickname2">${getUser.nickname}</span>
                    <span class="welcome-msg">���� ȸ�������Դϴ�.</span>
                </c:if>
            </div>

            <div style="opacity: 1; display: inline-block; font: inherit; background: none; border: none; color: inherit; padding: 0; cursor: pointer;">
<%--                <span class="icon-heart" id="evaluateCount" style="opacity: 1;">${getUser.evaluateCount}</span>--%>
                    <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px; cursor: default;" src="/images/redheart.png">
                    <span style="cursor: default; font-size: 20px;" id="evaluateCount">${getUser.evaluateCount}</span>

                <c:if test="${sessionScope.user.userId eq getUser.userId}">
                    <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px; cursor: default;" src="/images/gear.png">
                </c:if>

                <c:if test="${sessionScope.user.userId ne getUser.userId}">
<%--                    <i class="fa-regular fa-circle-xmark" name="blacklist" id="blacklist" title="������Ʈ ���" style="opacity: 1;"></i>--%>
                    <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px;" src="/images/userban.png" name="blacklist" id="blacklist" title="������Ʈ ���">
                </c:if>

                <c:if test="${sessionScope.user.userId eq getUser.userId}">
                <button type="button" class="blacklist-button" name="listBlack" id="listBlack">Blacklist</button>
                </c:if>

            </div>

        </div>

        <div class="profile-stats">
            <blockquote class="with-icon">
                <h3>${getUser.selfIntro}</h3>
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


<script type="text/javascript">


    //�������� �ε�� �� ����Ǿ� ���ƿ�,�Ⱦ�� ��ư state ���� �����´�.
    $(document).ready(function(){

        evaluateButtonState();

        if("${getUser.gender eq 'M'}") {
            $(".get-user-male").show()
            $(".get-user-female").hide()
        }else if("${getUser.gender eq 'M'}") {
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
                    console.log("response �� 0�̰ų� null�� �� �����");
                    $("#likeUserCancle").hide();
                    $("#disLikeUserCancle").hide();
                    $("#likeUser").show();
                    $("#dislikeUser").show();

                } else if (response == "1") {
                    console.log("response �� 1 �� �� �����");
                    $("#likeUser").hide();
                    $("#disLikeUserCancle").hide();
                    $('#disLikeUser').prop('disabled', true);
                    $("#likeUserCancle").show();

                } else {
                    console.log("response �� -1 �� �� �����");
                    $("#likeUserCancle").hide();
                    $("#disLikeUser").hide();
                    $("#likeUser").prop('disabled', true);
                    $("#disLikeUserCancle").show();
                }
            },
            error: function (error) {
                alert("����");
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
                        console.log("blacklist ���� ���� �� �����  " +response);
                        $("#blacklist").attr('src','/images/userbancancle.png');
                        $("#blacklist").attr('title', '������Ʈ ���');

                    } else {
                        console.log("blacklist  ���� ���� �� �����  " +response);
                        $("#blacklist").attr('src', '/images/userban.png');
                        $("#blacklist").attr('title', '������Ʈ �߰�');
                    }
                },
                error: function (error) {
                    alert("����");
                }
            });
        }
    }

    $(document).ready(function(){

        //���ƿ���� Ŭ���̺�Ʈ
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
                    alert("����");
                }
            });
        });

        //���ƿ� Ŭ���̺�Ʈ
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
                    alert("����");
                }
            });
        });

        //�Ⱦ�� Ŭ���̺�Ʈ
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
                    alert("����");
                }
            });
        });

        //�Ⱦ����� Ŭ���̺�Ʈ
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
                    alert("����");
                }
            });
        });

        //������Ʈ �߰� Ŭ���̺�Ʈ
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
                            $("#blacklist").attr('title', '������Ʈ ���');

                        }
                    },
                    error: function (error) {
                        alert("����");
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
                        $("#blacklist").attr('title', '������Ʈ ���');
                    },
                    error: function (error) {
                        alert("����");
                    }
                });

            }
        });
    });

    //������Ʈ����
    $( function() {

        $("#listBlack").on("click" , function() {
            console.log("������Ʈ��Ϻ��� Ŭ��");

            $('#listBlackModal').modal('show');
            console.log("'#listBlackModal' ����� ǥ�õǾ���� �մϴ�.");
        });
    });

    //ȸ����������
    $( function() {

        $("#updateUser").on("click" , function() {

            $('#updateUserModal').modal('show');
        });
    });

    //ȸ��Ż��Ȯ��
    $( function() {

        $("#secessionUser").on("click" , function() {

            $('#secessionUserModal').modal('show');
        });
    });



</script>

<!-- ȸ���������� ��� ��Ŭ��� -->
<jsp:include page="updateUserModal.jsp"/>

<!-- ������Ʈ ��� ��Ŭ��� -->
<jsp:include page="listBlackModal.jsp"/>

<!-- ȸ��Ż��Ȯ�� ��� ��Ŭ��� -->
<jsp:include page="secessionUserModal.jsp"/>


</body>

</html>