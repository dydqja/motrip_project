<%@ page contentType="text/html;charset=UTF-8" language="java" %>






<!DOCTYPE html>

<html lang="ko">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>아이디&비밀번호 찾기</title>

    <link rel="icon" type="image/png" href="assets/img/favicon.png" />
    <link rel="stylesheet" href="/assets/css/bootstrap.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">



</head>

<body>

<!-- Modal -->
<div id="findIdPwdModal" class="modal fade in" tabindex="-1" role="dialog" aria-hidden="true" style="display: none; padding-right: 17px;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                &nbsp
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body" style="display: flex; padding: 0;">









                <div class="container">

                    <div class="main-title">
                        <h3>아이디&비밀번호 찾기</h3>
                    </div>

                    <div class="block full">

                            <ul class="nav nav-tabs" data-toggle="tabs">
                                <li class="active"><a href="#example-tabs2-activity">Activity</a>
                                </li>
                                <li><a href="#example-tabs2-profile">Profile</a>
                                </li>
                                <li><a href="#example-tabs2-options" data-toggle="tooltip" title="" data-original-title="Settings"><i class="icon-setting"></i></a>
                                </li>
                            </ul>
                        </div>
                        <!-- END Block Tabs Title -->

                        <!-- Tabs Content -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="example-tabs2-activity">Block tabs..</div>
                            <div class="tab-pane" id="example-tabs2-profile">Profile..</div>
                            <div class="tab-pane" id="example-tabs2-options">Settings..</div>
                        </div>
                        <!-- END Tabs Content -->
                    </div>
                </div>














            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-sm btn-primary">Save changes</button>
            </div>
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

</body>

</html>
