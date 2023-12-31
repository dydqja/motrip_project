<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <title>회원 탈퇴</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
    .shake {
    animation: shake 0.5s;
    animation-iteration-count: infinite;
    }

    @keyframes shake {
    0% { transform: translate(1px, 1px) rotate(0deg); }
    10% { transform: translate(-1px, -2px) rotate(-1deg); }
    20% { transform: translate(-3px, 0px) rotate(1deg); }
    30% { transform: translate(3px, 2px) rotate(0deg); }
    40% { transform: translate(1px, -1px) rotate(1deg); }
    50% { transform: translate(-1px, 2px) rotate(-1deg); }
    60% { transform: translate(-3px, 1px) rotate(0deg); }
    70% { transform: translate(3px, 1px) rotate(-1deg); }
    80% { transform: translate(-1px, -1px) rotate(1deg); }
    90% { transform: translate(1px, 2px) rotate(0deg); }
    100% { transform: translate(1px, -2px) rotate(-1deg); }
    }
    </style>




    <script type="text/javascript">
        var startSecessionDate;
        var endSecessionDate;

        $(document).ready(function(){

            var secessionDateStr = '${sessionScope.user.secessionDate}';
            // 'Sat Jun 03 19:29:15 KST 2023' -> '2023-06-03T19:29:15'
            var monthStrToNum = { Jan: '01', Feb: '02', Mar: '03', Apr: '04', May: '05', Jun: '06', Jul: '07', Aug: '08', Sep: '09', Oct: '10', Nov: '11', Dec: '12' };
            var parts = secessionDateStr.split(" ");
            var month = monthStrToNum[parts[1]];
            var reformattedStr = parts[5] + "-" + month + "-" + parts[2] + "T" + parts[3];
            var startSecessionDate = new Date(reformattedStr);

            <%--alert("session에 저장된 secession값 = "+ '${sessionScope.user.secessionDate}');--%>
            <%--alert("new Date 한 secession값 = " +startSecessionDate);--%>

            function formatDate(date) {
                var year = date.getFullYear();
                // JavaScript의 getMonth()는 0부터 시작하므로 1을 추가
                var month = (date.getMonth() + 1).toString().padStart(2, '0');
                var day = date.getDate().toString().padStart(2, '0');

                return year + '.' + month + '.' + day;
            }

            var startSecessionDate = formatDate(startSecessionDate);

            // 1년 후의 날짜 계산
            var endSecessionDate = new Date(startSecessionDate);
            endSecessionDate.setFullYear(endSecessionDate.getFullYear() + 1);
            var endSecessionDate = formatDate(endSecessionDate);


            // alert(startSecessionDate);
            // alert(endSecessionDate);

            $('#startSecessionDate').text(startSecessionDate);
            $('#endSecessionDate').text(endSecessionDate);

        });

        //복구
        $(function() {

            $( "#commit" ).on("click" , function() {
                fncRestoreUser();
            });
        });

        function fncRestoreUser() {


            if ($("#sendSms").text() == "인증번호전송") {

                $('#phone').focus().addClass('shake');
                setTimeout(function () {
                    $('#phone').removeClass('shake');
                }, 1000);
                return;
            }

            alert("회원 복구가 완료되었습니다.")

            $("form").attr("method" , "POST").attr("action" , "/user/restoreUser").submit();
        }

        let isPhoneNumberVerified = true;
        //인증번호 클릭시 인증번호 입력창 생성
        $(document).ready(function() {
            var smsConfirmNum = null;

            $("#phoneNumber").on("input", function() {
                isPhoneNumberVerified = false;
            });

            //sms 인증번호 발송
            $("#sendSms").on("click", function() {


                var phoneRegex = /^01[016789]\d{7,8}$/;
                var phoneNumber = $('#phone').val();
                phoneNumber = phoneNumber.substring(0, 3) + "-" + phoneNumber.substring(3, 7) + "-" + phoneNumber.substring(7, 11);

                if( $('#phone').val() == null || $('#phone').val() == "" || !phoneRegex.test($('#phone').val()) ) {
                    $("#checkPhone").text("올바른 전화번호를 입력해 주세요").css({
                        'color': 'red',
                        'font-size': '10px'
                    });
                    return;
                } else {
                    $("#checkPhone").text("")
                }

                if ( phoneNumber == '${sessionScope.user.phone}') {

                    var smsMessage = ($('#phone').val())
                    console.log(smsMessage);

                    $.ajax({

                        url: "/user/sendSms",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(smsMessage),
                        dataType: "json",
                    }).done(function (response) {

                        smsConfirmNum = response;
                        isPhoneNumberVerified = true;

                        $("#PhCodeGroup").show();
                    }).fail(function (error) {

                    });
                }else{
                    $("#checkPhone").text("회원가입시 등록한 전화번호를 입력해주세요").css({
                        'color': 'red',
                        'font-size': '10px'
                    });
                }
            });
            $("#confirmPhCode").on("click", function() {
                if (smsConfirmNum !== null) {

                    var phCodeConfirm = $('#phCodeConfirm').val();
                    useSmsResponse(smsConfirmNum, phCodeConfirm);  // '확인' 버튼 클릭시 사용자 정의 함수를 실행합니다.
                } else {
                    alert("응답을 아직 받지 못했습니다. 잠시 후 다시 시도해주세요.");
                }
            });
        });

        function useSmsResponse(smsConfirmNum, phCodeConfirm) {
            // 이 함수에서 AJAX 응답을 사용할 수 있습니다.
            $.ajax({
                url: "/user/phCodeConfirm",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    smsConfirmNum: smsConfirmNum,
                    phCodeConfirm: phCodeConfirm
                }),
                dataType: "json",
                success: function (response) {

                    if (response.result) {

                        $("#PhCodeGroup").hide();
                        $("#sendSms").text("인증완료");
                        $("#sendSms").prop("disabled", true);

                    } else if ($('#phCodeConfirm').val() == '') {
                        $("#checkPhCodeConfirm").text("인증번호를 입력해 주세요").css({
                            'color': 'red',
                            'font-size': '10px'
                        });
                    } else {
                        $("#checkPhCodeConfirm").text("인증번호가 일치하지 않습니다").css({
                            'color': 'red',
                            'font-size': '10px'
                        });
                    }
                },
                error: function (error) {
                    alert("실패");
                }
            });
        }

        $(document).ready(function() {
            //인증번호 재전송
            $("#resendPhCode").on("click", function () {
                console.log('재전송 버튼이 클릭되었습니다.');

                var smsMessage = ($('#phone').val())

                $.ajax({

                    url: "/user/sendSms",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(smsMessage),
                    dataType: "json",
                    success: function (response) {

                    },
                    error: function (error) {
                        alert("실패");
                    }
                });	//ajax close
            });
        });






    </script>

