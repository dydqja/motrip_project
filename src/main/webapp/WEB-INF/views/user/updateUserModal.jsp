<%@ page contentType="text/html;charset=UTF-8" language="java" %>






<!DOCTYPE html>

<html lang="ko">

<head>
    <title>MoTrip 회원가입</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


  <style>
    .selfIntroText {
      width: 300px;
      height:100px;
    }

    .input-text {
      font-size: 12px;
    }

    #drop_zone {
      width: 150px;
      height: 100px;
      padding: 10px;
      border: 2px dashed #bbb;
      border-radius: 20px;
    }

    .previewImage {
      width: 75px !important;
      height: auto !important;
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

    <script type="text/javascript">

      //수정버튼

      $(function() {

        $( "#commit" ).on("click" , function(e) {
          e.preventDefault();

          var formData = new FormData($('form')[0]);
          for (var pair of formData.entries()) {
            console.log(pair[0] + ', ' + pair[1]);
          }
            fncUpdateUser(formData);
        });
      });

      function fncUpdateUser(formData) {


        var currentPwd = formData.get('currentPwd');
        var updatePwd = formData.get('updatePwd');
        var updatePwdConfirm = formData.get('pwd');
        var nickname = formData.get('nickname');
        var phone = formData.get('phone');
        var addr = formData.get('addr');
        var addrDetail = formData.get('addrDetail');
        var email = formData.get('email');
        var selfIntro = formData.get('selfIntro');
        var userPhoto = formData.get('userPhoto');
        var isSelfIntroPublic = formData.get('isSelfIntroPublic');
        var isSelfPhotoPublic = formData.get('isSelfPhotoPublic');

        //전화번호 변경했는지 그대로인지 체크
        if (updatePwd || updatePwdConfirm) {
          //변경했다면, 현재비밀번호 유효성 체크
          if(currentPwd == null || currentPwdCheck == false ){
            console.log("현재비밀번호 =" + currentPwdCheck);
            $('#currentPwd').focus().addClass('shake');
            setTimeout(function () {
              $('#currentPwd').removeClass('shake');
            }, 1000);
            return;
          }
          //변경했다면, 새로운비밀번호 유효성 체크
          if(updatePwdConfirm == null || updatePwdConfirmChecked == false ){
            console.log("새로운비밀번호 =" + updatePwdConfirmChecked);
            console.log("updatePwdConfirm = "+updatePwdConfirm);
            $('#updatePwdConfirm').focus().addClass('shake');
            setTimeout(function () {
              $('#updatePwdConfirm').removeClass('shake');
            }, 1000);
            return;
          }
          //변경했다면, 새로운비밀번호 확인했는지 유효성 체크
          if(updatePwdChecked == false ){
            console.log("새로운 비밀번호 확인 =" + updatePwdChecked);
            $('#updatePwd').focus().addClass('shake');
            setTimeout(function () {
              $('#updatePwd').removeClass('shake');
            }, 1000);
            return;
          }
        }
        //닉네임 유효성 체크
        if(nickname == null || nickname.length <1 || nicknameChecked == false ){
          console.log("닉네임 유효성 체크 결과 : " +nickname);

          $('#modalNickname').focus().addClass('shake');
          setTimeout(function () {
            $('#modalNickname').removeClass('shake');
          }, 1000);
          return;
        }
        //전화번호 변경했는지 그대로인지 체크
        if (!isPhoneNumberVerified) {

          $('#phone').focus().addClass('shake');
          setTimeout(function () {
            $('#phone').removeClass('shake');
          }, 1000);
          return;
        }
        //주소 체크
        if(addr == null || addr.length <1) {

          $('#sample3_address').focus().addClass('shake');
          setTimeout(function () {
            $('#sample3_address').removeClass('shake');
          }, 1000);
          return;
        }
        //상세주소 체크
        if(addrDetail == null || addrDetail.length <1) {
          console.log(addrDetail);

          $('#sample3_detailAddress').focus().addClass('shake');
          setTimeout(function () {
            $('#sample3_detailAddress').removeClass('shake');
          }, 1000);
          return;
        }

        $('input[name="userPhoto"]').val(fileRoute);

        $.ajax({
          url: "/user/updateUser",
          type: 'POST',
          data: formData,
          success: function (data) {
            console.log('회원정보 수정 성공')
            $('#updateUserModal').modal('hide');
            $('#nickname1').text(data.nickname);
            $('#nickname2').text(data.nickname);

            if(data.selfIntroPublic) {
              console.log("data.selfIntroPublic -> " +data.selfIntroPublic);
              $('#selfIntro').text(data.selfIntro).show();
            } else {
              console.log("data.selfIntroPublic -> " +data.selfIntroPublic);
              $('#selfIntro').text("비공개정보입니다.").show();
            }

            if(data.userPhotoPublic) {
              console.log("data.userPhotoPublic -> " +data.userPhotoPublic);
              $('#userPhoto').text(data.userPhoto).show();
            } else {
              console.log("data.userPhotoPublic -> " +data.userPhotoPublic);
              $('#userPhoto').text("비공개정보입니다.").show();
            }

          },
          error: function (error) {
            console.log('오류 발생: ', error);
          },
          cache: false,
          contentType: false,
          processData: false
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

      $(document).ready(function() {
        var phone = $('#phone').val();
        phone = phone.replace(/-/g, '');
        $('#phone').val(phone);
      });

      //ESC 누를시 모달창 종료
      $(document).keyup(function(e) {
        if (e.key === "Escape") {
          $('#updateUserModal').modal('hide');
        }
      });

      //비밀번호 변경 클릭시 비밀번호 변경창 생성
      $(document).ready(function() {
        var smsConfirmNum = null;

        $("#modalUpdatePwd").on("click", function() {

          $("#pwdUpdateGroup").toggle();
        });
      });

      //현재 비밀번호와 입력 비밀번호가 맞는지 체크
      let currentPwdCheck=false;
      $(document).ready(function() {

        $("#currentPwd").focusout(function() { // 현재 비밀번호 텍스트박스에서 포커스 아웃되면 실행
          currentPwd($(this).val())
        })
        function currentPwd(currentPwd){
          if(currentPwd == ""){
            $("#currentPwdCheck").text("비밀번호를 입력해주세요").css({
              'color': 'red',
              'font-size': '10px' // 문구 출력
            });
            currentPwdCheck = false;
            return; // 아직 입력된 상태가 아니라면 아무런 문구를 출력하지 않는다
          }

          if($('#currentPwd').val() != '${user.pwd}'){
            // 입력한 비밀번호와 현재 비밀번호가 일치하지 않는다면
            $("#currentPwdCheck").text('비밀번호가 일치하지 않습니다').css({
              'color': 'red',
              'font-size': '10px' // 문구 출력
            });
            $('#currentPwd').val(''); // 값을 비움
            $('#currentPwd').focus(); // 포인터를 현재비밀번호 로 맞춘다
            currentPwdCheck=false;
          }
          else{
            $("#currentPwdCheck").text('비밀번호가 일치합니다').css({
              'color': 'green',
              'font-size': '10px' // 문구 출력
            });
            currentPwdCheck=true;
          }
          // setAble();
        }
      });

      //변경비밀번호와 변경비밀번호 일치하는지 체크
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

      //현재 비밀번호와 변경 비밀번호가 같은지 확인(같으면 안됨)
      let updatePwdChecked=false;
      $(document).ready(function() {

        $("#updatePwd").focusout(function() { // 비밀번호 확인 텍스트박스에서 포커스 아웃되면 실행
          updatePwd($(this).val())
        })
        function updatePwd(updatePwd){
          if(updatePwd == ""){
            $("#updatePwdCheck").text("");
            return; // 아직 입력된 상태가 아니라면 아무런 문구를 출력하지 않는다
          }

          if($('#currentPwd').val()!=$('#updatePwd').val()){
            // 만약 pw1과 pw2가 일치하지 않는다면
            $("#updatePwdCheck").text('변경 가능한 비밀번호입니다').css({
              'color': 'green',
              'font-size': '10px' // 문구 출력
            });

            updatePwdChecked=true;
          }
          else{
            $("#updatePwdCheck").text('기존 비밀번호와 일치합니다').css({
              'color': 'red',
              'font-size': '10px' // 문구 출력
            });

            $('#updatePwd').val(''); // 값을 비움
            $('#updatePwd').focus(); // 포인터를 pw1 로 맞춘다
            updatePwdChecked=false;
          }
          // setAble();
        }
      });

      //닉네임 중복체크
      let nicknameChecked = true;
      let currentNickname = '${sessionScope.user.nickname}';
      $(document).ready(function() {

        $("#modalNickname").keyup(function () { // 아이디를 입력할때 마다 중복검사 실행

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

              if(currentNickname == nickname) {

                $("#checkNickname").text('사용 가능한 닉네임입니다.').css({
                  'color': 'green',
                  'font-size': '10px'
                });
                nicknameChecked = true;
              } else if (result == 0) {
                $("#checkNickname").text('사용할 수 없는 닉네임입니다.').css({
                  'color': 'red',
                  'font-size': '10px'
                });
                nicknameChecked = false; // id체크 true
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

      let isPhoneNumberVerified = true;
      //인증번호 클릭시 인증번호 입력창 생성
      $(document).ready(function() {
        var smsConfirmNum = null;

        $("#phoneNumber").on("input", function() {
          isPhoneNumberVerified = false;
        });


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
            isPhoneNumberVerified = true;

            $("#PhCodeGroup").show();
          }).fail(function(error) {

          });
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

      //모달창 생성시 모달창에 포커스 준다
      $('#addUserModal').on('shown.bs.modal', function () {
        $('#modalUserId').trigger('focus')
      })



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
            alert("ERROR");
          }
        });
      });

      var fileRoute;
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
            $('#userPhoto').val(result);

            // document.querySelector('#imagePreview').src = result;


          }
        });
      }


    </script>
