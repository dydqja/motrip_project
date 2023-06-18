<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MoTrip 회원가입</title>

    <link rel="icon" type="image/png" href="/assets/img/favicon.png" />
    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/assets/css/bootstrap.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
<%--    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>












  <style>

    .form-group {
        margin-bottom: 15px;
    }

    .pwd-btn {
        color: #fff;
        background-color: #003049;
        border: none;
        padding: 10px 20px;
        text-transform: uppercase;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
    }

    .pwd-input {
        display: block;
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        border: 2px solid #558B2F;
    }

    .pwd-textarea {
        display: block;
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        border: 2px solid #558B2F;
        height: 100px;  /* textarea의 경우 높이를 지정해줘야 합니다. 필요한 높이로 조정해주세요 */
        resize: vertical; /* 사용자가 수직 방향으로만 크기를 조절할 수 있게 합니다. 필요하다면 이 속성을 삭제하거나 'both'로 변경할 수 있습니다. */
    }

    .selfIntroText {
      width: 300px;
      height:100px;
    }

    .input-text {
      font-size: 12px;
    }

    #drop_zone {
        border: 3px dashed #558B2F;
        padding: 50px;
        width: 200px;
        height: 100px;
        text-align: center;
        font-size: 1.5em;
        color: #558B2F;
        margin: 0 10px 10px 0;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #e8f5e9;
        transition: background-color 0.3s;
    }

    #drop_zone.dragover {
        background-color: #c8e6c9;
    }

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


</head>

<body>



