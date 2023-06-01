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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

    <!-- Bootstrap Dropdown Hover CSS -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

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

            if("${sessionScope.user.userId}" != "${user.userId}") {
                blacklistState();
            }
        });

        function evaluateButtonState() {

            console.log("${sessionScope.user.userId}");
            console.log("${user.userId}");

            $.ajax({
                url: "/user/evaluateState",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${user.userId}"
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

            console.log("${sessionScope.user.userId}");
            console.log("${user.userId}");

            $.ajax({
                url: "/user/blacklistState",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${user.userId}"
                }),
                dataType: "text",
                success: function (response) {

                    if (response == "${user.userId}") {
                        console.log("response ����  null,'',undefined �� �� �����");
                        $("#blacklist").text() === "�����"

                    } else {
                        console.log("response ���� null�� �ƴ� �� �����");
                        $("#blacklist").text() === "���ϱ�"
                    }
                },
                error: function (error) {
                    alert("����");
                }
            });
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
                    getUserId: "${user.userId}"
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
                        evaluatedUserId: "${user.userId}",
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
                        evaluatedUserId: "${user.userId}",
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
                        getUserId: "${user.userId}"
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
                            blacklistedUserId: "${user.userId}"
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
                            blacklistedUserId: "${user.userId}"
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

        //ȸ����������
        $( function() {

            $("#updateUser").on("click" , function() {

                $('#updateUserModal').modal('show');

            });
        });







        //============= ȸ���������� Event  ó�� =============
        <%--$(function() {--%>
        <%--    //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)--%>
        <%--    $( "button" ).on("click" , function() {--%>
        <%--        self.location = "/user/updateUser?userId=${user.userId}"--%>
        <%--    });--%>
        <%--});--%>

    </script>

</head>

<body>


<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
<div class="container">

    <div class="page-header">
        <h3 class=" text-info">ȸ���󼼺���</h3>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2"><strong>${user.userId}</strong>��, ȯ���մϴ�!</div>
    </div>

    <%-- gender => M == ����, F == ����   --%>
    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>����ǥ�úκ�</strong></div>
        <c:if test="${user.gender.equals('M')}">
            <div class="col-xs-8 col-md-4">���� ���� ���ڶ�� ������</div>
        </c:if>
        <c:if test="${user.gender.equals('F')}">
            <div class="col-xs-8 col-md-4">���� ���� ���ڶ�� ������</div>
        </c:if>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>�ڱ�Ұ� ǥ�úκ�</strong></div>
        <div class="col-xs-8 col-md-4">${user.selfIntro}</div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>�����ʻ��� ǥ�úκ�</strong></div>
        <div class="col-xs-8 col-md-4">${user.userPhoto}</div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>ȸ�������� ǥ�úκ�</strong></div>
        <div class="col-xs-8 col-md-4" id="evaluateCount">${user.evaluateCount}</div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-2 "><strong>����ȸ��������� 'ȸ��������ư', Ÿȸ��������� '���߰���ư'</strong></div>
        <c:if test="${sessionScope.user.userId eq user.userId}">
            <div>
                <button type="button" class="btn btn-default" name="updateUser" id="updateUser">ȸ����������</button>
                <button type="button" class="btn btn-default" name="listBlack" id="listBlack">������Ʈ��Ϻ���</button>
            </div>
        </c:if>
        <c:if test="${sessionScope.user.userId ne user.userId}">
            <div>
                <button type="button" class="btn btn-default" name="blacklist" id="blacklist">���ϱ�</button>
            </div>
        </c:if>
    </div>

    <div class="row">
        <button type="button" class="btn btn-default" name="likeUser" id="likeUser">���ƿ�</button>
        <button type="button" class="btn btn-primary" name="likeUserCancle" id="likeUserCancle">���ƿ����</button>
    </div>

    <div class="row">
        <button type="button" class="btn btn-default" name="disLikeUser" id="disLikeUser">�Ⱦ��</button>
        <button type="button" class="btn btn-primary" name="disLikeUserCancle" id="disLikeUserCancle">�Ⱦ�����</button>
    </div>



</div>

<!-- ȸ���������� ��� ��Ŭ��� -->
<jsp:include page="addUserModal.jsp"/>


</body>

</html>