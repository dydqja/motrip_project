<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="com.bit.motrip.domain.*"%>
<%--<%--%>
<%--    String username = request.getParameter("username");--%>
<%--    String chatRoomNo = request.getParameter("chatRoomNo");--%>
<%--%>--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <%--   <link--%>
    <%--      rel="stylesheet"--%>
    <%--      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css"--%>
    <%--      integrity="sha256-mmgLkCYLUQbXn0B1SRqzHar6dCnv9oZFPEC1g1cwlkk="--%>
    <%--      crossorigin="anonymous"--%>
    <%--    />--%>

    <link rel="stylesheet" href="/css/style.css">
<%--    <style>--%>
<%--        .nav-menu {--%>
<%--            border: 0;--%>
<%--            z-index: 999;--%>
<%--            position: relative;--%>
<%--        }--%>
<%--        .nav-menu .icon-bar {--%>
<%--            top: 0;--%>
<%--            background: #ffffff;--%>
<%--        }--%>
<%--        .nav-menu [class^='icon-'],--%>
<%--        .nav-menu .fa,--%>
<%--        .nav-menu .glyphicon {--%>
<%--            font-size: 30px;--%>
<%--            line-height: 1em;--%>
<%--            position: relative;--%>
<%--            top: 2px;--%>
<%--            color: #fff;--%>
<%--        }--%>
<%--        .nav-menu .badge {--%>
<%--            margin-left: -5px;--%>
<%--        }--%>
<%--        .nav-menu .navbar {--%>
<%--            border: 0;--%>
<%--            margin-bottom: 0px;--%>
<%--            background: #111111;--%>
<%--        }--%>
<%--        .nav-menu .navbar .navbar-brand {--%>
<%--            padding: 0;--%>
<%--            margin-left: 0px;--%>
<%--            position: relative;--%>
<%--            height: 120px;--%>
<%--            line-height: 120px;--%>
<%--            font-size: 1.8em;--%>
<%--            -webkit-transition: all 0.2s linear;--%>
<%--            -moz-transition: all 0.2s linear;--%>
<%--            -ms-transition: all 0.2s linear;--%>
<%--            -o-transition: all 0.2s linear;--%>
<%--            transition: all 0.2s linear;--%>
<%--            vertical-align: middle;--%>
<%--        }--%>
<%--        .nav-menu .navbar .navbar-brand > img {--%>
<%--            display: inline-block;--%>
<%--        }--%>
<%--        .nav-menu .navbar.transparent {--%>
<%--            background: transparent;--%>
<%--        }--%>
<%--        .nav-menu .nav {--%>
<%--            float: right;--%>
<%--            font-family: 'Open Sans', sans-serif;--%>
<%--        }--%>
<%--        .nav-menu .nav .nav-arrow {--%>
<%--            font-size: 10px;--%>
<%--            top: -1px;--%>
<%--            margin: 0 3px;--%>
<%--        }--%>
<%--        .nav-menu .nav ul {--%>
<%--            list-style: none;--%>
<%--            margin: 0px;--%>
<%--            padding: 0px;--%>
<%--        }--%>
<%--        .nav-menu .nav > li > a {--%>
<%--            height: 119px;--%>
<%--            line-height: 119px;--%>
<%--            font-size: 1.6rem;--%>
<%--            -webkit-transition: all 0.2s linear;--%>
<%--            -moz-transition: all 0.2s linear;--%>
<%--            -ms-transition: all 0.2s linear;--%>
<%--            -o-transition: all 0.2s linear;--%>
<%--            transition: all 0.2s linear;--%>
<%--            padding: 0 10px;--%>
<%--            border-radius: 0px;--%>
<%--            font-family: 'Open Sans', sans-serif;--%>
<%--            font-weight: normal;--%>
<%--            color: #fff;--%>
<%--        }--%>
<%--        .nav-menu .nav > li > a:focus,--%>
<%--        .nav-menu .nav > li > a:hover {--%>
<%--            border-bottom: 5px solid #4ada4a;--%>
<%--            background: transparent;--%>
<%--        }--%>
<%--        .nav-menu .nav > li.open > a,--%>
<%--        .nav-menu .nav > li.open > a.dropdown-toggle,--%>
<%--        .nav-menu .nav > li.open > a:focus,--%>
<%--        .nav-menu .nav > li.open > a:hover,--%>
<%--        .nav-menu .nav > li.open *[class^="icon"] {--%>
<%--            border-bottom: 5px solid #4ada4a;--%>
<%--            background: transparent;--%>
<%--        }--%>
<%--        .nav-menu .nav > li.open [class^='icon-'],--%>
<%--        .nav-menu .nav > li.open .fa,--%>
<%--        .nav-menu .nav > li.open .glyphicon {--%>
<%--            border-bottom: 0;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu {--%>
<%--            padding: 0;--%>
<%--            margin-top: -1px;--%>
<%--            border: none;--%>
<%--            background: #1e1e1e;--%>
<%--            color: #4ada4a;--%>
<%--            letter-spacing: .06em;--%>
<%--            font-size: .9em;--%>
<%--            box-shadow: none;--%>
<%--            border-radius: 0px;--%>
<%--            width: 300px;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu .nav-arrow {--%>
<%--            top: 0px;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li {--%>
<%--            border-bottom: 1px solid rgba(255, 255, 255, 0.05);--%>
<%--            position: relative;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li a {--%>
<%--            position: relative;--%>
<%--            display: block;--%>
<%--            white-space: normal !important;--%>
<%--            color: #fff;--%>
<%--            text-transform: none;--%>
<%--            padding: 8px 15px !important;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li a:hover {--%>
<%--            color: #4ada4a;--%>
<%--            background: transparent;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li:hover {--%>
<%--            background: #111111;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li:hover > ul {--%>
<%--            display: block;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li.open > a,--%>
<%--        .nav-menu .nav > li .dropdown-menu li.open > a:hover,--%>
<%--        .nav-menu .nav > li .dropdown-menu li.open > a:focus {--%>
<%--            background: none;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li.hor-line {--%>
<%--            margin-top: 5px;--%>
<%--            margin-bottom: 5px;--%>
<%--            position: relative;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li.hor-line:after {--%>
<%--            content: '';--%>
<%--            height: 2px;--%>
<%--            width: 20px;--%>
<%--            background: rgba(85, 139, 47, 0.3);--%>
<%--            position: absolute;--%>
<%--            bottom: 2px;--%>
<%--            left: 0;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li:last-child {--%>
<%--            border-bottom: 0px;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu li > ul {--%>
<%--            display: none;--%>
<%--            background: #111111;--%>
<%--            border-left: 1px solid rgba(255, 255, 255, 0.2);--%>
<%--            width: 330px;--%>
<%--            margin: 0px;--%>
<%--            margin-bottom: 15px;--%>
<%--            padding: 0px;--%>
<%--            list-style: none;--%>
<%--            position: absolute;--%>
<%--            top: 0px;--%>
<%--            left: 300px;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu img {--%>
<%--            width: 100%;--%>
<%--            margin-bottom: 15px;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu {--%>
<%--            list-style: none;--%>
<%--            width: 280px;--%>
<%--            position: absolute;--%>
<%--            right: 0;--%>
<%--            background: #1e1e1e;--%>
<%--            color: #ffffff;--%>
<%--            z-index: 99999999;--%>
<%--            padding: 0;--%>
<%--            margin: 0;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li {--%>
<%--            display: block;--%>
<%--            padding: 5px 10px;--%>
<%--            height: 70px;--%>
<%--            border-bottom: 1px solid rgba(255, 255, 255, 0.1);--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li:last-child {--%>
<%--            border-bottom: none;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li [class^='icon-'],--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li .fa,--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li .glyphicon {--%>
<%--            line-height: 120px;--%>
<%--            top: 0;--%>
<%--            -webkit-transition: all 0.2s linear;--%>
<%--            -moz-transition: all 0.2s linear;--%>
<%--            -ms-transition: all 0.2s linear;--%>
<%--            -o-transition: all 0.2s linear;--%>
<%--            transition: all 0.2s linear;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li [class^='icon-']:hover,--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li .fa:hover,--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li .glyphicon:hover {--%>
<%--            color: #1b6d85;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li img {--%>
<%--            height: 40px;--%>
<%--            width: 40px;--%>
<%--            margin-top: 10px;--%>
<%--            float: left;--%>
<%--            margin-bottom: 0;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li .text {--%>
<%--            margin-left: 55px;--%>
<%--            margin-right: 50px;--%>
<%--            margin-top: 15px;--%>
<%--            font-size: .9em;--%>
<%--            line-height: 1.2em;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li .delete {--%>
<%--            float: right;--%>
<%--            font-size: 16px;--%>
<%--            margin-top: 20px;--%>
<%--            cursor: pointer;--%>
<%--        }--%>
<%--        .nav-menu .nav > li .dropdown-menu.cart-menu li .delete:hover {--%>
<%--            color: #558B2F;--%>
<%--        }--%>
<%--        .nav-menu .nav > li.megamenu {--%>
<%--            position: static;--%>
<%--        }--%>
<%--        .nav-menu .nav > li.megamenu .dropdown-menu {--%>
<%--            padding: 15px 0 10px;--%>
<%--            width: 100%;--%>
<%--            right: 0;--%>
<%--            left: 0;--%>
<%--            border: none;--%>
<%--            border-radius: 0px;--%>
<%--        }--%>
<%--        .nav-menu .nav > li.megamenu .dropdown-menu ul {--%>
<%--            position: relative;--%>
<%--            left: 0;--%>
<%--            border-left: 0;--%>
<%--            background: none;--%>
<%--            width: 100%;--%>
<%--        }--%>
<%--        .nav-menu .nav > li.megamenu .dropdown-menu ul li {--%>
<%--            border-bottom: 0px;--%>
<%--        }--%>
<%--        .nav-menu .nav > li.megamenu .dropdown-menu ul a {--%>
<%--            padding: 3px 0 !important;--%>
<%--        }--%>
<%--        .nav-menu.fixed {--%>
<%--            width: 100%;--%>
<%--            border-bottom: 1px solid rgba(255, 255, 255, 0.1);--%>
<%--            position: fixed;--%>
<%--            top: 0px;--%>
<%--            z-index: 999;--%>
<%--        }--%>
<%--        .nav-menu.fixed + *:not(.stick-top) {--%>
<%--            margin-top: 120px;--%>
<%--        }--%>

<%--        .nav-boxed .navbar .navbar-brand {--%>
<%--            margin-left: 15px;--%>
<%--            padding-top: 35px;--%>
<%--        }--%>
<%--        @media screen and (max-width: 767px) {--%>
<%--            .nav-menu {--%>
<%--                height: 50px;--%>
<%--                border-bottom: 0px;--%>
<%--                height: auto;--%>
<%--            }--%>
<%--            .nav-menu .navbar-toggle {--%>
<%--                margin: 20px 5px;--%>
<%--            }--%>
<%--            .nav-menu .navbar > .container-fluid .navbar-brand {--%>
<%--                margin-top: 8px;--%>
<%--                margin-left: 0;--%>
<%--                padding: 0 15px;--%>
<%--                height: 50px;--%>
<%--                line-height: 50px;--%>
<%--                border-right: 0;--%>
<%--            }--%>
<%--            .nav-menu .nav {--%>
<%--                display: block;--%>
<%--                float: none;--%>
<%--                margin: 0;--%>
<%--                background: #111111;--%>
<%--            }--%>
<%--            .nav-menu .nav > li {--%>
<%--                border-bottom: 1px solid rgba(255, 255, 255, 0.05);--%>
<%--                /*infinity sub-nav*/--%>
<%--            }--%>
<%--            .nav-menu .nav > li a:hover,--%>
<%--            .nav-menu .nav > li a:focus,--%>
<%--            .nav-menu .nav > li.open a {--%>
<%--                border-bottom: 0 !important;--%>
<%--            }--%>
<%--            .nav-menu .nav > li > a {--%>
<%--                height: auto;--%>
<%--                line-height: 1;--%>
<%--                padding: 15px;--%>
<%--            }--%>
<%--            .nav-menu .nav > li.megamenu {--%>
<%--                position: relative;--%>
<%--                overflow: hidden;--%>
<%--            }--%>
<%--            .nav-menu .nav > li.megamenu .dropdown-menu ul {--%>
<%--                display: none;--%>
<%--            }--%>
<%--            .nav-menu .nav > li.megamenu .dropdown-menu .head {--%>
<%--                margin-bottom: 0;--%>
<%--                padding-bottom: 10px;--%>
<%--                font-size: 1em;--%>
<%--                line-height: 20px;--%>
<%--                cursor: pointer;--%>
<%--            }--%>
<%--            .nav-menu .nav > li.megamenu .dropdown-menu .head.last {--%>
<%--                border-bottom: none;--%>
<%--                margin-bottom: 0;--%>
<%--                padding-bottom: 0;--%>
<%--            }--%>
<%--            .nav-menu .nav > li.megamenu .dropdown-menu .open + ul {--%>
<%--                display: block;--%>
<%--            }--%>
<%--            .nav-menu .nav > li .dropdown-menu {--%>
<%--                width: auto;--%>
<%--            }--%>
<%--            .nav-menu .nav > li .dropdown-menu li:last-child {--%>
<%--                border-bottom: none;--%>
<%--            }--%>
<%--            .nav-menu .nav > li .dropdown-menu li ul {--%>
<%--                display: block;--%>
<%--                position: relative !important;--%>
<%--                box-shadow: none;--%>
<%--                margin-left: 0px;--%>
<%--                padding-left: 30px;--%>
<%--                width: auto;--%>
<%--                left: 0 !important;--%>
<%--                top: 0;--%>
<%--            }--%>
<%--            .nav-menu .nav > li .dropdown-menu li ul.show {--%>
<%--                display: block;--%>
<%--            }--%>
<%--            .nav-menu.fixed .navbar-toggle {--%>
<%--                margin: 15px;--%>
<%--            }--%>
<%--            .nav-menu.fixed .navbar-toggle .icon-bar {--%>
<%--                background-color: #1b6d85;--%>
<%--            }--%>
<%--            .nav-menu.fixed .nav > li > a {--%>
<%--                color: #fff;--%>
<%--            }--%>
<%--            .nav-menu.fixed .nav > li > a:focus {--%>
<%--                color: #fff;--%>
<%--            }--%>
<%--            .nav-menu.fixed .nav > li > a:hover {--%>
<%--                color: #fff;--%>
<%--            }--%>
<%--            .navbar .navbar-header {--%>
<%--                display: block;--%>
<%--            }--%>
<%--            .navbar .navbar-collapse {--%>
<%--                padding-left: 0;--%>
<%--                padding-right: 0;--%>
<%--            }--%>
<%--            .navbar-collapse li:last-child {--%>
<%--                border-bottom: 0px;--%>
<%--            }--%>
<%--            .navbar-collapse li li {--%>
<%--                border-bottom: 0px;--%>
<%--            }--%>
<%--            .nav-boxed {--%>
<%--                margin-top: 0px;--%>
<%--            }--%>
<%--        }--%>
<%--    </style>--%>

    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <%--      <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">--%>
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
        const username = "${username}";
        const room = "${chatRoom.chatRoomNo}";
        const author = "${author.userId}"
        const chatRoomNo = "${chatRoom.chatRoomNo}"
        //업데이트 컨트롤러로 이동
        function fncUpdateChatroom(){
            $("#chat-room").attr("method","get").attr("action","/chatRoom/updateChatRoom?chatRoomNo="+chatRoomNo).submit();
        }

        $(function() {
            $("#updateChatRoom").on("click", function() {
                fncUpdateChatroom();
            });
        });
        //사진 컨트롤러로 이동
        function fncPhotoChatroom(){
            alert("photos")
            $("#chat-room").attr("method","get").attr("action","/photos/roomPhotos?chatRoomNo="+chatRoomNo).submit();
        }

        $(function() {
            $("#roomPhotos").on("click", function() {
                fncPhotoChatroom();
            });
        });



        // const realUpload = document.querySelector('#uploadFile');
        // const upload = document.querySelector('#upload');
        // // upload.addEventListener('click', () => realUpload.click());


        $(function() {
            $(document).on("click", ".kick", function() {
                alert("kick");

                var chatRoomForm = $("#chat-room");
                chatRoomForm.attr("onsubmit", "return false;"); // 동적으로 onsubmit 속성 설정

                $.ajax({
                    url: "/chatMember/json/kickMember",
                    method: "POST",
                    dataType: "json",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    data: JSON.stringify({
                        "chatRoomNo": $('input[name=chatRoomNo]').val(),
                        "userId": $(this).data("userid"),
                    }),
                    success: function(JSONData, status) {
                        // 성공적으로 처리된 후의 동작

                        // 폼 제출을 허용하기 위해 onsubmit 속성 제거
                        chatRoomForm.removeAttr("onsubmit");
                    }
                });
            });
        });
        //


        $(document).ready(function() {
            // AJAX 요청을 보내고 채팅 멤버 리스트를 받아와 처리하는 함수
            function fetchChatMembers() {
                $.ajax({
                    url: '/chatMember/json/fetchChatMembers/'+chatRoomNo, // 서버의 채팅 멤버 리스트를 가져오는 경로로 수정해야 합니다.
                    type: 'GET',
                    dataType: 'json',
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    success: function(members) {
                        $("#chat-room").removeAttr("onsubmit"); //강퇴 기능 때문에 막힌 onsubmit 해제
                        console.log(chatRoomNo);
                        console.log(members);
                        let memberArray = [];
                        // 채팅 멤버 리스트를 출력할 요소
                        var chatUsers = $('#chatUsers');

                        // 기존 리스트 초기화
                        chatUsers.empty();

                        // 멤버 리스트를 순회하며 <li> 요소 생성 및 추가
                        $.each(members, function(index, member) {
                            memberArray.push(member.userId);
                            var li = $('<li>').attr("id", member.userId).text(member.userId);
                            chatUsers.append(li);

                            if (author === member.userId) {
                                li.append('<img src="/imagePath/masetHat.png"/>'); // 방장
                            }
                            if (author === username && author !== member.userId) {
                                var kickButton = $("<button>")
                                    .addClass("kick")
                                    .attr("data-userid", member.userId)
                                    .text("강제 퇴장");

                                li.append(kickButton);
                            }
                            chatUsers.append(li);
                        });
                        if(memberArray.includes(username)){
                            console.log("you are member!!!")
                        }else{
                            window.location.href = "/chatRoom/chatRoomList";
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log('AJAX Error:', error);
                    }
                });
            }
            // 페이지가 열리면 채팅 멤버 리스트를 받아와 출력
            fetchChatMembers();

            // 일정 간격으로 채팅 멤버 리스트 업데이트
            setInterval(function() {fetchChatMembers();}, 3000); // 5초마다 업데이트, 필요에 따라 적절한 간격으로 수정 가능
        });
        // function redirectToChatRoomList() {
        //     // Replace 'chatRoomListPage.html' with the actual URL or path of your chat room list page
        //     $("#chat-room").attr("method","get").attr("action","/chatRoom/chatRoomList").submit();
        // }
        //out
        function fncOutChatroom(){
            $("#chat-room").attr("method","get").attr("action","/chatMember/outMember?userId="+username+"&chatRoomNo="+chatRoomNo).submit();
        }

        $(function() {
            $("#out").on("click", function() {
                fncOutChatroom();
            });
        });

        //delete
        function fncDeleteChatroom(){
            alert("delete");
            alert(username);
            alert(chatRoomNo);
            $("#chat-room").attr("method","get").attr("action","/chatRoom/deleteChatRoom?userId="+username+"&chatRoomNo="+chatRoomNo).submit();
        }
        $(function() {$("#delete").on("click", function() {fncDeleteChatroom();});});

        $(function() {
            //updateStatus
            $(".updateStatus").on("click", function () {
                alert("updateStatus");
                $.ajax({
                    url: "/chatRoom/json/updateStatus",
                    method: "post",
                    dataType: "json",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    data: JSON.stringify({
                        "chatRoomNo": $('input[name=chatRoomNo]').val(),
                        "chatRoomStatus": $('input[name=chatRoomStatus]').val()
                    }),
                    success: function (JSONData, status) {

                        if(JSONData === 0){
                            $('.updateStatus').text("모집 하기");
                            $('input[name=chatRoomStatus]').val(1);
                        }else if(JSONData === 1){
                            $('.updateStatus').text("모집 완료");
                            $('input[name=chatRoomStatus]').val(0);
                        }
                    }
                });
            });
            $("#finishChatRoom").on("click", function () {
                alert("updateStatus");
                $.ajax({
                    url: "/chatRoom/json/updateStatus",
                    method: "post",
                    dataType: "json",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    data: JSON.stringify({
                        "chatRoomNo": $('input[name=chatRoomNo]').val(),
                        "chatRoomStatus": 2
                    }),
                    success: function (JSONData, status) {
                        alert(JSONData);
                        $('.updateStatus').remove();
                        $("#finishChatRoom").remove();
                    }
                });
            });
        });
    </script>
    <title>Motrip</title>

</head>
<body>
<header class="nav-menu fixed" >

    <style>
        #memo-section .panel {
            background-color: transparent;
        }
        #memo-section .panel .panel-heading{
            background-color: transparent;
        }
        #memo-section .panel .panel-title{
            background-color: transparent;
        }
        #memo-section .panel .panel-title > a{
            color: white;
        }
        #memo-section .panel .panel-title > a::before{
            background-color: transparent;
        }
        #memo-section .panel .panel-title > a::after{
            background-color: transparent;
        }
    </style>
    <link rel="stylesheet" href="/css/alarm/alarm.css" media="all">
    <script src="/js/alarm/alarm.js"></script>

    <%@ include file="/WEB-INF/views/layout/header.jsp" %>

    <header class="nav-menu fixed">
        <nav class="navbar normal transparent">
            <div class="container-fluid" style="background-color: #1b6d85">
                <div class="navbar-header">
                    <a class="navbar-brand" href="/">
                        <img src="/images/motrip-logo.gif" alt="" height="120" width="180">
                        <br/>

                    </a>
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar">
                        <i class="icon-microphone"></i>
                        <span class="sr-only">Toggle navigations</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>

                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a href="#">채팅방 Menu <i class="fa fa-chevron-down nav-arrow"></i></a>
                            <ul class="dropdown-menu">
                                <c:if test="${author.userId eq username}">
                                <li><a id="updateChatRoom">채팅창 수정</a></li>
                                <li><a id="delete">채팅방 삭제</a></li>
                                </c:if>
                                <c:if test="${author.userId ne username}">
                                    <li><a id="out">채팅방 나가기</a></li>
                                </c:if>
                                <li><a id="roomPhotos">채팅방 사진첩</a></li>
                                <c:if test="${chatRoom.chatRoomStatus eq 0 and chatRoom.chatRoomStatus ne 3}">
                                    <li><a class="updateStatus">모집 완료</a></li>
                                </c:if>
                                <c:if test="${chatRoom.chatRoomStatus eq 1 and chatRoom.chatRoomStatus ne 3}">
                                    <li><a class="updateStatus">모집 하기</a></li>
                                </c:if>
                                <c:if test="${chatRoom.chatRoomStatus eq 0 or chatRoom.chatRoomStatus eq 1}">
                                    <li><a id="finishChatRoom">여행 완료</a></li>
                                </c:if>

                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">모두의 여행 <i class="fa fa-chevron-down nav-arrow"></i></a>
                            <ul class="dropdown-menu">
                                <li><a href="home_default.html">모두의 여행이란</a></li>
                                <li><a href="home_slider.html">설계 포트폴리오</a></li>
                                <li><a href="home_slider_with_searhbar.html">제작팀 소개</a></li>
                                <c:if test="${empty sessionScope.user}">
                                    <li><a href="/test/login/user1">유저1로 로그인</a></li>
                                    <li><a href="/test/login/user2">유저2로 로그인</a></li>
                                    <li><a href="/test/login/admin">admin 로그인</a></li>
                                </c:if>
                                <c:if test="${not empty sessionScope.user}">
                                    <li><a href="/test/logout">${user.userId}님,로그아웃</a></li>
                                </c:if>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#">여행플랜</a>
                            <ul class="dropdown-menu">
                                <li><a href="/tripPlan/tripPlanList">여행플랜 목록</a>
                                </li>
                                <li><a href="/tripPlan/myTripPlanList">나의 여행플랜</a>
                                </li>
                                <li><a href="/tripPlan/myTripPlanList">나의 여행플랜</a>
                                </li>
                                <li><a href="/tripPlan/addTripPlanView">여행플랜 작성</a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle">채팅</a>
                            <ul class="dropdown-menu">
                                <li><a href="/chatRoom/chatRoomList">채팅 리스트</a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle">후기</a>
                            <ul class="dropdown-menu">
                                <li><a href="/review/addReviewView">후기 작성</a>
                                </li>
                                <li><a href="/review/getReviewList">모든 후기</a>
                                </li>
                                <li><a  href="/review/getMyReviewList">나의 후기</a>
                                </li>
                            </ul>
                        </li>
                        <li id="memo-section" class="dropdown">
                            <a href="#" class="dropdown-toggle">메모</a>
                            <ul id="memo-dropdown" class="dropdown-menu">
                                <div class="panel-group" id="memo-accordion" role="tablist" aria-multiselectable="true">
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="new-memo-btn">
                                            <p class="panel-title">
                                                <a role="button" data-parent="#memo-accordion" aria-expanded="false" aria-controls="collapseOne" class="collapsed">
                                                    + 새 메모
                                                </a>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="heading1One">
                                            <p class="panel-title">
                                                <a role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#my-memo-collapse" aria-expanded="true" aria-controls="collapseOne">
                                                    나의 메모 보기
                                                </a>
                                            </p>
                                        </div>
                                        <div id="my-memo-collapse" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                            <div class="panel-body">
                                                <div class="btn-group-vertical" role="group" aria-label="...">
                                                    <div class="btn btn-line btn-sm btn-default" role="group" aria-label="...">ㅁaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</div>
                                                    <div class="btn btn-line btn-sm btn-default" role="group" aria-label="...">ㅁaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</div>
                                                    <div class="btn btn-line btn-sm btn-default" role="group" aria-label="...">ㅁaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="heading1Two">
                                            <p class="panel-title">
                                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#shared-memo-collapse" aria-expanded="false" aria-controls="collapseTwo">
                                                    공유받은 메모 보기
                                                </a>
                                            </p>
                                        </div>
                                        <div id="shared-memo-collapse" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                            <div class="panel-body">
                                                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird
                                                on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table,
                                                raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="heading1Three">
                                            <p class="panel-title">

                                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#del-memo-collapse" aria-expanded="false" aria-controls="collapseThree">
                                                    삭제된 메모 보기
                                                </a>

                                            </p>
                                        </div>
                                        <div id="del-memo-collapse" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                            <div class="panel-body">
                                                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird
                                                on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table,
                                                raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="boardDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                게시판
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="boardDropdown">
                                <li>
                                    <a class="dropdown-item" href="/notice/noticeList">공지사항</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="/qna/qnaList">질의응답</a>
                                </li>
                            </ul>
                        </li>
                        <c:if test="${empty sessionScope.user}">
                        <li> <a href="/user/login"><span class="icon-user"></span>로그인</a>
                            </c:if>
                            <c:if test="${not empty sessionScope.user}">
                        <li class="dropdown">
                            <a class="icon-user" href="#">${sessionScope.user.nickname}</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">MyPage</a>
                                </li>
                                <c:if test="${sessionScope.user.role == 0}">
                                    <li><a href="/user/listUser">회원목록</a>
                                    </li>
                                </c:if>
                                <li><a href="#">로그아웃</a>
                                </li>
                            </ul>
                        </li>
                        </c:if>
                        </li>
                        <li class="dropdown">
                            <a id="alarm-set-area" href="#">
                                <span id="alarm-bell"  class="icon-bell" data-toggle="popover" data-content="popoverContents" data-placement="top" data-trigger="focus" title=""></span>
                                <span id="unreadAlarmCount" class="badge badge-danger">0</span></a>
                            <ul id="alarm-thumbnail-area" class="dropdown-menu  dropdown-menu-right cart-menu">

                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="alarm-info-area">
                <%--어플리케이션 스코프로부터 값을 받거나, 3이다.--%>
                <input type="hidden" id="pollingTime" value="${applicationScope.alarmPollingTime}">
                <input type="hidden" id="alarmUserId" value="${sessionScope.user.userId}">
                <input type="hidden" id="alarmUserNickname" value="${sessionScope.user.nickname}">
                <input type="hidden" id="alarmCurrentPage" value="1">
            </div>

        </nav>
    </header>
    <%--button trigger modal--%>
    <input type="hidden" data-toggle="modal" href="#alarm-modal"></input>
    <%--Modal--%>
    <div id="alarm-modal" class="modal" aria-labelledby="myModalLabel" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="alarm-modal-title" class="modal-title">Modal Title</h3>
                </div>
                <div id="alarm-modal-contents" class="modal-body">
                    Modal Content..
                </div>
                <div id="alarm-modal-footer" class="modal-footer">
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">닫기</button>
                    <button type="button" id="alarm-confirm-btn" class="btn btn-sm btn-primary">읽음</button>
                    <button type="button" id="alarm-navigate-btn" class="btn btn-sm btn-info">이동</button>
                    <button type="button" id="alarm-accept-btn" class="btn btn-sm btn-primary">승인</button>
                    <button type="button" id="alarm-hold-btn" class="btn btn-sm btn-warning">보류</button>
                    <button type="button" id="alarm-reject-btn" class="btn btn-sm btn-danger">거절</button>
                </div>
            </div>
        </div>
    </div>

</header>
<%--onsubmit="return false;"--%>
<div class="chat-container" >
    <form id="chat-room"  >
        <input type="hidden" name="chatRoomNo" value="${chatRoom.chatRoomNo}"/>
        <input type="hidden" name="userId" value="${username}"/>
        <input type="hidden" name="chatRoomStatus" value="${chatRoom.chatRoomStatus}"/>
        <input type="hidden" id="room-name"/>
        <main class="chat-main">
            <div class="chat-sidebar">
                <h3 id="chatRoomTitle">${chatRoom.chatRoomTitle}</h3>

                <h2><i class="fas fa-users"></i>현재 참여 목록</h2>
                <ul id="users"></ul><td/>
                <h2>참여 유저</h2>
                <ul id="chatUsers">
                </ul>
            </div>
            <div class="chat-messages">
            </div>
        </main>
    </form>

    <div id="image-preview"></div> <!-- Container for image preview -->
    <div class="chat-form-container">

        <form id="chat-form" enctype="multipart/form-data">
            <input
                    id="msg"
                    type="text"
                    placeholder="Enter Message"
<%--                    required--%>
                    autocomplete="off"
            />
            <input multiple="multiple" type="file" class="form-control"
                   id="uploadFile" name="uploadFile" style="width: 10vh" />
<%--            <label class="fileButton" for ="uploadFile"><button class="btn btn-primary hvr-grow" style="background-color: #bdb9ee; color:black" id="upload">+</button></label>--%>
<%--            <input multiple="multiple" type="file" class="form-control" id="uploadFile" name="uploadFile" style="display: none;"/>--%>
<%--            <button class="btn btn-primary hvr-grow" style="background-color: #bdb9ee; color:black" id="upload">+</button>--%>
            <button class="btn"><i class="fas fa-paper-plane"></i> Send</button>

        </form>
    </div>
</div>



<!--
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/qs/6.9.2/qs.min.js"
      integrity="sha256-TDxXjkAUay70ae/QJBEpGKkpVslXaHHayklIVglFRT4="
      crossorigin="anonymous"
    ></script> -->
<script src="https://cdn.socket.io/4.3.2/socket.io.min.js"></script>
<script src="/js/main.js"></script>
<script src="/vendor/jquery/dist/jquery.min.js"></script>


<script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
<%--  <script src="/vendor/owlcarousel/owl.carousel.min.js"></script>--%>
<script src="/vendor/retina.min.js"></script>
<%--  <script src="/vendor/jquery.imageScroll.min.js"></script>--%>
<%--  <script src="/assets/js/min/responsivetable.min.js"></script>--%>
<%--  <script src="/assets/js/bootstrap-tabcollapse.js"></script>--%>
<script src="/assets/js/main.js"></script>

<%--    <script src="/js/imagepreview.js"></script>--%>
<%--<script>--%>
<%--    const realUpload = document.querySelector('#uploadFile');--%>
<%--    const upload = document.querySelector('#upload');--%>
<%--   // upload.addEventListener('click', () => realUpload.click());--%>



<%--</script>--%>

</body>
</html>