<%--<div class="form-group">--%>
<%--    <label>Name</label>--%>
<%--    <input type="text" class="form-control" placeholder="Email">--%>
<%--</div>--%>


  <!-- 회원가입 모달 -->
  <!-- Modal -->
  <div id="addUserModal" class="modal fade in" tabindex="-1" role="dialog" aria-hidden="true" style="display: none; padding-right: 17px;">
    <div class="modal-dialog">
      <div class="modal-content" style="background-color: #F5F1E3;">
        <div class="modal-header text-center" style="background-color: #558B2F;">
          <h3 class="modal-title" style="margin-right: 0; color: white;">MoTrip 회원가입</h3>
              <button type="button" class="close hvr-grow" data-dismiss="modal" aria-hidden="true" style="color: #8B2955;">×</button>
        </div>
        <div class="modal-body" style="display: flex; margin : 0% 20%;">

            <div class="col-sm-12">
                <form id="addUserForm">
                    <input type="hidden" name="userPhoto" id="userPhoto" value="" />

                    <div class="form-group" >
                        <label class="label label-primary">아이디<span style="color:red"> *</span></label>
                        <input type="text" class="pwd-input" name="userId" id="modalUserId" aria-describedby="helpBlock2">
                        <span id="checkId"></span>
                    </div>

                    <div class="form-group">
                        <label class="label label-primary">비밀번호<span style="color:red"> *</span></label>
                        <input type="password" class="pwd-input" name="pwd" id="modalPwd" aria-describedby="helpBlock2">
                    </div>

                    <div class="form-group">
                        <label class="label label-primary">비밀번호확인<span style="color:red"> *</span></label>
                        <input type="password" class="pwd-input" name="pwdConfrim" id="pwdConfirm" aria-describedby="helpBlock2">
                        <span id="checkPwd"></span>
                    </div>

                    <div class="form-group" >
                        <label class="label label-primary">닉네임<span style="color:red"> *</span></label>
                        <input type="text" class="pwd-input" name="nickname" id="nickname" aria-describedby="helpBlock2">
                        <span id="checkNickname"></span>
                    </div>

                    <div class="form-group" >
                        <label class="label label-primary">이름<span style="color:red"> *</span></label>
                        <input type="text" class="pwd-input" name="userName" id="userName" aria-describedby="helpBlock2">
                    </div>

                    <div class="form-group text-center" >
                        <label class="label label-primary">전화번호<span style="color:red"> *</span></label>
                        <input type="text" class="pwd-input" name="phone" id="phone" placeholder="01012345678" aria-describedby="helpBlock2">
                        <span id="checkPhone" style="white-space: nowrap; display: block;"></span>
                        <button type="button" class="pwd-btn hvr-grow" id="sendSms">인증번호전송</button>
                    </div>

                    <!-- sms인증번호 입력폼 ==> 평상시 숨김 -->
                    <div class="form-group" id="PhCodeGroup" style="display: none;" >
                        <label class="label label-primary">전화번호 인증</label>
                        <input type="text" class="pwd-input" name="phCodeConfirm" id="phCodeConfirm" placeholder="발송된 인증번호 입력" aria-describedby="helpBlock2">
                        <span id="checkPhCodeConfirm" style="white-space: nowrap; display: block;"></span>
                        <button type="button" class="pwd-btn hvr-grow" id="confirmPhCode">확인</button>
                        <button type="button" class="pwd-btn hvr-grow" id="resendPhCode" style="background-color: #8B2955;">재전송</button>
                    </div>

                    <div class="form-group text-center">
                        <label class="label label-primary">주소<span style="color:red"> *</span></label>
                        <div>
                            <input type="text" class="pwd-input" id="sample3_address" name="addr" aria-describedby="helpBlock2">
                            <input type="button" class="pwd-btn hvr-grow" onclick="sample3_execDaumPostcode()" value="주소 찾기">
                        </div>
                    </div>

                    <div id="wrap" style="display:none;border:1px solid;width:350px;height:300px;margin:5px 0;position:relative">
                        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
                    </div>

                    <div class="form-group">
                        <label for="sample3_detailAddress" class="label label-primary">상세주소<span style="color:red"> *</span></label>
                        <input type="text" class="pwd-input" name="addrDetail" id="sample3_detailAddress" required>
                    </div>

                    <div class="form-group">
                        <label for="email" class="label label-primary">이메일</label>
                        <input type="text" class="pwd-input" name="email" id="email" placeholder="bitcmap@motrip.com" aria-describedby="helpBlock2" required>
                    </div>

                    <div class="form-group">
                        <label for="ssn1" class="label label-primary">주민등록번호<span style="color:red"> *</span></label>
                        <div style="display: flex;">
                        <input type="text" class="pwd-input" name="ssn1" id="ssn1" style="margin-right: 0; width: 100px;" aria-describedby="helpBlock2" maxlength="6">
                            &nbsp;<img style="max-width: 25px; max-height: 25px; margin-top: 20px;" src="/images/user/minus.png">&nbsp;
                        <input type="text" class="pwd-input" name="ssn2" id="ssn2" style="width: 40px;" aria-describedby="helpBlock2" maxlength="1">
                            <img style="max-width: 20px; max-height: 20px; margin-top: 20px;" src="/images/user/asterisk.png">
                            <img style="max-width: 20px; max-height: 20px; margin-top: 20px;" src="/images/user/asterisk.png">
                            <img style="max-width: 20px; max-height: 20px; margin-top: 20px;" src="/images/user/asterisk.png">
                            <img style="max-width: 20px; max-height: 20px; margin-top: 20px;" src="/images/user/asterisk.png">
                            <img style="max-width: 20px; max-height: 20px; margin-top: 20px;" src="/images/user/asterisk.png">
                            <img style="max-width: 20px; max-height: 20px; margin-top: 20px;" src="/images/user/asterisk.png">
                        </div>
                        <input type="hidden" name="ssn" id="ssn" />
                    </div>

                    <div class="form-group text-left">
                        <div style="margin-right: 20%; ">
                            <label for="selfIntro" class="label label-primary">자기소개</label>

                            <div class="btn-group" data-toggle="buttons">
                                <label class="btn btn-primary active">
                                    <input type="radio" name="selfIntroPublic" id="selfIntroPublic" value="true" autocomplete="off" checked> 공개
                                </label>
                                <label class="btn btn-primary">
                                    <input type="radio" name="selfIntroPublic" id="selfIntroPrivate" value="false" autocomplete="off"> 비공개
                                </label>
                            </div>
                        </div>
                        <div style="margin-right: 20%;" >
                            <textarea class="pwd-textarea text-center" name="selfIntro" id="selfIntro" placeholder="300자 이내 자기소개" maxlength="300" >${getUser.selfIntro}</textarea>
                        </div>
                    </div>

                    <div class="form-group text-left">
                        <label for="drop_zone" class="label label-primary">회원사진등록</label>

                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary active">
                                <input type="radio" name="userPhotoPublic" id="userPhotoPublic" value="true" autocomplete="off" checked> 공개
                            </label>
                            <label class="btn btn-primary">
                                <input type="radio" name="userPhotoPublic" id="userPhotoPrivate" value="false" autocomplete="off"> 비공개
                            </label>
                        </div>

                        <div id="drop_zone" name="userPhoto" style="margin-top: 10px; font-size: 16px;">사진 파일을 올려주세요</div>

                    </div>

                    <div class="form-group text-left">
                        <label for="drop_zone" class="label label-primary">SMS수신동의</label>

                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary active">
                                <input type="radio" name="gettingSmsAlarm" id="SmsAlarmYes" value="true" autocomplete="off" checked> 동의
                            </label>
                            <label class="btn btn-primary">
                                <input type="radio" name="gettingSmsAlarm" id="SmsAlarmNo" value="false" autocomplete="off"> 비동의
                            </label>
                        </div>
                    </div>

                </form>
            </div>
        </div>
        <div class="modal-footer" style=" background-color: #003049;">
          <button type="button" class="btn btn-sm btn-default hvr-grow" id="addUserModalCancle" data-dismiss="modal">닫기</button>
          <button type="button" class="btn btn-sm btn-primary hvr-grow" id="addUserModalCommit" style="background-color: #FFB347;">가입</button>
        </div>
      </div>
    </div>
  </div>

