<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>NaverLoginSDK</title>
</head>
<body>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>

        var naverLogin = new naver.LoginWithNaverId({
        clientId: "${sessionScope.naverClientId}",
        callbackUrl: "${sessionScope.naverCallbackUrl}",
        isPopup: false,
        callbackHandle: true
        })

        naverLogin.init();

        /* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
        window.addEventListener('load', function () {
            naverLogin.getLoginStatus(function (status) {
                if (status) {
                    /* (5) 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
                    console.log(naverLogin.user); //사용자 정보를 받을수 있습니다.
                    var userId = naverLogin.user.getId();
                    var gender = naverLogin.user.getGender();
                    var phone = naverLogin.user.getMobile();
                    var userName = naverLogin.user.getName();
                    var age = naverLogin.user.getAge();
                    var email = naverLogin.user.getEmail();

                    if( userId == undefined || userId == null) {
                        alert("정보제공을 동의해주세요.");
                        naverLogin.reprompt();
                        return;
                    }
                    if( gender == undefined || gender == null) {
                        alert("성별은 필수정보입니다. 정보제공을 동의해주세요.");
                        naverLogin.reprompt();
                        return;
                    }
                    if( phone == undefined || phone == null) {
                        alert("휴대전화번호는 필수정보입니다. 정보제공을 동의해주세요.");
                        naverLogin.reprompt();
                        return;
                    }
                    if( userName == undefined || userName == null) {
                        alert("이름은 필수정보입니다. 정보제공을 동의해주세요.");
                        naverLogin.reprompt();
                        return;
                    }
                    if( age == undefined || age == null) {
                        alert("연령대는 필수정보입니다. 정보제공을 동의해주세요.");
                        naverLogin.reprompt();
                        return;
                    }
                    if( email == undefined || email == null) {
                        alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
                        naverLogin.reprompt();
                        return;
                    }

                    $.ajax({
                        url: "/user/checkUser", // 서버로 전송할 URL. 여기서는 임의로 설정하였습니다.
                        type: 'POST',
                        dataType: 'text',
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify({ // 전송할 데이터를 JSON 형식으로 변환합니다.
                            'userId': userId,
                            'gender': gender,
                            'phone': phone,
                            'userName': userName,
                            'age': age,
                            'email': email
                        }),
                        success: function(response) {
                            // 서버에서 응답이 올 경우 실행할 코드를 여기에 작성합니다.
                            console.log(response);
                            self.location.href = response;

                        },
                        error: function(request, status, error) {
                            // 서버에서 오류 응답이 올 경우 실행할 코드를 여기에 작성합니다.
                            console.log('code: '+request.status+'\n'+'message: '+request.responseText+'\n'+'error: '+error);
                        }
                    });
                } else {
                    console.log("callback 처리에 실패하였습니다.");
                }
            });
        });
    </script>

</body>
</html>
