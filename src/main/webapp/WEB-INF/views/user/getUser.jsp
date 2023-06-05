<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="UTF-8"></script>

    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body {
            padding-top : 50px;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">


        //페이지가 로드될 시 실행되어 좋아요,싫어요 버튼 state 값을 가져온다.
        $(document).ready(function(){

            evaluateButtonState();

            if("${sessionScope.user.userId}" != "${modelUser.userId}") {
                blacklistState();
            }
        });

        function evaluateButtonState() {

            console.log("${sessionScope.user.userId}");
            console.log("${modelUser.userId}");

            $.ajax({
                url: "/user/evaluateState",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${modelUser.userId}"
                }),
                dataType: "text",
                success: function (response) {

                    if (response == "0" || response == "") {
                        console.log("response 값 0이거나 null일 때 실행됨");
                        $("#likeUserCancle").hide();
                        $("#disLikeUserCancle").hide();
                        $("#likeUser").show();
                        $("#dislikeUser").show();

                    } else if (response == "1") {
                        console.log("response 값 1 일 때 실행됨");
                        $("#likeUser").hide();
                        $("#disLikeUserCancle").hide();
                        $('#disLikeUser').prop('disabled', true);
                        $("#likeUserCancle").show();

                    } else {
                        console.log("response 값 -1 일 때 실행됨");
                        $("#likeUserCancle").hide();
                        $("#disLikeUser").hide();
                        $("#likeUser").prop('disabled', true);
                        $("#disLikeUserCancle").show();
                    }
                },
                error: function (error) {
                    alert("실패");
                }
            });
        }

        function blacklistState() {

            if("${sessionScope.user.userId}" != "${modelUser.userId}") {

            console.log("${sessionScope.user.userId}");
            console.log("${modelUser.userId}");

            $.ajax({
                url: "/user/blacklistState",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${modelUser.userId}"
                }),
                dataType: "text",
                success: function (response) {

                    if (response == "${modelUser.userId}") {
                        console.log("blacklist 값이 있을 때 실행됨  " +response);
                        $("#blacklist").text("블랙취소");

                    } else {
                        console.log("blacklist  값이 없을 때 실행됨  " +response);
                        $("#blacklist").text("블랙하기");
                    }
                },
                error: function (error) {
                    alert("실패");
                }
            });
            }
        }

        $(document).ready(function(){

        //좋아요취소 클릭이벤트
        $("#likeUserCancle").on("click" , function() {

            $.ajax({
                url: "/user/userEvaluateCancle",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${modelUser.userId}"
                }),
                dataType: "text",
                success: function (response) {

                    $("#likeUserCancle").hide();
                    $("#likeUser").show();
                    $("#disLikeUser").prop('disabled', false).show();
                    $("#evaluateCount").text(response);

                    if(response == "") {
                        $("#evaluateCount").text("0");
                    }

                },
                error: function (error) {
                    alert("실패");
                }
            });
        });
        });

        $(document).ready(function(){

            //좋아요 클릭이벤트
            $("#likeUser").on("click" , function() {

                $.ajax({
                    url: "/user/addEvaluation",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        evaluaterId: "${sessionScope.user.userId}",
                        evaluatedUserId: "${modelUser.userId}",
                        isScorePlus: 1
                    }),
                    dataType: "text",
                    success: function (response) {

                        $("#likeUser").hide();
                        $("#likeUserCancle").show();
                        $("#disLikeUser").hide();
                        $("#disLikeUser").prop('disabled', true).show();
                        $("#evaluateCount").text(response);
                    },
                    error: function (error) {
                        alert("실패");
                    }
                });
            });
        });

        $(document).ready(function(){

            //싫어요 클릭이벤트
            $("#disLikeUser").on("click" , function() {

                $.ajax({
                    url: "/user/addEvaluation",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        evaluaterId: "${sessionScope.user.userId}",
                        evaluatedUserId: "${modelUser.userId}",
                        isScorePlus: -1
                    }),
                    dataType: "text",
                    success: function (response) {

                        $("#disLikeUser").hide();
                        $("#disLikeUserCancle").show();
                        $("#likeUser").hide();
                        $("#likeUser").prop('disabled', true).show();
                        $("#evaluateCount").text(response);
                    },
                    error: function (error) {
                        alert("실패");
                    }
                });
            });
        });

        $(document).ready(function(){

            //싫어요취소 클릭이벤트
            $("#disLikeUserCancle").on("click" , function() {

                $.ajax({
                    url: "/user/userEvaluateCancle",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        sessionUserId: "${sessionScope.user.userId}",
                        getUserId: "${modelUser.userId}"
                    }),
                    dataType: "text",
                    success: function (response) {

                        $("#disLikeUserCancle").hide();
                        $("#disLikeUser").show();
                        $("#likeUser").prop('disabled', false).show();
                        $("#evaluateCount").text(response);

                        if(response == "") {
                            $("#evaluateCount").text("0");
                        }
                    },
                    error: function (error) {
                        alert("실패");
                    }
                });
            });
        });

        $(document).ready(function(){

            //블랙리스트 추가 클릭이벤트
            $("#blacklist").on("click" , function() {
                if($(this).text() === "블랙하기") {

                    $.ajax({
                        url: "/user/addBlacklist",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({
                            evaluaterId: "${sessionScope.user.userId}",
                            blacklistedUserId: "${modelUser.userId}"
                        }),
                        dataType: "text",
                        success: function (response) {

                            if(response == "") {
                                $("#blacklist").text("블랙취소");
                            }
                        },
                        error: function (error) {
                            alert("실패");
                        }
                    });
                } else if($(this).text() === "블랙취소") {

                    $.ajax({
                        url: "/user/deleteBlacklist",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({
                            evaluaterId: "${sessionScope.user.userId}",
                            blacklistedUserId: "${modelUser.userId}"
                        }),
                        dataType: "text",
                        success: function (response) {

                            $("#blacklist").text("블랙하기");
                        },
                        error: function (error) {
                            alert("실패");
                        }
                    });

                }
            });
        });

        //블랙리스트보기
        $( function() {

            $("#listBlack").on("click" , function() {
                console.log("블랙리스트목록보기 클릭");

                $('#listBlackModal').modal('show');
                console.log("'#listBlackModal' 모달이 표시되었어야 합니다.");
            });
        });

        //회원정보수정
        $( function() {

            $("#updateUser").on("click" , function() {

                $('#updateUserModal').modal('show');
            });
        });

        //회원탈퇴확인
        $( function() {

            $("#secessionUser").on("click" , function() {

                $('#secessionUserModal').modal('show');
            });
        });

    </script>

