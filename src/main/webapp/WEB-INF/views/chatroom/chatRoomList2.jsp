<%--
  Created by IntelliJ IDEA.
  User: sean
  Date: 2023/06/05
  Time: 2:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="com.bit.motrip.domain.*"%>
<!DOCTYPE html>
<html lang="en">

<head>

<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compastible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Mold Discover . HTML Template</title>
    <link rel="icon" type="image/png" href="/assets/img/favicon.png" />

    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">--%>
    <script src="/vendor/jquery/dist/jquery.min.js"></script>
    <script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="/vendor/jquery.ui.touch-punch.min.js"></script>
    <script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>

    <script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
    <script src="/vendor/owlcarousel/owl.carousel.min.js"></script>
    <script src="/vendor/retina.min.js"></script>
    <script src="/vendor/jquery.imageScroll.min.js"></script>
    <script src="/assets/js/min/responsivetable.min.js"></script>
    <script src="/assets/js/bootstrap-tabcollapse.js"></script>


    <script src="/assets/js/min/countnumbers.min.js"></script>
    <script src="/assets/js/main.js"></script>

    <!-- Current Page JS -->
    <script src="/assets/js/min/priceslider.min.js"></script>
    <style>
        .center-div {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .btn-group label:not(:last-child) {
            margin-right: 30px;
        }
    </style>


</head>

<body>
<%--<header class="nav-menu fixed">--%>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%--</header>--%>
<div class="page-img" style="background-image: url('/images/chatRoomImage.jpg');">
    <div class="container">
        <div class="col-sm-8">
            <h1 class="main-head">ChatRoom</h1>
        </div>
        <div class="col-sm-4">
            <ul class="breadcrumb">
                <li><a href=""><span class="icon-home"></span></a>
                </li>
                <li><a href=""><span class="icon-sync"></span></a>
                </li>
            </ul>
        </div>

    </div>
</div>

<main>
    <form>
        <input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId}" >
        <input type="hidden" id="birthYear" value="${sessionScope.user.age}" >
        <input type="hidden" id="gender" value="${sessionScope.user.gender}" >

    <div class="container">
        <div class="row">
            <div class="col-sm-4">

                <div class="sidebar">
                    <div class="border-box">
                        <div class="box-title">ChatRoom Search</div>
                        <div class="input-group">
                            <input type="text" name="searchKeyword" value="" class="form-control" placeholder="Search Site">
                            <div class="input-group-btn">
                                <button class="btn btn-primary" id="search-chatroom">Search</button>
                                <input type="hidden" id="currentPage" name="currentPage" value="0"/>
                            </div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">Gender</div>
                        <div class="left-div" style="width: 150%; height: 100%;">
                            <div class="btn-group" data-toggle="buttons">
