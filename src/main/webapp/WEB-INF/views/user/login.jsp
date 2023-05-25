<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <title>MoTrip 로그인</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script type="text/javascript">


        //로그인
        $( function() {

            $("#userId").focus();

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("#login").on("click" , function() {

                const id=$("input:text").val();
                const pw=$("input:password").val();

                if(id == null || id.length <1) {
                    alert('ID 를 입력하지 않으셨습니다.');
                    $("#userId").focus();
                    return;
                }

                if(pw == null || pw.length <1) {
                    alert('패스워드를 입력하지 않으셨습니다.');
                    $("#pwd").focus();
                    return;
                }

                $("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
            });
        });

        //회원가입
        $( function() {

            $("#addUser").on("click" , function() {

                $('#addUserModal').modal('show');

            });
        });



    </script>
</head>
<body>

    <div> 로그인/회원가입 화면이다.</div>

    <form class="form-horizontal">

        <div class="form-group">
            <label for="userId" class="col-sm-4 control-label">아 이 디</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
            </div>
        </div>

        <div class="form-group">
            <label for="pwd" class="col-sm-4 control-label">패 스 워 드</label>
            <div class="col-sm-6">
                <input type="password" class="form-control" name="pwd" id="pwd" placeholder="패스워드" >
            </div>
        </div>

        <div class="col-sm-offset-4 col-sm-6 text-center">
            <button id="login" type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
            <button id="addUser" type="button" class="btn btn-primary"  >회 원 가 입 </button>
        </div>

    </form>

    <!-- 회원가입 모달 인클루드 -->
    <jsp:include page="addUserModal.jsp"/>






</body>
</html>
