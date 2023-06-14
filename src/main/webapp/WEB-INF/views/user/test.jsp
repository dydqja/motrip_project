<%--
  Created by IntelliJ IDEA.
  User: LG
  Date: 2023-06-14
  Time: 오전 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

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
    <input type="hidden" name="ssn"  />
  </div>

  <div class="form-group text-left">
    <div style="margin-right: 20%; ">
      <label for="selfIntro" class="label label-primary">자기소개</label>

      <div class="btn-group btn-group-toggle" data-toggle="buttons">
        <label class="btn btn-secondary active">
          <input type="radio" name="selfIntroPublic" id="selfIntroPublic" value="true" autocomplete="off" checked> 공개
        </label>
        <label class="btn btn-secondary">
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

    <div class="btn-group btn-group-toggle" data-toggle="buttons">
      <label class="btn btn-secondary active">
        <input type="radio" name="userPhotoPublic" id="userPhotoPublic" value="true" autocomplete="off" checked> 공개
      </label>
      <label class="btn btn-secondary">
        <input type="radio" name="userPhotoPublic" id="userPhotoPrivate" value="false" autocomplete="off"> 비공개
      </label>
    </div>

    <div id="drop_zone" name="userPhoto" style="margin-top: 10px; font-size: 16px;">사진 파일을 올려주세요</div>

  </div>

  <div class="form-group text-left">
    <label for="drop_zone" class="label label-primary">SMS수신동의</label>

    <div class="btn-group btn-group-toggle" data-toggle="buttons">
      <label class="btn btn-secondary active">
        <input type="radio" name="gettingSmsAlarm" id="SmsAlarmYes" value="true" autocomplete="off" checked> 동의
      </label>
      <label class="btn btn-secondary">
        <input type="radio" name="gettingSmsAlarm" id="SmsAlarmNo" value="false" autocomplete="off"> 비동의
      </label>
    </div>
  </div>

</form>

<button type="button" class="btn btn-sm btn-primary hvr-grow" id="addUserModalCommit" style="background-color: #FFB347;">가입</button>

</body>

<script type="text/javascript">

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




    $('input[name="userPhoto"]').val(fileRoute);

    swal({
      title: "회원 가입이 완료되었습니다.",
      text: "여행을 떠나보세요",
      icon: "success",
      button: "확인",

    }).then((value) => {
      $("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
    });
  }

</script>
</html>
