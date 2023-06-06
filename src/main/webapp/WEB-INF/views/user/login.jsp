<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bit.motrip.domain.*" %>

<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" href="/assets/css/bootstrap.css" media="all">
<link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
<link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
<link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
<link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
<link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
</head>

<body class="login" style="background-image: url('http://placehold.it/1200x800');">
<div class="pre-loader">
    <div class="loading-img"></div>
</div>

<div class="main">
    <div class="form-box">
        <div class="form-head">
            <div class="mold-logo">
                <div class="mold">Mold</div>
                <div class="logo"></div>
                <div class="logo-txt">MoTrip</div>
            </div>
        </div>
        <div class="form-body">
            <form>
                <div class="form-group">
                    <label>아이디</label>
                    <div class="input-group">
                        <div class="input-group-addon icon-user"></div>
                        <input type="text" class="form-control" name="userId" id="loginUserId" placeholder="아이디" />
                    </div>
                </div>
                <div class="form-group">
                    <label>비밀번호</label>
                    <div class="input-group">
                        <div class="input-group-addon icon-lock"></div>
                        <input type="password" class="form-control" name="pwd" id="loginPwd" placeholder="비밀번호" />
                    </div>
                </div>

                <button id="login" type="submit" class="btn btn-primary hvr-sweep-to-right">로그인</button>
                <button id="addUser" class="btn btn-sm btn-success"><i class="icon-plus"></i>회원가입</button>

            </form>
        </div>
    </div>
</div>

<script src="/vendor/jquery/dist/jquery.min.js"></script>
<script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
<script src="/vendor/jquery.ui.touch-punch.min.js"></script>
<script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>

<script src="/vendor/retina.min.js"></script>
<script src="/assets/js/main.js"></script>

<!-- Current Page JS -->
<script src="/assets/js/min/login.min.js"></script>

<script type="text/javascript">

    //로그인
    $( function() {

        $("#loginUserId").focus();

        //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
        $("#login").on("click", function () {

            const userId = $("#loginUserId").val();
            const pwd = $("#loginPwd").val();


            if (userId == null || userId.length < 1) {
                alert('ID 를 입력하지 않으셨습니다.');
                $("#loginUserId").focus();
                return;
            }

            if (pwd == null || pwd.length < 1) {
                alert('패스워드를 입력하지 않으셨습니다.');
                $("#loginPwd").focus();
                return;
            }

            $("form").attr("method", "POST").attr("action", "/user/login").submit();
        });
    });


    //회원가입
    $( function() {

        $("#addUser").on("click" , function() {

            $('#addUserModal').modal('show');

        });
    });

    window.onload = function() {
        //네이버아이디로그인 버튼

        var naverLogin = new naver.LoginWithNaverId({
            clientId: "${sessionScope.naverClientId}",
            callbackUrl: "${sessionScope.naverCallbackUrl}",
            isPopup: false,
            loginButton: {color: "green", type: 1, height: 50}
        });
        naverLogin.init();
    };

    //아이디&비밀번호 찾기
    $( function() {

        //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
        $("#findIdPwd").on("click", function () {

            $('#findIdPwdModal').modal('show');
        });
    });

</script>


</body>

</html>