<%--                                <label class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="ALL">--%>
<%--                                    <input type="radio" name="gender" id="option1" value="">--%>
<%--                                    <span>A</span>--%>
<%--                                </label>--%>
                                <label class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="venus-mars">
                                    <input type="radio" name="gender" id="option2" value="MF">
                                    <span class="fa fa-venus-mars"></span>
                                </label>
                                <label class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="mars">
                                    <input type="radio" name="gender" id="option4" value="M">
                                    <span class="fa fa-mars"></span>
                                </label>
                                <label class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="venus">
                                    <input type="radio" name="gender" id="option5" value="F">
                                    <span class="fa fa-venus"></span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">Age Range</div>
                        <div class="price-widget">
                            <div id="price-slider"></div>
                            <div id="amount-min" class="pull-left"></div>
                            <div id="amount-max" class="pull-right"></div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">StartDate</div>

                        <div class="input-group">
                            <input type="text" class="form-control" id="datepicker" placeholder="StartDate">
                            <div class="input-group-btn">
                                Days
                            </div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">DURATION</div>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Days">
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-8">

                <div class="sort-wrap">
                    <div class="sort-title counter-div"><span class="icon-tent counter" style="color: green" id="chatRoomCounter">${page.totalCount}</span>Matching Result</div>
                </div>
                <c:set var="i" value="0" />
                <c:forEach var="chatRoom" items="${list}">
                <c:set var="i" value="${ i+1 }" />
                <div class="item-list chat-room-item-list">
                    <input type="hidden" class="chat-room-no-hidden-input" value="${chatRoom.chatRoomNo}">
                    <div class="col-sm-5">
                        <div class="item-img row" style="background-image: url('http://placehold.it/320x250');">
                            <div class="item-overlay">
                                <a href="trip_detail.html"><span class="icon-binocular"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-7">
                        <div class="item-desc">
                            <h5 class="item-title">${chatRoom.chatRoomTitle}</h5>

                            <div class="sub-title">
                                ${chatRoom.tripPlanTitle}
                            </div>
                            <div class="left">
                                Age : ${chatRoom.minAge} ~ ${chatRoom.maxAge}
                            </div>
                            <div class="left">
                                Gender :
                                <c:if test="${chatRoom.gender == 'MF'}">
                                    <i class="fa fa-venus-mars"></i>
                                 </c:if>
                                <c:if test="${chatRoom.gender == 'M'}">
                                    <i class="fa fa-mars"></i>
                                </c:if>
                                <c:if test="${chatRoom.gender == 'F'}">
                                    <i class="fa fa-venus"></i>
                                </c:if>
                            </div><br/>
                            <div class="left"><span class="icon-calendar"></span>   ${chatRoom.strDate} [${chatRoom.tripDays}일]</div>

                            <div class="right">
                                    <a href="/tripPlan/selectTripPlan?tripPlanNo=${chatRoom.tripPlanNo}" data-toggle="modal" ><span class="icon-plane"></span></a>
                                    <a href="#modal-regular2" data-toggle="modal"><span class="icon-user" value="${chatRoom.chatRoomNo}"></span></a>
                                    <input type="hidden" />
                                    <div id="modal-regular2" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <h3 class="modal-title">Members</h3>
                                                </div>
                                                <div class="modal-body">

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        </div>
                        <div class="item-book">
                            <button class="btn btn-primary hvr-fade go" name="chatRoomNo" value="${chatRoom.chatRoomNo}">Enter</button>
                            <c:if test="${chatRoom.currentPersons eq chatRoom.maxPersons}">
                                <button class="btn btn-primary hvr-fade join-chatRoom" name="chatRoomNo" value="${chatRoom.chatRoomNo}"
                                        style="margin-left: 10px; background-color: #ee3f00" disabled>Hottest</button>
                            </c:if>
                            <c:if test="${chatRoom.currentPersons ne chatRoom.maxPersons and chatRoom.chatRoomStatus eq 0}">
                                <input type="hidden" class="roomGender" value="${chatRoom.gender}">
                                <input type="hidden" class="minAge" value="${chatRoom.minAge}">
                                <input type="hidden" class="maxAge" value="${chatRoom.maxAge}">
                                <button class="btn btn-primary hvr-fade join-chatRoom" name="chatRoomNo" value="${chatRoom.chatRoomNo}" style="margin-left: 10px; background-color: #00b3ee">Enroll</button>
                            </c:if>
                            <c:if test="${chatRoom.currentPersons ne chatRoom.maxPersons and chatRoom.chatRoomStatus eq 1}">
                                <button class="btn btn-primary hvr-fade join-chatRoom" name="chatRoomNo" value="${chatRoom.chatRoomNo}"
                                        style="margin-left: 10px; background-color: #66ffd6" disabled>Completed</button>
                            </c:if>
                            <c:if test="${chatRoom.currentPersons ne chatRoom.maxPersons and chatRoom.chatRoomStatus eq 2}">
                                <button class="btn btn-primary hvr-fade join-chatRoom" name="chatRoomNo" value="${chatRoom.chatRoomNo}"
                                        style="margin-left: 10px; background-color: #f5ff66; color: red" disabled>Finished</button>
                            </c:if>
                            <div class="price">${chatRoom.currentPersons} / ${chatRoom.maxPersons}</div>
                        </div>
                    </div>
                </div>
                </c:forEach>

                <nav aria-label="Page navigation example" class="text-center">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${page.currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="/chatRoom/chatRoomList?currentPage=${page.currentPage - 1}&searchKeyword=${search.searchKeyword}" aria-label="Previous">
                                &laquo;
                            </a>
                        </li>
                        <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">
                            <li class="page-item ${i == page.currentPage ? 'active' : ''}">
                                <a class="page-link" href="/chatRoom/chatRoomList?currentPage=${i}&searchKeyword=${search.searchKeyword}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">

                            <a class="page-link" href="/chatRoom/chatRoomList?currentPage=${page.currentPage + 1}&searchKeyword=${search.searchKeyword}" aria-label="Next">
                                &raquo;
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    </form>

</main>



<script>
    $(document).ready(function(){
        $('#datepicker').datepicker();
    });
</script>

<script type="text/javascript">

    function fncGoChatroom(){
        $("form").attr("method","POST").attr("action","/chatRoom/chat").submit();
    }

    function fncJoinChatroom(){
        $("form").attr("method","POST").attr("action","/chatMember/joinChatRoom").submit();
    }

    function fncAddChatroom(){
        $("form").attr("method","get").attr("action","/chatRoom/addChatRoom").submit();
    }

    $(function() {
        $(".join-chatRoom").on("click", function(event) {
            event.preventDefault();
            const userId = $("#userId").attr('value');
            const gender = $("#gender").attr('value');
            const roomGender = $(this).siblings('.roomGender').val();
            const minAge = $(this).siblings('.minAge').val();
            const maxAge = $(this).siblings('.maxAge').val();
            const age = calculateAge($("#birthYear").attr('value'));

            if(userId !== '') {
                const value = $(this).attr('value');
                alert("join-chatroom");
                $.ajax({
                    url: '/chatMember/json/fetchChatMembers/' + value,
                    type: 'GET',
                    dataType: 'json',
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    success: function (members) {
                        const matchingMember = members.find(member => member.userId === userId);
                        if (matchingMember) {
                            alert("이미가입했던 채팅방입니다.")
                        } else {
                            if ((roomGender === gender || roomGender === "MF") && age >= minAge && age <= maxAge) {
                                alert("신청완료 방장의 허락을 기다려 주세요");
                                fncJoinChatroom();
                            } else {
                                alert("조건에 부합하지 않습니다.");
                            }
                        }
                    },
                    error: function (xhr, status, error) {
                        alert("fail");
                        console.log('AJAX Error:', error);
                    }
                });
            }else{
                alert("로그인하세요");
            }
        });
    });

    $(function() {$("#addChatRoom").on("click", function() {fncAddChatroom();});});


    // window.addEventListener("load", function() {
    //     $.ajax({
    //         url: "/chatRoom/json/getList",
    //         method: "post",
    //         dataType: "json",
    //         headers: {
    //             "Accept": "application/json",
    //             "Content-Type": "application/json"
    //         },
    //         data: JSON.stringify({}),
    //         success: function(data) {
    //             console.log(data);
    //         }
    //     });
    // });

    $(function() {
        $(".icon-user").on("click", function() {
            var value = $(this).attr('value');
            console.log(value);
            $.ajax({
                url: '/chatMember/json/fetchChatMembers/'+value,
                type: 'GET',
                dataType: 'json',
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(members) {
                    console.log(members);
                    let memberArray = [];

                    // 멤버를 출력할 요소 가져오기
                    let modalBody = $("#modal-regular2").find(".modal-body");

                    // 기존 멤버 제거
                    modalBody.empty();

                    // 멤버 추가
                    members.forEach(function(member) {
                        console.log(member.name);
                        let memberElement = $("<div></div>").text(member.userId);
                        memberArray.push(memberElement);
                        modalBody.append(memberElement);
                    });
                },
                error: function(xhr, status, error) {
                    console.log('AJAX Error:', error);
                }
            });
        });
    });
    $(function() {
        $(".go").on("click", function() {
            let value = $(this).attr('value');
            let userId = $("#userId").attr('value');
            console.log(value);
            console.log(userId);
            $.ajax({
                url: '/chatMember/json/fetchChatMembers/'+value,
                type: 'GET',
                dataType: 'json',
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(members) {
                    console.log(members);
                    let flag=0;
                    // 멤버 인지 확인
                    members.forEach(function(member) {
                        console.log("member name : ",member.userId);

                        if(member.userId === userId){
                            flag=1;
                        }
                    });
                    if(flag === 1){
                        $(function(){
                            $("form").append($('<input>').attr({
                                type: 'hidden',
                                name: 'chatRoomNo',
                                value: value
                            })
                            );
                            fncGoChatroom();
                        });
                    }else{alert("your not a member!!!");}
                },
                error: function(xhr, status, error) {
                    console.log('AJAX Error:', error);
                }
            });
        });
    });
    $(window).on('beforeunload', function() {
        $('input[name="chatRoomNo"]').remove();
    });


    function fncGetUserList(currentPage){
        console.log($("#currentPage").val(currentPage));
        $("form").attr("method" , "GET").attr("action" , "/chatRoom/chatRoomList?").submit();
    }

    $(function() {
        $( "#search-chatroom" ).on("click" , function() {
            fncGetUserList(1);
        });
    })

    //생년월일 구하기
    function calculateAge(birthYear) {
        let currentDate = new Date();
        let currentYear = currentDate.getFullYear();
        let age = currentYear - birthYear;
        return age;
    }


</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>


</body>

</html>