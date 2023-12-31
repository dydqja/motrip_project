<%@ page contentType="text/html;charset=UTF-8" language="java" %>






<!DOCTYPE html>

<html lang="ko">

<head>
    <title>아이디&비밀번호 찾기</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            // 모달 창이 숨겨질 때 실행될 이벤트를 설정합니다.
            $('#findIdPwdModal').on('hidden.bs.modal', function () {
                // 모달 내의 모든 입력 필드를 초기화합니다.
                $(this).find('input').val('');

                // findId와 findPwd 버튼을 보이게 하고, idModal과 pwdModal을 숨깁니다.
                $(this).find('#findId, #findPwd').show();
                $(this).find('#idModal, #pwdModal').hide();
            });
        });

        $(document).ready(function() {
            $("#findId").click(function() {

                // '비밀번호 찾기' 부분 초기화
                $('#pwdModal').find('input').val('');
                $('#pwdModal').hide();
                // '아이디 찾기' 부분 재구성
                $("#idModal").show();
                $("#sendSmsByFindId").text("인증번호전송");
                $("#sendSmsByFindId").prop("disabled", false);
                $("#checkPhoneByFindId").text("");
                $('#phCodeConfirmByFindId').val('');
                $("#checkPhCodeConfirmByFindId").text("");
                $("#PhCodeGroupByFindId").hide();
                $("#getIdByPhone").text("");
                $("#getIdShow").hide();
            });

            $("#findPwd").click(function() {

                // '아이디 찾기' 부분 초기화
                $('#idModal').find('input').val('');
                $("#sendSmsByFindId").text("인증번호전송");
                $("#sendSmsByFindId").prop("disabled", false);
                $("#checkPhoneByFindId").text("");
                $('#phCodeConfirmByFindId').val('');
                $("#checkPhCodeConfirmByFindId").text("");
                $("#PhCodeGroupByFindId").hide();
                $('#idModal').hide();
                $("#getIdByPhone").text("");
                $("#getIdShow").hide();
                $("#checkPhoneByFindPwd").text("");
                $("#checkPhCodeConfirmByFindPwd").text("")
                $("#PhCodeGroupByFindPwd").hide();


                // '비밀번호 찾기' 부분 보이기
                $('#pwdModal').show();
            });
        });
        //아이디 찾기 쪽 script 구성 ############################################################################################
        let isPhoneNumberVerified = true;
        //인증번호 클릭시 인증번호 입력창 생성
        $(document).ready(function() {
            var smsConfirmNum = null;

            $("#phoneByFindId").on("input", function() {
                isPhoneNumberVerified = false;
            });

            //sms 인증번호 발송
            $("#sendSmsByFindId").on("click", function() {


                var phoneRegex = /^01[016789]\d{7,8}$/;
                var phoneNumber = $('#phoneByFindId').val();
                phoneNumber = phoneNumber.substring(0, 3) + "-" + phoneNumber.substring(3, 7) + "-" + phoneNumber.substring(7, 11);

                if( $('#phoneByFindId').val() == null || $('#phoneByFindId').val() == "" || !phoneRegex.test($('#phoneByFindId').val()) ) {
                    $("#checkPhoneByFindId").text("올바른 전화번호를 입력해 주세요").css({
                        'color': 'red',
                        'font-size': '10px'
                    });
                    return;
                } else {
                    $("#checkPhoneByFindId").text("")
                }

                    var smsMessage = ($('#phoneByFindId').val())
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

                        $("#PhCodeGroupByFindId").show();
                        $('#phCodeConfirmByFindId').val('');
                    }).fail(function (error) {

                    });


            });
            $("#confirmPhCodeByFindId").on("click", function() {
                if (smsConfirmNum !== null) {

                    var phCodeConfirm = $('#phCodeConfirmByFindId').val();
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

                        $("#PhCodeGroupByFindId").hide();
                        $("#sendSmsByFindId").text("인증완료");
                        $("#sendSmsByFindId").prop("disabled", true);

                        alert($('#phoneByFindId').val());
                        var phone = $('#phoneByFindId').val();

                        $.ajax({
                            url: "/user/findId",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({
                                phone: phone
                            }),
                            dataType: "text",
                            success: function (response) {
                                alert(response);


                                $("#idModal").hide();
                                $("#getIdShow").show();
                                $("#getIdByPhone").text(response);
                                // #############################
                            },
                            error: function (error) {
                                alert("실패");
                            }
                        });

                    } else if ($('#phCodeConfirmByFindId').val() == '') {
                        $("#checkPhCodeConfirmByFindId").text("인증번호를 입력해 주세요").css({
                            'color': 'red',
                            'font-size': '10px'
                        });
                    } else {
                        $("#checkPhCodeConfirmByFindId").text("인증번호가 일치하지 않습니다").css({
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
            $("#resendPhCodeByFindId").on("click", function () {
                console.log('재전송 버튼이 클릭되었습니다.');

                var smsMessage = ($('#phoneByFindId').val())

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

        //비밀번호 찾기 쪽 script 구성 ############################################################################################

        let isPhoneNumberVerified1 = true;
        //인증번호 클릭시 인증번호 입력창 생성
        $(document).ready(function() {
            var smsConfirmNum = null;

            $("#phoneByFindPwd").on("input", function() {
                isPhoneNumberVerified1 = false;
            });

            //sms 인증번호 발송
            $("#sendSmsByFindPwd").on("click", function() {
                console.log($("#userIdByFindPwd"));

                if($("#userIdByFindPwd").val() == null || $("#userIdByFindPwd").val() == "") {
                    $('#userIdByFindPwd').focus().addClass('shake');
                    setTimeout(function () {
                        $('#userIdByFindPwd').removeClass('shake');
                    }, 1000);
                    return;
                }

                var phoneRegex = /^01[016789]\d{7,8}$/;
                var phoneNumber = $('#phoneByFindPwd').val();
                var userId;

                $.ajax({
                    url: "/user/findId",
                    type: "POST",
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        phone: phoneNumber
                    }),
                    dataType: "text",
                    success: function (response) {
                        alert(response);
                        alert($('#userIdByFindPwd').val());
                        userId = response;

                    },
                    error: function (error) {
                        alert("실패");
                    }
                });

                if( $('#phoneByFindPwd').val() == null || $('#phoneByFindPwd').val() == "" || !phoneRegex.test($('#phoneByFindPwd').val()) ) {
                    $("#checkPhoneByFindPwd").text("올바른 전화번호를 입력해 주세요").css({
                        'color': 'red',
                        'font-size': '10px'
                    });
                    return;

                }else if(userId != $('#userIdByFindPwd').val()) {
                    $("#checkPhoneByFindPwd").text("입력하신 아이디에 등록된 전화번호가 아닙니다.").css({
                        'color': 'red',
                        'font-size': '10px'
                    });
                    return;

                } else {
                    $("#checkPhoneByFindPwd").text("")
                }

                var smsMessage = ($('#phoneByFindPwd').val())
                console.log(smsMessage);

                $.ajax({

                    url: "/user/sendSms",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(smsMessage),
                    dataType: "json",
                }).done(function (response) {

                    smsConfirmNum = response;
                    isPhoneNumberVerified1 = true;

                    $("#PhCodeGroupByFindPwd").show();
                    $('#phCodeConfirmByFindPwd').val('');
                }).fail(function (error) {

                });


            });
            $("#confirmPhCodeByFindPwd").on("click", function() {
                if (smsConfirmNum != null) {

                    var phCodeConfirm = $('#phCodeConfirmByFindPwd').val();
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

                        $("#PhCodeGroupByFindPwd").hide();
                        $("#sendSmsByFindPwd").text("인증완료");
                        $("#sendSmsByFindPwd").prop("disabled", true);
                        $("#changePwd").show();

                    } else if ($('#phCodeConfirmByFindPwd').val() == '') {
                        $("#checkPhCodeConfirmByFindPwd").text("인증번호를 입력해 주세요").css({
                            'color': 'red',
                            'font-size': '10px'
                        });
                    } else {
                        $("#checkPhCodeConfirmByFindPwd").text("인증번호가 일치하지 않습니다").css({
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
            $("#resendPhCodeByFindPwd").on("click", function () {
                console.log('재전송 버튼이 클릭되었습니다.');

                var smsMessage = ($('#phoneByFindPwd').val())

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

        //변경비밀번호와 변경비밀번호확인 일치하는지 체크
        let updatePwdConfirmChecked=false;
        $(document).ready(function() {

            $("#updatePwdConfirm").focusout(function() { // 비밀번호 확인 텍스트박스에서 포커스 아웃되면 실행
                updatePwdConfirm($(this).val())
            })
            function updatePwdConfirm(updatePwdConfirm){
                if(updatePwdConfirm == ""){
                    $("#updatePwdConfirmCheck").text("");
                    return; // 아직 입력된 상태가 아니라면 아무런 문구를 출력하지 않는다
                }

                if($('#updatePwd').val()!=$('#updatePwdConfirm').val()){
                    // 만약 pw1과 pw2가 일치하지 않는다면
                    $("#updatePwdConfirmCheck").text('비밀번호가 일치하지 않습니다').css({
                        'color': 'red',
                        'font-size': '10px' // 문구 출력
                    });
                    $('#updatePwdConfirm').val(''); // 값을 비움
                    $('#updatePwdConfirm').focus(); // 포인터를 pw2 로 맞춘다
                    updatePwdConfirmChecked=false;
                }
                else{
                    $("#updatePwdConfirmCheck").text('비밀번호가 일치합니다').css({
                        'color': 'green',
                        'font-size': '10px' // 문구 출력
                    });
                    updatePwdConfirmChecked=true;
                }
                // setAble();
            }
        });

        $(document).ready(function() {

            $( "#changePwdCommit" ).on("click" , function() {
                fncChangePwd();
            });
        });

            function fncChangePwd() {

                var userId = $('#userIdByFindPwd').val()
                var updatePwdConfirm = $('#updatePwdConfirm').val()
                alert(userId);
                alert(updatePwdConfirm);

                //변경했다면, 새로운비밀번호 유효성 체크
                if (updatePwdConfirm == null || updatePwdConfirmChecked == false) {
                    console.log("새로운비밀번호 =" + updatePwdConfirmChecked);
                    console.log("updatePwdConfirm = " + updatePwdConfirm);
                    $('#updatePwdConfirm').focus().addClass('shake');
                    setTimeout(function () {
                        $('#updatePwdConfirm').removeClass('shake');
                    }, 1000);
                    return;
                }

                $.ajax({

                    url: "/user/updatePwd",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        userId: userId,
                        pwd: updatePwdConfirm
                    }),
                    dataType: "text",
                    success: function (response) {

                        $('#findIdPwdModal').modal('hide');

                        // 페이지를 새로고침합니다.
                        location.reload();
                    },
                    error: function (error) {
                        alert("실패");
                    }
                });	//ajax close
            }














    </script>
</head>

<body>

<!-- Modal -->
<div class="modal fade" id="findIdPwdModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">아이디&비밀번호 찾기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">ㅁㅁㅁㅁ</button>
            </div>

            <div class="modal-body">
                <div>
                    <button type="button" class="btn btn-default" name="findId" id="findId">아이디찾기</button>
                    <button type="button" class="btn btn-default" name="findId" id="findPwd">비밀번호찾기</button>
                </div>

                <!-- 아이디찾기 부분 ################################################################################ -->
                <div id="idModal" style="display:none">
                    <label for="phoneByFindId" class="col-sm-4 control-label">전화번호</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="phone" id="phoneByFindId" placeholder="01012345678" required maxlength="11">
                        <span id="checkPhoneByFindId"></span>
                        <button type="button" class="btn btn-primary" id="sendSmsByFindId">인증번호전송</button>
                    </div>


                    <!-- sms인증번호 입력폼 ==> 평상시 숨김 -->
                    <div class="form-group" id="PhCodeGroupByFindId" style="display: none;">
                        <label for="phCodeConfirmByFindId" class="col-sm-4 control-label">전화번호 인증</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="phCodeConfirm" id="phCodeConfirmByFindId" placeholder="발송된 인증번호 입력">
                            <span id="checkPhCodeConfirmByFindId"></span>
                            <button type="button" class="btn btn-primary" id="confirmPhCodeByFindId">확인</button>
                            <button type="button" class="btn btn-primary" id="resendPhCodeByFindId">재전송</button>
                        </div>
                    </div>
                </div>
                <!-- 아이디찾기 부분 끝 ################################################################################ -->

                <!-- 아이디찾기 결과 부분 -->
                <div id="getIdShow" style="display:none">
                    <span id="getIdByPhone"></span>
                </div>
                <!-- 아이디찾기 결과 부분 끝 -->

                <!-- 비밀번호찾기 부분 ################################################################################ -->
                <div id="pwdModal" style="display:none">

                    <label for="UserIdByFindPwd" class="col-sm-4 control-label">아 이 디</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="userId" id="userIdByFindPwd"  placeholder="아이디" required>
                        <span id="checkIdByFindPwd"></span>
                    </div>

                    <label for="phoneByFindId" class="col-sm-4 control-label">전화번호</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="phone" id="phoneByFindPwd" placeholder="01012345678" required maxlength="11">
                        <span id="checkPhoneByFindPwd"></span>
                        <button type="button" class="btn btn-primary" id="sendSmsByFindPwd">인증번호전송</button>
                    </div>


                    <!-- sms인증번호 입력폼 ==> 평상시 숨김 -->
                    <div class="form-group" id="PhCodeGroupByFindPwd" style="display: none;">
                        <label for="phCodeConfirmByFindId" class="col-sm-4 control-label">전화번호 인증</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="phCodeConfirm" id="phCodeConfirmByFindPwd" placeholder="발송된 인증번호 입력">
                            <span id="checkPhCodeConfirmByFindPwd"></span>
                            <button type="button" class="btn btn-primary" id="confirmPhCodeByFindPwd">확인</button>
                            <button type="button" class="btn btn-primary" id="resendPhCodeByFindPwd">재전송</button>
                        </div>
                    </div>
                </div>

                <!-- 비밀번호 변경 입력폼 #################################################### -->
                <div class="form-group" id="changePwd" style="display: none;">
                    <label for="updatePwd" class="col-sm-4 control-label">비밀번호 변경</label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control" name="updatePwd" id="updatePwd" placeholder="변경 비밀번호">
                        <span id="updatePwdCheck"></span>
                        <input type="password" class="form-control" name="pwd" id="updatePwdConfirm" placeholder="변경 비밀번호 확인">
                        <span id="updatePwdConfirmCheck"></span>
                        <button type="button" class="btn btn-primary" id="changePwdCommit">확인</button>
                    </div>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="SecessionUserCommit">확인</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