</head>

<body>


<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">회원상세보기</h3>
    </div>


    <div class="row">
        <c:if test="${sessionScope.user.userId eq modelUser.userId}" >
            <div class="col-xs-4 col-md-2"><strong id="nickname1">${modelUser.nickname}</strong>님, 환영합니다!</div>
        </c:if>
        <c:if test="${sessionScope.user.userId ne modelUser.userId}" >
            <div class="col-xs-4 col-md-2"><strong id="nickname2">${modelUser.nickname}</strong>님의 회원정보입니다.</div>
        </c:if>
    </div>

    <%-- gender => M == 남자, F == 여자   --%>
    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>성별표시부분</strong></div>
        <c:if test="${modelUser.gender.equals('M')}">
            <div class="col-xs-8 col-md-4">대충 성별 남자라는 아이콘</div>
        </c:if>
        <c:if test="${modelUser.gender.equals('F')}">
            <div class="col-xs-8 col-md-4">대충 성별 여자라는 아이콘</div>
        </c:if>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>자기소개 표시부분</strong></div>

            <div class="col-xs-8 col-md-4" ><span id="selfIntro">
                 <c:if test="${modelUser.selfIntroPublic == true}">
                    ${user.selfIntro}
                 </c:if>
                 <c:if test="${modelUser.selfIntroPublic == false}">
                    비공개정보입니다.
                 </c:if>
                </span></div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>프로필사진 표시부분</strong></div>

        <div class="col-xs-8 col-md-4"><span id="userPhoto">
            <c:if test="${modelUser.userPhotoPublic == true}">
                ${modelUser.userPhoto}
            </c:if>
            <c:if test="${modelUser.userPhotoPublic == false}">
                비공개정보입니다.
            </c:if>
            </span></div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>회원평가점수 표시부분</strong></div>
        <div class="col-xs-8 col-md-4" id="evaluateCount">${modelUser.evaluateCount}</div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>본인회원정보라면 '회원수정버튼', 타회원정보라면 '블랙추가버튼'</strong></div>
        <c:if test="${sessionScope.user.userId eq modelUser.userId}">
            <div>
                <button type="button" class="btn btn-default" name="updateUser" id="updateUser">회원정보수정</button>
                <button type="button" class="btn btn-default" name="listBlack" id="listBlack">블랙리스트목록보기</button>
                <button type="button" class="btn btn-default" name="secessionUser" id="secessionUser">회원탈퇴</button>
            </div>
        </c:if>
        <c:if test="${sessionScope.user.userId ne modelUser.userId}">
            <div>
                <button type="button" class="btn btn-default" name="blacklist" id="blacklist">블랙하기</button>
            </div>
        </c:if>
    </div>

    <div class="row">
        <c:if test="${sessionScope.user.userId ne modelUser.userId}">
            <button type="button" class="btn btn-default" name="likeUser" id="likeUser">좋아요</button>
            <button type="button" class="btn btn-primary" name="likeUserCancle" id="likeUserCancle">좋아요취소</button>
        </c:if>
    </div>

    <div class="row">
        <c:if test="${sessionScope.user.userId ne modelUser.userId}">
            <button type="button" class="btn btn-default" name="disLikeUser" id="disLikeUser">싫어요</button>
            <button type="button" class="btn btn-primary" name="disLikeUserCancle" id="disLikeUserCancle">싫어요취소</button>
        </c:if>
    </div>





</div>

<!-- 회원정보수정 모달 인클루드 -->
<jsp:include page="updateUserModal.jsp"/>

<!-- 블랙리스트 모달 인클루드 -->
<jsp:include page="listBlackModal.jsp"/>

<!-- 회원탈퇴확인 모달 인클루드 -->
<jsp:include page="secessionUserModal.jsp"/>


</body>

</html>