</head>

<body>

  <!-- 회원가입 모달 -->
  <div id="updateUserModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- 회원가입 모달 내용 -->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">회원정보 수정</h4>
        </div>

        <div class="modal-body">

          <form class="form-horizontal">

            <div class="form-group">
              <label for="modalUpdateUserId" class="col-sm-4 control-label">아 이 디</label>
              <div class="col-sm-6">
                <div id="modalUpdateUserId">${user.userId}</div>
                <input type="hidden" name="userId" id="userId" value="${user.userId}"  />
              </div>
            </div>

            <div class="form-group">
              <label for="modalUpdatePwd" class="col-sm-4 control-label">비밀번호</label>
              <div class="col-sm-6">
                <input type="button" class="btn btn-primary" name="pwd" id="modalUpdatePwd" value="비밀번호 변경">
              </div>
            </div>

            <!-- 비밀번호 변경 입력폼 ==> 평상시 숨김 -->
            <div class="form-group" id="pwdUpdateGroup" style="display: none;">
              <label for="updatePwd" class="col-sm-4 control-label">비밀번호 변경</label>
              <div class="col-sm-6">
                <input type="password" class="form-control" name="currentPwd" id="currentPwd" placeholder="현재 비밀번호">
                <span id="currentPwdCheck"></span>
                <input type="password" class="form-control" name="updatePwd" id="updatePwd" placeholder="변경 비밀번호">
                <span id="updatePwdCheck"></span>
                <input type="password" class="form-control" name="pwd" id="updatePwdConfirm" placeholder="변경 비밀번호 확인">
                <span id="updatePwdConfirmCheck"></span>
              </div>
            </div>

            <div class="form-group">
              <label for="modalNickname" class="col-sm-4 control-label">닉 네 임</label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="nickname" id="modalNickname" placeholder="닉네임" value="${user.nickname}">
                <span id="checkNickname"></span>
              </div>
            </div>

            <div class="form-group">
              <label for="modalUpdateUserName" class="col-sm-4 control-label">이   름</label>
              <div class="col-sm-6">
                <div id="modalUpdateUserName">${user.userName}</div>
              </div>
            </div>

            <div class="form-group">
              <label for="phone" class="col-sm-4 control-label">전화번호</label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="phone" id="phone" placeholder="01012345678" value="${user.phone}" required maxlength="11">
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

            <div class="form-group">
              <label  class="col-sm-4 control-label">주   소<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="button" onclick="sample3_execDaumPostcode()" value="주소 찾기">
                <input type="text" id="sample3_address" name="addr" placeholder="주소" value="${user.addr}">
              </div>
            </div>

            <div id="wrap" style="display:none;border:1px solid;width:450px;height:300px;margin:5px 0;position:relative">
              <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
            </div>

            <div class="form-group">
              <label for="sample3_detailAddress" class="col-sm-4 control-label">상세주소</label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="addrDetail" id="sample3_detailAddress" placeholder="상세주소" value="${user.addrDetail}">
              </div>
            </div>

            <div class="form-group">
              <label for="email" class="col-sm-4 control-label">이메일</label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="email" id="email" placeholder="bitcmap@motrip.com" value="${user.email}">
              </div>
            </div>

            <div class="form-group">
              <label for="selfIntro" class="col-sm-4 control-label">자기소개</label>
              <div class="col-sm-6">
                <input type="text" class="form-control selfIntroText input-text" name="selfIntro" id="selfIntro" placeholder="300자 이내 자기소개" maxlength="300" value="${user.selfIntro}">
              </div>
            </div>

            <div class="form-group">
              <label for="drop_zone" class="col-sm-4 control-label">회원사진등록</label>
              <div id="drop_zone" name="userPhoto">사진 파일을 올려주세요</div>
              <input type="hidden" name="userPhoto" id="userPhoto"  />
              <!--
              <img class="previewImage" id="imagePreview" src="" alt="Image preview">
              -->
            </div>

            <div class="form-group">
              <label class="col-sm-12 control-label">자기소개 공개여부</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="selfIntroPublic" id="selfIntroPublicButton" value="true">

                <label class="form-check-label" for="selfIntroPublicButton">공개</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="selfIntroPublic" id="selfIntroPrivateButton" value="false" >
                <label class="form-check-label" for="selfIntroPrivateButton">비공개</label>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-12 control-label">회원사진 공개여부</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="userPhotoPublic" id="userPhotoPublicButton" value="true">
                <label class="form-check-label" for="userPhotoPublicButton">공개</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="userPhotoPublic" id="userPhotoPrivateButton" value="false" >
                <label class="form-check-label" for="userPhotoPrivateButton">비공개</label>
              </div>
            </div>

          </form>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="commit">수정</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>

    </div>
  </div>

</body>
</html>
