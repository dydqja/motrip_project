<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <title>네이버 회원 추가정보 입력</title>

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

    #drop_zone {
        width: 150px;
        height: 100px;
        padding: 10px;
        border: 2px dashed #bbb;
        border-radius: 20px;
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

        //가입
        $(function() {

            $( "#commit" ).on("click" , function() {
                fncAddUser();
            });
        });

        function fncAddUser() {

            var nickname = $("input[name='nickname']").val();

            if(nickname == null || nickname.length <1 || nicknameChecked == false ){
                console.log("닉네임 유효성 체크 결과 : " +nickname);

                $('#nickname').focus().addClass('shake');
                setTimeout(function () {
                    $('#nickname').removeClass('shake');
                }, 1000);
                return;
            }

            $("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
        }


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

        //닉네임 중복체크
        let nicknameChecked = false; // 중복 확인을 거쳤는지 확인
        $(document).ready(function() {

            $("#nickname").keyup(function () { // 아이디를 입력할때 마다 중복검사 실행

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

    <div>
        여기는 네이버유저 회원가입 화면이다.
    </div>

    <form class="form-horizontal">

    <div class="form-group">
        <label for="nickname" class="col-sm-4 control-label">닉 네 임<span style="color:red"> *</span></label>
        <div class="col-sm-6">
            <input type="text" class="form-control" name="nickname" id="nickname" placeholder="닉네임" required>
            <span id="checkNickname"></span>
        </div>
    </div>

    <div class="form-group">
        <label  class="col-sm-4 control-label">주   소<span style="color:red"> *</span></label>
        <div class="col-sm-6">
            <input type="button" onclick="sample3_execDaumPostcode()" value="주소 찾기">
            <input type="text" id="sample3_address" name="addr" placeholder="주소">
        </div>
    </div>

    <div id="wrap" style="display:none;border:1px solid;width:450px;height:300px;margin:5px 0;position:relative">
        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
    </div>

    <div class="form-group">
        <label for="sample3_detailAddress" class="col-sm-4 control-label">상세주소</label>
        <div class="col-sm-6">
            <input type="text" class="form-control" name="addrDetail" id="sample3_detailAddress" placeholder="상세주소" required>
        </div>
    </div>

    <div class="form-group">
        <label for="selfIntro" class="col-sm-4 control-label">자기소개</label>
        <div class="col-sm-6">
            <input type="text" class="form-control selfIntroText input-text" name="selfIntro" id="selfIntro" placeholder="300자 이내 자기소개" maxlength="300">
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
            <input class="form-check-input" type="radio" name="selfIntroPublic" id="selfIntroPublic" value="true">

            <label class="form-check-label" for="selfIntroPublic">공개</label>
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="selfIntroPublic" id="selfIntroPrivate" value="false" checked>
            <label class="form-check-label" for="selfIntroPrivate">비공개</label>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-12 control-label">회원사진 공개여부</label>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="userPhotoPublic" id="userPhotoPublic" value="true">
            <label class="form-check-label" for="userPhotoPublic">공개</label>
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="userPhotoPublic" id="userPhotoPrivate" value="false" checked>
            <label class="form-check-label" for="userPhotoPrivate">비공개</label>
        </div>
        <input type="hidden" name="userId" value="${user.userId}">
        <input type="hidden" name="userName" value="${user.userName}">
        <input type="hidden" name="phone" value="${user.phone}">
        <input type="hidden" name="gender" value="${user.gender}">
        <input type="hidden" name="age" value="${user.age}">

    </div>

</form>

    <div class="footer">
        <button type="button" class="btn btn-default" id="commit">가입</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
    </div>

</body>
</html>
