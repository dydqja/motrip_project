<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">

    <!-- ���� : http://getbootstrap.com/css/   ���� -->
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


        //�������� �ε�� �� ����Ǿ� ���ƿ�,�Ⱦ�� ��ư state ���� �����´�.
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
                        console.log("response �� 0�̰ų� null�� �� �����");
                        $("#likeUserCancle").hide();
                        $("#disLikeUserCancle").hide();
                        $("#likeUser").show();
                        $("#dislikeUser").show();

                    } else if (response == "1") {
                        console.log("response �� 1 �� �� �����");
                        $("#likeUser").hide();
                        $("#disLikeUserCancle").hide();
                        $('#disLikeUser').prop('disabled', true);
                        $("#likeUserCancle").show();

                    } else {
                        console.log("response �� -1 �� �� �����");
                        $("#likeUserCancle").hide();
                        $("#disLikeUser").hide();
                        $("#likeUser").prop('disabled', true);
                        $("#disLikeUserCancle").show();
                    }
                },
                error: function (error) {
                    alert("����");
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
                        console.log("blacklist ���� ���� �� �����  " +response);
                        $("#blacklist").text("�����");

                    } else {
                        console.log("blacklist  ���� ���� �� �����  " +response);
                        $("#blacklist").text("���ϱ�");
                    }
                },
                error: function (error) {
                    alert("����");
                }
            });
            }
        }

        $(document).ready(function(){

        //���ƿ���� Ŭ���̺�Ʈ
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
                    alert("����");
                }
            });
        });
        });

        $(document).ready(function(){

            //���ƿ� Ŭ���̺�Ʈ
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
                        alert("����");
                    }
                });
            });
        });

        $(document).ready(function(){

            //�Ⱦ�� Ŭ���̺�Ʈ
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
                        alert("����");
                    }
                });
            });
        });

        $(document).ready(function(){

            //�Ⱦ����� Ŭ���̺�Ʈ
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
                        alert("����");
                    }
                });
            });
        });

        $(document).ready(function(){

            //������Ʈ �߰� Ŭ���̺�Ʈ
            $("#blacklist").on("click" , function() {
                if($(this).text() === "���ϱ�") {

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
                                $("#blacklist").text("�����");
                            }
                        },
                        error: function (error) {
                            alert("����");
                        }
                    });
                } else if($(this).text() === "�����") {

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

                            $("#blacklist").text("���ϱ�");
                        },
                        error: function (error) {
                            alert("����");
                        }
                    });

                }
            });
        });

        //������Ʈ����
        $( function() {

            $("#listBlack").on("click" , function() {
                console.log("������Ʈ��Ϻ��� Ŭ��");

                $('#listBlackModal').modal('show');
                console.log("'#listBlackModal' ����� ǥ�õǾ���� �մϴ�.");
            });
        });

        //ȸ����������
        $( function() {

            $("#updateUser").on("click" , function() {

                $('#updateUserModal').modal('show');
            });
        });

        //ȸ��Ż��Ȯ��
        $( function() {

            $("#secessionUser").on("click" , function() {

                $('#secessionUserModal').modal('show');
            });
        });

    </script>

</head>

<body>


<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">ȸ���󼼺���</h3>
    </div>


    <div class="row">
        <c:if test="${sessionScope.user.userId eq modelUser.userId}" >
            <div class="col-xs-4 col-md-2"><strong id="nickname1">${modelUser.nickname}</strong>��, ȯ���մϴ�!</div>
        </c:if>
        <c:if test="${sessionScope.user.userId ne modelUser.userId}" >
            <div class="col-xs-4 col-md-2"><strong id="nickname2">${modelUser.nickname}</strong>���� ȸ�������Դϴ�.</div>
        </c:if>
    </div>

    <%-- gender => M == ����, F == ����   --%>
    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>����ǥ�úκ�</strong></div>
        <c:if test="${modelUser.gender.equals('M')}">
            <div class="col-xs-8 col-md-4">���� ���� ���ڶ�� ������</div>
        </c:if>
        <c:if test="${modelUser.gender.equals('F')}">
            <div class="col-xs-8 col-md-4">���� ���� ���ڶ�� ������</div>
        </c:if>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>�ڱ�Ұ� ǥ�úκ�</strong></div>

            <div class="col-xs-8 col-md-4" >
                <span id="selfIntro">
                 <c:if test="${modelUser.selfIntroPublic == true}">
                    ${user.selfIntro}
                 </c:if>
                 <c:if test="${modelUser.selfIntroPublic == false}">
                    ����������Դϴ�.
                 </c:if>
                </span>
            </div>
    </div>


    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>�����ʻ��� ǥ�úκ�</strong></div>

        <div class="col-xs-8 col-md-4"><span id="userPhoto">
            <c:if test="${modelUser.userPhotoPublic == true}">
                ${modelUser.userPhoto}
            </c:if>
            <c:if test="${modelUser.userPhotoPublic == false}">
                ����������Դϴ�.
            </c:if>
            </span></div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>ȸ�������� ǥ�úκ�</strong></div>
        <div class="col-xs-8 col-md-4" id="evaluateCount">${modelUser.evaluateCount}</div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>����ȸ��������� 'ȸ��������ư', Ÿȸ��������� '���߰���ư'</strong></div>
        <c:if test="${sessionScope.user.userId eq modelUser.userId}">
            <div>
                <button type="button" class="btn btn-default" name="updateUser" id="updateUser">ȸ����������</button>
                <button type="button" class="btn btn-default" name="listBlack" id="listBlack">������Ʈ��Ϻ���</button>
                <button type="button" class="btn btn-default" name="secessionUser" id="secessionUser">ȸ��Ż��</button>
            </div>
        </c:if>
        <c:if test="${sessionScope.user.userId ne modelUser.userId}">
            <div>
                <button type="button" class="btn btn-default" name="blacklist" id="blacklist">���ϱ�</button>
            </div>
        </c:if>
    </div>

    <div class="row">
        <c:if test="${sessionScope.user.userId ne modelUser.userId}">
            <button type="button" class="btn btn-default" name="likeUser" id="likeUser">���ƿ�</button>
            <button type="button" class="btn btn-primary" name="likeUserCancle" id="likeUserCancle">���ƿ����</button>
        </c:if>
    </div>

    <div class="row">
        <c:if test="${sessionScope.user.userId ne modelUser.userId}">
            <button type="button" class="btn btn-default" name="disLikeUser" id="disLikeUser">�Ⱦ��</button>
            <button type="button" class="btn btn-primary" name="disLikeUserCancle" id="disLikeUserCancle">�Ⱦ�����</button>
        </c:if>
    </div>





</div>

<!-- ȸ���������� ��� ��Ŭ��� -->
<jsp:include page="updateUserModal.jsp"/>

<!-- ������Ʈ ��� ��Ŭ��� -->
<jsp:include page="listBlackModal.jsp"/>

<!-- ȸ��Ż��Ȯ�� ��� ��Ŭ��� -->
<jsp:include page="secessionUserModal.jsp"/>


</body>

</html>