</head>
<body>

    <h1> 복 구 </h1>
    회원복구 하려면 가입 시 등록된 전화번호로 인증해주세요.<br/>
    회원복구가능 기간 <span id="startSecessionDate"></span> ~ <span id="endSecessionDate"></span>





    <form class="form-horizontal">

        <div class="form-group">
            <label for="phone" class="col-sm-4 control-label">전화번호</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="phone" id="phone" placeholder="01012345678" required maxlength="11">
                <span id="checkPhone"></span>
                <button type="button" class="btn btn-primary" id="sendSms">인증번호전송</button>
            </div>
        </div>

        <!-- sms인증번호 입력폼 ==> 평상시 숨김 -->
        <div class="form-group" id="PhCodeGroup" style="display: none;">
            <label for="phCodeConfirm" class="col-sm-4 control-label">전화번호 인증</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="phCodeConfirm" id="phCodeConfirm" placeholder="발송된 인증번호 입력">
                <span id="checkPhCodeConfirm"></span>
                <button type="button" class="btn btn-primary" id="confirmPhCode">확인</button>
                <button type="button" class="btn btn-primary" id="resendPhCode">재전송</button>
            </div>
        </div>

</form>

    <div class="footer">
        <button type="button" class="btn btn-default" id="commit">복구</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
    </div>

</body>
</html>
