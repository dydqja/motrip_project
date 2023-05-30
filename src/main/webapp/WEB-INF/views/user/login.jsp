<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bit.motrip.domain.*" %>

<!DOCTYPE html>

<html>

<head>
    <title>MoTrip 로그인</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="UTF-8"></script>
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



    </script>
</head>
<body>

    <div> 로그인/회원가입 화면이다.</div>

    <form >

        <div class="form-group">
            <label for="userId" class="col-sm-4 control-label">아 이 디</label>
            <div class="col-sm-6">
                <input class="form-control" type="text" name="userId" id="loginUserId"  placeholder="아이디" />
            </div>
        </div>

        <div class="form-group">
            <label for="pwd" class="col-sm-4 control-label">패 스 워 드</label>
            <div class="col-sm-6">
                <input class="form-control" type="password" name="pwd" id="loginPwd" placeholder="패스워드" />
            </div>
        </div>

        <div class="col-sm-offset-4 col-sm-6 text-center">
            <button id="login" type="submit" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
            <button id="addUser" type="button" class="btn btn-primary btn" >회 원 가 입 </button>
        </div>
        <div id="naverIdLogin"></div>




    </form>

    <!-- 회원가입 모달 인클루드 -->
    <jsp:include page="addUserModal.jsp"/>






</body>
</html>
