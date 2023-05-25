<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <title>MoTrip 회원가입</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>


  <style>
    .selfIntroText {
      width: 300px;
      height:100px;
    }

    .input-text {
      font-size: 12px;
    }
  </style>

    <script type="text/javascript">

      //가입
      $(function() {

        $( "#commit" ).on("click" , function() {

          var value = "";
          if( $("input:text[name='ssn1']").val() != ""  &&  $("input:text[name='ssn2']").val() != "") {
            var value = $("input[name='ssn1']").val() + "-"
                      + $("input[name='ssn2']").val();
          }

          $("input:hidden[name='ssn']").val( value );

          $("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();

        });
      });

      //인증번호 클릭시 인증번호 입력창 생성
      $(document).ready(function() {

        $("#sendSms").on("click", function() {
          $("#PhCodeGroup").show();
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

      //주소찾기 API


    </script>
</head>

<body>

  <!-- 회원가입 모달 -->
  <div id="addUserModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- 회원가입 모달 내용 -->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">회원 가입</h4>
        </div>

        <div class="modal-body">

          <form class="form-horizontal">

            <div class="form-group">
              <label for="modalUserId" class="col-sm-4 control-label">아 이 디<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="userId" id="modalUserId"  placeholder="아이디" required>
              </div>
            </div>

            <div class="form-group">
              <label for="modalPwd" class="col-sm-4 control-label">비밀번호<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="password" class="form-control" name="pwd" id="modalPwd" placeholder="비밀번호" required>
              </div>
            </div>

            <div class="form-group">
              <label for="pwdConfirm" class="col-sm-4 control-label">비밀번호 확인<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="password" class="form-control" name="pwdConfrim" id="pwdConfirm" placeholder="비밀번호확인" required>
              </div>
            </div>

            <div class="form-group">
              <label for="nickname" class="col-sm-4 control-label">닉 네 임<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="nickname" id="nickname" placeholder="닉네임" required>
              </div>
            </div>

            <div class="form-group">
              <label for="userName" class="col-sm-4 control-label">이   름<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="userName" id="userName" placeholder="이름" required>
              </div>
            </div>

            <div class="form-group">
              <label for="phone" class="col-sm-4 control-label">전화번호<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="phone" id="phone" placeholder="01012345678" required maxlength="11">
                <button type="button" class="btn btn-primary" id="sendSms">인증번호전송</button>
              </div>
            </div>

            <!-- sms인증번호 입력폼 ==> 평상시 숨김 -->
            <div class="form-group" id="PhCodeGroup" style="display: none;">
              <label for="phCodeConfirm" class="col-sm-4 control-label">전화번호 인증</label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="phCodeConfirm" id="phCodeConfirm" placeholder="발송된 인증번호 입력">
                <button type="button" class="btn btn-primary" id="confirmPhCode">확인</button>
                <button type="button" class="btn btn-primary" id="resendPhCode">재전송</button>
              </div>
            </div>

            <div class="form-group">
              <label for="addr" class="col-sm-4 control-label">주   소<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="addr" id="addr" placeholder="우편번호찾기 사용" required>
                <input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기">
              </div>
            </div>

            <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
              <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
            </div>

            <div class="form-group">
              <label for="addrDetail" class="col-sm-4 control-label">상세주소<span style="color:red"> *</span></label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="addrDetail" id="addrDetail" placeholder="상세주소" required>
              </div>
            </div>

            <div class="form-group">
              <label for="email" class="col-sm-4 control-label">이메일</label>
              <div class="col-sm-6">
                <input type="text" class="form-control" name="email" id="email" placeholder="bitcmap@motrip.com">
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-4 control-label">주민등록번호<span style="color:red"> *</span></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-4">
                    <input type="text" class="form-control input-text" name="ssn1" id="ssn1" placeholder="앞6자리+뒤1" required maxlength="6">
                  </div>
                  <div>
                    -
                  </div>
                  <div class="col-sm-2">
                  <input type="text" class="form-control" name="ssn2" id="ssn2" required maxlength="1">
                  </div>
                  <input type="hidden" name="ssn"  />
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="selfIntro" class="col-sm-4 control-label">자기소개</label>
              <div class="col-sm-6">
                <input type="text" class="form-control selfIntroText input-text" name="selfIntro" id="selfIntro" placeholder="300자 이내 자기소개" maxlength="300">
              </div>
            </div>

            <div class="form-group">
              <label for="uploadFile" class="col-sm-4 control-label">회원사진등록</label>
              <div class="col-sm-6">
              <input type="file" id="uploadFile" name="uploadFile">
              </div>
            </div>


            <div class="form-group">
              <label class="col-sm-12 control-label">자기소개 공개여부</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="isSelfIntroPublic" id="selfIntroPublic" value="1">
                <label class="form-check-label" for="selfIntroPublic">공개</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="isSelfIntroPublic" id="selfIntroPrivate" value="0" checked>
                <label class="form-check-label" for="selfIntroPrivate">비공개</label>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-12 control-label">회원사진 공개여부</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="isUserPhotoPublic" id="userPhotoPublic" value="1">
                <label class="form-check-label" for="selfIntroPublic">공개</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="isUserPhotoPublic" id="userPhotoPrivate" value="0" checked>
                <label class="form-check-label" for="selfIntroPrivate">비공개</label>
              </div>
            </div>

            <!-- 추가 필요한 폼 요소들 -->
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" id="commit">가입</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>

    </div>
  </div>

</body>
</html>