<%--<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<%--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>--%>
<script src="/vendor/jquery/dist/jquery.min.js"></script>
<script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
<script src="/vendor/jquery.ui.touch-punch.min.js"></script>
<script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>



<script src="/vendor/retina.min.js"></script>
<script src="/assets/js/main.js"></script>

<!-- Current Page JS -->
<script src="/assets/js/min/login.min.js"></script>





<script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
<script src="/vendor/owlcarousel/owl.carousel.min.js"></script>
<script src="/vendor/jquery.imageScroll.min.js"></script>
<script src="/assets/js/min/responsivetable.min.js"></script>
<script src="/assets/js/bootstrap-tabcollapse.js"></script>
<%--<script src="/assets/js/min/countnumbers.min.js"></script>--%>
<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>




  <script type="text/javascript">

      //가입
      $(function() {

          $( "#addUserModalCommit" ).on("click" , function() {
              fncAddUser();
          });
      });

      function fncAddUser() {

          var id = $("#modalUserId").val();
          var pw = $("#modalPwd").val();
          var pw_confirm = $("#pwdConfirm").val();
          var name = $("input[name='userName']").val();
          var nickname = $("input[name='nickname']").val();
          var addr = $("#sample3_address").val();
          var addrDetail = $("#sample3_detailAddress").val();
          var ssn = "";
          var regex = /^[a-zA-Z0-9]+$/;

          if (id == null || id.length < 4 || idChecked == false || !regex.test(id)) {

              $('#modalUserId').focus().addClass('shake');
              setTimeout(function () {
                  $('#modalUserId').removeClass('shake');
              }, 1000);
              return;
          }

          if(pw == null || pw.length <1 ){

              $('#modalPwd').focus().addClass('shake');
              setTimeout(function () {
                  $('#modalPwd').removeClass('shake');
              }, 1000);
              return;
          }

          if(pw_confirm == null || pw_confirm.length <1 ){
              console.log("비빌번호확인 유효성 체크 결과 : " +pw_confirm);

              $('#pwdConfirm').focus().addClass('shake');
              setTimeout(function () {
                  $('#pwdConfirm').removeClass('shake');
              }, 1000);
              return;
          }

          if(nickname == null || nickname.length <1 || nicknameChecked == false ){
              console.log("닉네임 유효성 체크 결과 : " +nickname);

              $('#nickname').focus().addClass('shake');
              setTimeout(function () {
                  $('#nickname').removeClass('shake');
              }, 1000);
              return;
          }

          if(name == null || name.length <1){

              $('#userName').focus().addClass('shake');
              setTimeout(function () {
                  $('#userName').removeClass('shake');
              }, 1000);
              return;
          }

          if( pw != pw_confirm || pwdChecked == false) {

              $('#pwdConfirm').focus().addClass('shake');
              setTimeout(function () {
                  $('#pwdConfirm').removeClass('shake');
              }, 1000);
              return;
          }

          if ($("#sendSms").text() == "인증번호전송") {

              $('#phone').focus().addClass('shake');
              setTimeout(function () {
                  $('#phone').removeClass('shake');
              }, 1000);
              return;
          }

          if(addr == null || addr.length <1) {

              $('#sample3_address').focus().addClass('shake');
              setTimeout(function () {
                  $('#sample3_address').removeClass('shake');
              }, 1000);
              return;
          }

          if(addrDetail == null || addrDetail.length <1) {

              $('#sample3_detailAddress').focus().addClass('shake');
              setTimeout(function () {
                  $('#sample3_detailAddress').removeClass('shake');
              }, 1000);
              return;
          }

          if(juminCheck == false) {
              console.log("juminCheck == false");
              $('#ssn1').focus().addClass('shake');
              setTimeout(function () {
                  $('#ssn1').removeClass('shake');
              }, 1000);
              return;
          }

          if( $("input:text[name='ssn1']").val() != ""  &&  $("input:text[name='ssn2']").val() != "") {

              var ssn = $("input[name='ssn1']").val() + "-"
                  + $("input[name='ssn2']").val();

              $("input:hidden[name='ssn']").val( ssn );
          }
          swal({
              title: "회원 가입이 완료되었습니다.",
              text: "여행을 떠나보세요",
              icon: "success",
              button: "확인",

          }).then((value) => {
              $("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
          });
      }

      //==>"이메일" 유효성Check  Event 처리 및 연결
      $(function() {

          $("input[name='email']").on("change" , function() {

              var email=$("input[name='email']").val();

              if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){

                  $('#email').focus().addClass('shake');
                  setTimeout(function () {
                      $('#email').removeClass('shake');
                  }, 1000);
                  return;
              }
          });
      });
      let juminCheck = false;
      //==> 주민번호 유효성 check
      $(function() {
          // 주민등록번호 필드가 변경되었을 때 이벤트를 발생시킵니다.
          $("#ssn1, #ssn2").on("change" , function() {

              var ssn1 = $("#ssn1").val();
              var ssn2 = $("#ssn2").val();

              // 두 필드 모두 값이 입력되었을 때만 검사를 수행합니다.
              if (ssn1.length == 6 && ssn2.length == 1) {
                  var ssn = ssn1 + ssn2;

                  if(!PortalJuminCheck(ssn)) {
                      $(this).focus().addClass('shake');
                      juminCheck = false;
                      setTimeout(function () {
                          $(this).removeClass('shake');
                      }.bind(this), 1000);
                      return;
                  }else{
                      juminCheck = true;
                  }
              }
          });
      });
      function PortalJuminCheck(ssn){
          var pattern = /^([0-9]{6})-?([1-4]{1})$/;
          var num = ssn;
          if (!pattern.test(num)) return false;
          num = RegExp.$1 + RegExp.$2;

          // 앞 6자리 날짜 유효성 검사
          var yy = num.substring(0,2);
          var mm = num.substring(2,4);
          var dd = num.substring(4,6);

          var year = (num.charAt(6) <= "2") ? "19" + yy : "20" + yy;
          var date = new Date(year, mm - 1, dd);
          if (date.getYear() % 100 != yy || date.getMonth() + 1 != mm || date.getDate() != dd)
              return false;

          return true;
      }

      //인증번호 클릭시 인증번호 입력창 생성
      $(document).ready(function() {

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
                  success: function (response,err) {
                      console.log("hi");
                      console.log('response.result:', response.result); // response.result 값 확인
                      console.log('element count:', $("#sendSms").length); // 선택되는 엘리먼트 개수 확인

                      if (response.result) {

                          console.log($("#sendSms").text())

                          $("#PhCodeGroup").hide();
                          $("#sendSms").text("인증완료").css({
                              "color": "white"
                          });  // 텍스트 색상과 폰트 크기 변경
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
                  error: function (err) {
                      console.log("실패");
                  }
              });
          }

          var smsConfirmNum = null;

          $("#sendSms").on("click", function() {

              var phoneRegex = /^01[016789]\d{7,8}$/;
              var phone = $('#phone').val();

              if( phone == null || phone == "" || !phoneRegex.test(phone) ) {
                  $("#checkPhone").text("올바른 전화번호를 입력해 주세요").css({
                      'color': 'red',
                      'font-size': '10px'
                  });
                  return;
              } else {
                  $("#checkPhone").text("")
              }

              var smsMessage = ($('#phone').val())
              console.log(smsMessage);

              $.ajax({

                  url: "/user/sendSms",
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  data: JSON.stringify(smsMessage),
                  dataType: "json",
              }).done(function(response) {

                  smsConfirmNum = response;

                  $("#PhCodeGroup").show();
              }).fail(function(error) {

              });
          });

          $("#confirmPhCode").on("click", function() {
              if (smsConfirmNum !== null) {

                  var phCodeConfirm = $('#phCodeConfirm').val();
                  useSmsResponse(smsConfirmNum, phCodeConfirm);  // '확인' 버튼 클릭시 사용자 정의 함수를 실행합니다.
                  console.log("확인버튼 실행됨")
              } else {
                  alert("응답을 아직 받지 못했습니다. 잠시 후 다시 시도해주세요.");
              }
          });

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

                      smsConfirmNum = response;
                  },
                  error: function (error) {
                      alert("다시 시도해주세요.");
                  }
              });	//ajax close
          });
      });

      //모달창 생성시 모달창에 포커스 준다
      $('#addUserModal').on('shown.bs.modal', function () {
          $('#modalUserId').trigger('focus')
      })

      //ESC 누를시 모달창 종료
      $(document).keyup(function(e) {
          if (e.key === "Escape") {
              $('#addUserModal').modal('hide');
          }
      });

      //주소찾기 API start
      document.addEventListener("DOMContentLoaded", function(){
          // 우편번호 찾기 찾기 화면을 넣을 element
          var element_wrap = document.getElementById('wrap');

          window.foldDaumPostcode = function() {
              // iframe을 넣은 element를 안보이게 한다.
              element_wrap.style.display = 'none';
          }

          window.sample3_execDaumPostcode = function() {
              // 현재 scroll 위치를 저장해놓는다.
              var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
              new daum.Postcode({
                  oncomplete: function (data) {
                      // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                      var addr = ''; // 주소 변수
                      var extraAddr = ''; // 참고항목 변수

                      //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                          addr = data.roadAddress;
                      } else { // 사용자가 지번 주소를 선택했을 경우(J)
                          addr = data.jibunAddress;
                      }

                      // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                      if (data.userSelectedType === 'R') {
                          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                          if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                              extraAddr += data.bname;
                          }
                          // 건물명이 있고, 공동주택일 경우 추가한다.
                          if (data.buildingName !== '' && data.apartment === 'Y') {
                              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                          }
                          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.

                          // 조합된 참고항목을 해당 필드에 넣는다.


                      }

                      // 우편번호와 주소 정보를 해당 필드에 넣는다.

                      console.log("3" + document.getElementById("sample3_address"));
                      document.getElementById("sample3_address").value = addr;
                      // 커서를 상세주소 필드로 이동한다.
                      console.log("4" + document.getElementById("sample3_detailAddress"));
                      document.getElementById("sample3_detailAddress").focus();

                      // iframe을 넣은 element를 안보이게 한다.
                      // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                      element_wrap.style.display = 'none';

                      // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                      document.body.scrollTop = currentScroll;
                  },
                  // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
                  onresize: function (size) {
                      element_wrap.style.height = size.height + 'px';
                  },
                  width: '100%',
                  height: '100%'
              }).embed(element_wrap);

              // iframe을 넣은 element를 보이게 한다.
              element_wrap.style.display = 'block';
          }
      });

      //아이디 중복체크
      let idChecked = false; // 중복 확인을 거쳤는지 확인
      $(document).ready(function() {

          $("#modalUserId").keyup(function () { // 아이디를 입력할때 마다 중복검사 실행

              checkId($(this).val())
          })

          function checkId(userId) {
              if (userId == "") {
                  $("#checkId").text("");

                  return; // 만약 아이디 입력란이 공백일 경우 중복확인 문구 X
              }

              $.ajax({
                  url: "/user/checkId",
                  type: "post",
                  async: true,
                  data: {value: userId},
                  dataType: "json",
                  success: function (result) {

                      var regex = /^[a-zA-Z0-9]+$/;

                      if (result == 0) {
                          $("#checkId").text('사용할 수 없는 아이디입니다.').css({
                              'color': 'red',
                              'font-size': '10px'
                          });
                          idChecked = false; // id체크 true

                      }else if (result == 1 && !regex.test(userId)) {
                          $("#checkId").text('영문 대소문자와 숫자만 사용할 수 있습니다.').css({
                              'color': 'red',
                              'font-size': '10px'
                          });
                      } else {
                          $("#checkId").text('사용 가능한 아이디입니다.').css({
                              'color': 'green',
                              'font-size': '10px'
                          });
                          idChecked = true;
                      }
                  },
                  error: function () {
                      alert("서버요청실패");
                  }
              })
              //setAble();
          }
      });

      //비밀번호 중복체크
      let pwdChecked=false;
      $(document).ready(function() {

          $("#pwdConfirm").focusout(function() { // 비밀번호 확인 텍스트박스에서 포커스 아웃되면 실행
              checkPwd($(this).val())
          })
          function checkPwd(pwdConfrim){
              if(pwdConfrim == ""){
                  $("#checkPwd").text("");
                  return; // 아직 입력된 상태가 아니라면 아무런 문구를 출력하지 않는다
              }
              var passwordRegEx = /^(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,}$/;


              if($('#modalPwd').val()!=$('#pwdConfirm').val()){
                  // 만약 pw1과 pw2가 일치하지 않는다면
                  $("#checkPwd").text('비밀번호가 일치하지 않습니다').css({
                      'color': 'red',
                      'font-size': '10px' // 문구 출력
                  });
                  $('#pwdConfirm').val(''); // 값을 비움
                  $('#pwdConfirm').focus(); // 포인터를 pw2 로 맞춘다
                  pwdChecked=false;
              } else if($('#modalPwd').val()==$('#pwdConfirm').val() && !passwordRegEx.test($('#pwdConfirm').val()) ) {

                  $("#checkPwd").text('특수문자 포함 8자 이상 입력해주세요.').css({
                      'color': 'red',
                      'font-size': '10px' // 문구 출력
                  });
                  $('#pwdConfirm').val(''); // 값을 비움
                  $('#pwdConfirm').focus(); // 포인터를 pw2 로 맞춘다
                  pwdChecked=false;
              }else{
                  $("#checkPwd").html('비밀번호가 일치합니다').css({
                      'color': 'green',
                      'font-size': '10px' // 문구 출력
                  });
                  pwdChecked=true;
              }
              // setAble();
          }
      });

      //닉네임 중복체크
      let nicknameChecked = false;
      $(document).ready(function() {

          $("#nickname").keyup(function () { // 닉네임을 입력할때 마다 중복검사 실행

              checkNickname($(this).val())
          })

          function checkNickname(nickname) {
              if (nickname == "") {
                  $("#checkNickname").text("");

                  return; // 만약 아이디 입력란이 공백일 경우 중복확인 문구 X
              }

              $.ajax({
                  url: "/user/checkNickname",
                  type: "post",
                  async: true,
                  data: {value: nickname},
                  dataType: "json",
                  success: function (result) {

                      if (result == 0) {
                          $("#checkNickname").text('사용할 수 없는 닉네임입니다.').css({
                              'color': 'red',
                              'font-size': '10px'
                          });
                          nicknameChecked = false; // id체크 true
                      }else if(result == 1 && nickname.length > 8 ) {
                          $("#checkNickname").text('닉네임은 8자를 넘을 수 없습니다.').css({
                              'color': 'red',
                              'font-size': '10px'
                          });
                      } else {
                          $("#checkNickname").text('사용 가능한 닉네임입니다.').css({
                              'color': 'green',
                              'font-size': '10px'
                          });
                          nicknameChecked = true;
                      }
                  },
                  error: function () {
                      alert("서버요청실패");
                  }
              })
              //setAble();
          }
      });

      // Drag & Drop 파일업로드
      $(document).ready(function() {


          var dropZone = $('#drop_zone');
          dropZone.on('dragover', function (e) {
              console.log('이미지파일 드래그해서 드랍존에 올린상태###');
              e.preventDefault();
              dropZone.css('background-color', '#E8F0FF');
          });
          dropZone.on('dragleave', function (e) {
              console.log('드랍존에 올렸다가 밖으로 나온상태 ###');
              e.preventDefault();
              dropZone.css('background-color', '#FFFFFF');
          });
          dropZone.on('drop', function (e) {
              console.log('이미지파일 드래그해서 드랍존에 올린상태로 마우스 땐 상태 ###');
              e.preventDefault();
              console.log(e);
              dropZone.css('background-color', '#FFFFFF');

              var files = e.originalEvent.dataTransfer.files;
              console.log(files)
              if (files != null) {
                  if (files.length > 1) {
                      alert("파일은 하나씩만 업로드 가능합니다");
                      return;
                  }
                  selectFile(files)
              } else {
                  alert("다시 시도해주세요.");
              }
          });
      });

      function selectFile(fileObject) {
          var files = fileObject;
          var file = files[0];
          console.log(file);

          var formData = new FormData();
          formData.append("file", file);
          console.log(formData);

          $.ajax({
              url: '/user/fileUpload', // Controller에 설정한 url
              processData: false,
              contentType: false,
              data: formData,
              type: 'POST',
              success: function (result) {
                  console.log(result);

                  $('#drop_zone').html('<img src="'+result+'" style="width: 100%; height: auto; object-fit: cover;">');
                  $('#userPhoto').val(result);

              }
          });
      }
      //모달 닫힐때 폼 초기화
      $(document).ready(function() {
          // 모달이 완전히 숨겨진 후에 발생하는 이벤트를 이용
          $('#addUserModal').on('hidden.bs.modal', function(e) {
              // 'addUserForm' 폼의 모든 입력 필드를 초기화
              $('#addUserForm')[0].reset();

              $("#sendSms").text("인증번호전송").css({
                  "color": "white"
              });  // 텍스트 색상과 폰트 크기 변경
              $("#sendSms").prop("disabled", false);

              $("#checkId").text("");
              $("#checkPwd").text("");
              $("#checkNickname").text("");
              $("#checkPhone").text("");
              $("#checkPhCodeConfirm").text("");

          });
      });

  </script>

</body>
</html>
