<%@ page import="com.bit.motrip.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>



<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<%--    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">--%>
    <link rel="icon" type="image/png" href="/assets/img/favicon.png">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
    <link rel="stylesheet" href="/css/user/getUser.css">
    <link rel="stylesheet" href="/assets/css/bootstrap.css" media="all">




<%--    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">--%>
    <%--    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">--%>

<%--    <script src="https://kit.fontawesome.com/b2ece947c7.js" crossorigin="anonymous"></script>--%>
    <%--<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>--%>
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
    <script src="/assets/js/min/login.min.js"></script>
    <script src="/assets/js/min/priceslider.min.js"></script>

<%--    <script src="/assets/js/min/countnumbers.min.js"></script>--%>
    <%--<script src="/assets/js/main.js"></script>--%>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>--%>
<%--    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>--%>
<%--    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>--%>
<%--    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="UTF-8"></script>--%>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>--%>
    <!--  ///////////////////////// CSS ////////////////////////// -->





</head>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<body style="padding-top: 0; background-image: url('/images/user/myPageBody.jpg');">
<% User getUser = (User)request.getAttribute("getUser"); %>

<form><input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId}"></form>
<%--    <%@ include file="/WEB-INF/views/layout/header.jsp" %>--%>


<%--<div class="page-img" style="background-image: url('/images/user/getUserTop.jpg');">--%>

<%--<header class="nav-menu fixed">--%>
<%--<%@ include file="/WEB-INF/views/layout/header.jsp" %>--%>
<%--</header>--%>


<!--  화면구성 div Start /////////////////////////////////////-->

<div class="page-img" style="background-image: url('/images/user/myPageBody.jpg');">
    <div class="container">
        <h1 class="main-head text-center board-title Zooming">마이페이지</h1>
    </div>
</div>

<div class="container" style="background-color: #F1F2F8;">

    <div class="page-header">
        <h3  style="background-color: #558B2F; color: #F5F1E3;">profile</h3>
    </div>

    <div class="profile">

        <div class="profile-image">
            <%
                String userPhoto = getUser.getUserPhoto();
                boolean isUserPhotoPublic = getUser.isUserPhotoPublic();
                String gender = getUser.getGender();

                if(userPhoto != null && !userPhoto.isEmpty()){
                    if(isUserPhotoPublic) {
            %>
            <img id="profileUserPhoto" src="<%=userPhoto%>" style="width: 200px; height: 200px; object-fit: cover;" alt="">
            <%
            } else {
                if(gender.equals("M")) {
            %>
            <img id="manBasicProfile" src="/images/user/manBasicProfile.png" style="width: 200px; height: 200px; object-fit: cover;" alt="">
            <%
            } else if(gender.equals("F")) {
            %>
            <img id="womanBasicProfile" src="/images/user/womanBasicProfile.png" style="width: 200px; height: 200px; object-fit: cover;" alt="">
            <%
                    }
                }
            } else {
                if(gender.equals("M")) {
            %>
            <img id="manBasicProfile" src="/images/user/manBasicProfile.png" style="width: 200px; height: 200px; object-fit: cover;" alt="">
            <%
            } else if(gender.equals("F")) {
            %>
            <img id="womanBasicProfile" src="/images/user/womanBasicProfile.png" style="width: 200px; height: 200px; object-fit: cover;" alt="">
            <%
                    }
                }
            %>


        </div>

        <div class="profile-user-settings" style="display: inline-block; align-items: center;">

            <div class="welcome-row">
                <c:if test="${sessionScope.user.userId eq getUser.userId}" >
                    <span class="nickname1" id="nickname1">${getUser.nickname}</span>
                    <span class="welcome-msg">님, 환영합니다!</span>
                </c:if>
                <c:if test="${sessionScope.user.userId ne getUser.userId}" >
                    <span class="nickname2" id="nickname2">${getUser.nickname}</span>
                    <span class="welcome-msg">님의 회원정보입니다.
                        <c:if test="${getUser.gender eq 'M'}">
                            <img class="text-right get-user-male" style="max-width: 25px; max-height: 25px; margin: 0;" src="/images/male.png">
                        </c:if>
                        <c:if test="${getUser.gender eq 'F'}">
                            <img class="text-right get-user-female" style="max-width: 25px; max-height: 25px; margin: 0;" src="/images/female.png">
                        </c:if>
                    </span>
                </c:if>
            </div>

            <div id="imgs" style="opacity: 1; display: inline-block; font: inherit; background: none; border: none; color: inherit; padding: 0; cursor: pointer;">
                <%--                <span class="icon-heart" id="evaluateCount" style="opacity: 1;">${getUser.evaluateCount}</span>--%>
                <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px; cursor: default;" src="/images/redheart.png">
                <span style="cursor: default; font-size: 20px;" id="evaluateCount">${getUser.evaluateCount}</span>

                <c:if test="${sessionScope.user.userId eq getUser.userId}">
                    <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px; cursor: pointer;" src="/images/gear.png">
                </c:if>

                <c:if test="${sessionScope.user.userId ne getUser.userId}">
                    <%--                    <i class="fa-regular fa-circle-xmark" name="blacklist" id="blacklist" title="블랙리스트 등록" style="opacity: 1;"></i>--%>
                    <img  style="max-width: 25px; max-height: 25px; display: inline-block; margin-left: 10px;" src="/images/userban.png" name="blacklist" id="blacklist" title="블랙리스트 등록">
                </c:if>

                <c:if test="${sessionScope.user.userId eq getUser.userId}">
                    <button type="button" class="blacklist-button" name="listBlack" id="listBlack">Blacklist</button>
                    <button type="button" class="secession-button" name="secessionUser" id="secessionUser">회원탈퇴</button>
                </c:if>

            </div>

        </div>

        <div class="profile-stats">
            <blockquote class="with-icon" style="background-color: #F5F1E3;">
                <c:if test="${getUser.selfIntroPublic}">
                    <h3 id="selfIntro">${getUser.selfIntro}</h3>
                </c:if>
                <c:if test="${!getUser.selfIntroPublic}">
                    <h3 id="selfIntro">"비공개정보입니다."</h3>
                </c:if>
            </blockquote>
        </div>



        <div class="profile-bio">
            <%--            //style="display: flex; justify-content: flex-end"--%>
            <div class="box" style="grid-area: box1; display: flex; justify-content: flex-end">
                <c:if test="${sessionScope.user.userId ne getUser.userId}">
                    <button type="button" class="btn" name="likeUser" id="likeUser">
                        <img class="text-right" style="max-width: 25px; max-height: 25px;" src="/images/like.png">
                    </button>
                    <button type="button" class="btn" name="likeUserCancle" id="likeUserCancle" style=" background-color: transparent; outline: none; box-shadow: none; border: none;">
                        <img class="text-right" style="background-color: white; max-width: 25px; max-height: 25px;" src="/images/likePush.png">
                    </button>
                </c:if>
            </div>

            <div class="box" style="grid-area: box2;">
                <c:if test="${sessionScope.user.userId ne getUser.userId}">
                    <button type="button" class="btn" name="disLikeUser" id="disLikeUser">
                        <img class="text-right" style="max-width: 25px; max-height: 25px;" src="/images/dislike.png">
                    </button>
                    <button type="button" class="btn" name="disLikeUserCancle" id="disLikeUserCancle" style=" background-color: transparent; outline: none; box-shadow: none; border: none;">
                        <img class="text-right" style="background-color: white; max-width: 25px; max-height: 25px;" src="/images/dislikePush.png">
                    </button>
                </c:if>
            </div>

            <div class="box" style="grid-area: box3;">

            </div>
        </div>
    </div>
<%--    프로필부분 끝/ 탭 시작 ###################################################################--%>
    <div>
        <!-- START Block Tabs Title -->
        <div class="block full">
            <ul class="nav nav-tabs" data-toggle="tabs">
                <li class="active"><a href="#tripPlanList" data-toggle="tab" data-load="true" id="tripPlanListTab">여행플랜목록</a></li>
                <li class=""><a href="#chatRoomList" data-toggle="tab" data-load="false" id="chatRoomListTab">채팅방 목록</a></li>
                <li class=""><a href="#reviewList" data-toggle="tab" data-load="false" id="reviewListTab">후기 목록</a></li>
            </ul>
        </div>
        <!-- END Block Tabs Title -->

        <!-- Tabs Content -->
        <div class="tab-content" >

            <div class="tab-pane active" id="tripPlanList">
                <!-- 여행플랜목록 부분 ################################################################################ -->
                <main>
                    <input type="hidden" name="userId" value="${sessionScope.user.userId}">
                    <div class="container">
                        <div class="col-sm-12">
                            <c:set var="i" value="0"/>
                            <c:forEach var="tripPlan" items="${tripPlanList}">
                                <c:set var="i" value="${ i+1 }"/>
                                <div class="item-list trip-plan-item-list">
                                    <div class="col-sm-5">
                                        <div class="item-img row" style="background-image: url('/images/tripImage.jpg');"><input
                                                type="hidden"
                                                value="${tripPlan.tripPlanNo}"
                                                class="tripPlanNo"/>
                                        </div>
                                    </div>

                                    <div class="col-sm-7">
                                        <div class="item-desc">
                                            <div>
                                                <h6 class="right">${tripPlan.tripPlanRegDate}</h6>
                                                <h5 class="item-title">${tripPlan.tripPlanTitle} </h5>
                                                <div class="sub-title">
                                                    <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
                                                        <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                                                            <h6>#${place.placeTags}</h6>
                                                        </c:forEach>
                                                    </c:forEach>
                                                </div>
                                            </div>

                                            <div class="right">
                                                <h4>${tripPlan.tripPlanAuthor}</h4>
                                                <div class="right"><span class="icon-date"></span>
                                                    <c:if test="${tripPlan.tripDays == 1}">
                                                        ${tripPlan.tripDays}일
                                                    </c:if>
                                                    <c:if test="${tripPlan.tripDays != 1}">
                                                        ${tripPlan.tripDays-1}박 ${tripPlan.tripDays}일
                                                    </c:if>
                                                </div>
                                                <div>
                                                    <c:if test="${not empty sessionScope.user.userId}">
                                                        <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                                            <button class="btn-sm btn-info right" id="addChatRoom"
                                                                    value="${tripPlan.tripPlanNo}">채팅방 생성
                                                            </button>
                                                        </c:if>
                                                    </c:if>
                                                    <c:if test="${not empty sessionScope.user.userId && !tripPlan.isTripCompleted}">
                                                        <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                                            <button class="btn-sm btn-info right" name="tripPlanNo"
                                                                    value="${tripPlan.tripPlanNo}">여행완료
                                                            </button>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="item-book">

                                            <button class="btn btn-sm btn-success" id="getTripPlanDetail" name="tripPlanNo"
                                                    value="${tripPlan.tripPlanNo}">조회<input type="hidden"
                                                                                            value="${tripPlan.tripPlanNo}"
                                                                                            class="tripPlanNo"/>
                                            </button>

                                            <c:if test="${not empty sessionScope.user.userId && !tripPlan.isPlanDeleted && !tripPlan.isTripCompleted}">
                                                <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                                    <button id="btnDelete" class="btn btn-sm btn-danger"
                                                            value="${tripPlan.tripPlanNo}">삭제<input type="hidden"
                                                                                                    value="${tripPlan.tripPlanNo}"
                                                                                                    class="tripPlanNo"/>
                                                    </button>
                                                </c:if>
                                            </c:if>

                                            <c:if test="${not empty sessionScope.user.userId && tripPlan.isPlanDeleted && !tripPlan.isTripCompleted}">
                                                <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                                    <button id="btnDelete" class="btn btn-sm btn-info"
                                                            value="${tripPlan.tripPlanNo}">복구<input type="hidden"
                                                                                                    value="${tripPlan.tripPlanNo}"
                                                                                                    class="tripPlanNo"/>
                                                    </button>
                                                </c:if>
                                            </c:if>

                                            <div class="price">
                                                <label class="icon-hand-like">${tripPlan.tripPlanLikes}</label>
                                                <label></label>
                                                <label class="icon-eye">${tripPlan.tripPlanViews}</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <nav aria-label="Page navigation example" class="text-center">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${page.currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${page.currentPage - 1}"
                                           aria-label="Previous">
                                            &laquo;
                                        </a>
                                    </li>
                                    <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">

                                        <li class="page-item ${i == page.currentPage ? 'active' : ''}">
                                            <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${i}">${i}</a>
                                        </li>

                                    </c:forEach>

                                    <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">
                                        <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${page.currentPage + 1}"
                                           aria-label="Next">
                                            &raquo;
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </main>
            </div><!-- END Tabs findId -->


            <!-- 채팅목록 부분 ################################################################################ -->

            <div class="tab-pane" id="chatRoomList">
                <main>
                    <div class="container">
                        <div class="col-sm-12">
                            <c:set var="i" value="0" />
                            <c:forEach var="chatRoom" items="${chatRoomList}">
                                <c:set var="i" value="${ i+1 }" />
                                <div class="item-list">
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
                                                <a href="/tripPlan/selectTripPlan?tripPlanNo=${chatRoom.tripPlanNo}"><span class="icon-plane"></span></a>
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
                                                <button class="btn btn-primary hvr-fade join-chatRoom" value="${chatRoom.chatRoomNo}"
                                                        style="margin-left: 10px; background-color: #ee3f00" disabled>Hottest</button>
                                            </c:if>
                                            <c:if test="${chatRoom.currentPersons ne chatRoom.maxPersons and chatRoom.chatRoomStatus eq 0}">
                                                <input type="hidden" class="roomGender" value="${chatRoom.gender}">
                                                <input type="hidden" class="minAge" value="${chatRoom.minAge}">
                                                <input type="hidden" class="maxAge" value="${chatRoom.maxAge}">
                                            </c:if>
                                            <c:if test="${chatRoom.currentPersons ne chatRoom.maxPersons and chatRoom.chatRoomStatus eq 1}">
                                                <button class="btn btn-primary hvr-fade join-chatRoom" value="${chatRoom.chatRoomNo}"
                                                        style="margin-left: 10px; background-color: #66ffd6" disabled>Completed</button>
                                            </c:if>
                                            <c:if test="${chatRoom.currentPersons ne chatRoom.maxPersons and chatRoom.chatRoomStatus eq 2}">
                                                <button class="btn btn-primary hvr-fade join-chatRoom" value="${chatRoom.chatRoomNo}"
                                                        style="margin-left: 10px; background-color: #f5ff66; color: red" disabled>Finished</button>
                                            </c:if>
                                            <div class="price">${chatRoom.currentPersons} / ${chatRoom.maxPersons}</div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <nav aria-label="Page navigation example" class="text-center">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${chatRoomPage.currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/user/getUser?currentPage=${chatRoomPage.currentPage - 1}&searchKeyword=${chatRoomSearch.searchKeyword}" aria-label="Previous">
                                            &laquo;
                                        </a>
                                    </li>
                                    <c:forEach var="i" begin="${chatRoomBeginUnitPage}" end="${chatRoomEndUnitPage}">
                                        <li class="page-item ${i == page.currentPage ? 'active' : ''}">
                                            <a class="page-link" href="/user/getUser?currentPage=${i}&searchKeyword=${chatRoomSearch.searchKeyword}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">

                                        <a class="page-link" href="/user/getUser?currentPage=${chatRoomPage.currentPage + 1}&searchKeyword=${chatRoomSearch.searchKeyword}" aria-label="Next">
                                            &raquo;
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </main>
            </div><!-- END Tabs findPwd -->

            <div class="tab-pane" id="reviewList">
                <!-- 리뷰목록 부분 ################################################################################ -->
                <main>
                    <div class="container">
                        <div class="col-sm-12">
                            <c:set var="i" value="0"/>
                            <c:forEach var="review" items="${myReviewList}">
                                <c:set var="i" value="${ i+1 }"/>
                                <div class="item-list review-item-list">

                                    <div class="col-sm-5">
                                        <div class="item-img row" style="background-image: url('/images/tripImage.jpg');"><input
                                                type="hidden"
                                                value=">${review.reviewNo}"
                                                class="reviewNo"/>
                                        </div>
                                    </div>

                                    <div class="col-sm-7">
                                        <div class="item-desc">
                                            <div>
                                                <h6 class="right">${review.reviewRegDate}</h6>
                                                <h5 class="item-title">${review.reviewTitle} </h5>
                                                <div class="sub-title">
                                                    태그는 여기로
                                                </div>
                                            </div>

                                            <div class="right">
                                                <h4>${review.reviewAuthor}</h4>
                                                <div class="right"><span class="icon-date"></span>
                                                    몇 박 몇일은 여기에
                                                </div>
                                                <div>
                                                    삭제여부 넣고 싶으면 여기에
                                                </div>
                                            </div>
                                        </div>
                                        <div class="item-book">
                                            <button class="btn btn-sm btn-success" id="getReviewDetail" name="reviewNo"
                                                    value="${review.reviewNo}">조회<input type="hidden"
                                                                                        value="${review.reviewNo}"
                                                                                        class="reviewNo"/>
                                            </button>
                                            <c:if test="${sessionScope.user.userId == reviewAuthor}">
                                                <button id="btnDelete" class="btn btn-sm btn-danger"
                                                        value="${review.reviewNo}">삭제<input type="hidden"
                                                                                            value="${review.reviewNo}"
                                                                                            class="reviewNo"/>
                                                </button>
                                            </c:if>
                                            <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                                <button id="btnDelete" class="btn btn-sm btn-info"
                                                        value="${review.reviewNo}">복구<input type="hidden"
                                                                                            value="${review.reviewNo}"
                                                                                            class="reviewNo"/>
                                                </button>
                                            </c:if>
                                            <div class="price">
                                                <label class="icon-hand-like">${review.reviewLikes}</label>
                                                <label></label>
                                                <label class="icon-eye">${review.viewCount}</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <nav aria-label="Page navigation example" class="text-center">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${reviewPage.currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/review/getMyReviewList?type=${condition}&currentPage=${page.currentPage - 1}&planCondition=${search.planCondition}&searchKeyword=${search.searchKeyword}"
                                           aria-label="Previous">
                                            &laquo;
                                        </a>
                                    </li>
                                    <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">
                                        <li class="page-item ${i == page.currentPage ? 'active' : ''}">
                                            <a class="page-link" href="/review/getMyReviewList?type=${condition}&currentPage=${i}&planCondition=${search.planCondition}&searchKeyword=${search.searchKeyword}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">
                                        <a class="page-link" href="/review/getMyReviewList?type=${condition}&currentPage=${page.currentPage + 1}&planCondition=${search.planCondition}&searchKeyword=${search.searchKeyword}"
                                           aria-label="Next">
                                            &raquo;
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div><!-- END Tabs container -->
                </main>
            </div><!-- END Tabs reviewList -->
        </div><!-- END Tabs Content -->
    </div>
</div>








<script type="text/javascript">

    $(document).ready(function() {

        //tab이 선택될 때, 모든 tab에서 active요소를 제거하고 선택된 탭에 active 요소를 부여한다
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            var target = $(e.target).attr("href"); // activated tab
            $('.tab-pane').removeClass('active');
            $(target).addClass('active');
        });

        $("#tripPlanListTab").on("click", function () {

            console.log("여행플랜목록 클릭됨. = 내용초기화");

            $(this).addClass('active');
            $('#chatRoomListTab').removeClass('active');
            $('#reviewListTab').removeClass('active');
        });

        $("#chatRoomListTab").on("click", function () {

            console.log("후기목록 클릭됨. = 내용초기화");

            $(this).addClass('active');
            $('#tripPlanListTab').removeClass('active');
            $('#reviewListTab').removeClass('active');
        });

        $("#reviewListTab").on("click", function () {

            console.log("후기목록 클릭됨. = 내용초기화");

            $(this).addClass('active');
            $('#tripPlanListTab').removeClass('active');
            $('#reviewListTab').removeClass('active');
        });

    });

    //페이지가 로드될 시 실행되어 좋아요,싫어요 버튼 state 값을 가져온다.
    $(document).ready(function(){

        evaluateButtonState();

        if("${getUser.gender eq 'M'}") {
            $(".get-user-male").show()
            $(".get-user-female").hide()
        }else if("${getUser.gender eq 'F'}") {
            $(".get-user-female").show()
            $(".get-user-male").hide()
        }

        if("${sessionScope.user.userId}" != "${getUser.userId}") {
            blacklistState();
        }
    });

    function evaluateButtonState() {

        console.log("${sessionScope.user.userId}");
        console.log("${getUser.userId}");

        $.ajax({
            url: "/user/evaluateState",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                sessionUserId: "${sessionScope.user.userId}",
                getUserId: "${getUser.userId}"
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
                alert("다시 시도해주세요.");
            }
        });
    }

    function blacklistState() {

        if("${sessionScope.user.userId}" != "${getUser.userId}") {

            console.log("${sessionScope.user.userId}");
            console.log("${getUser.userId}");

            $.ajax({
                url: "/user/blacklistState",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${getUser.userId}"
                }),
                dataType: "text",
                success: function (response) {

                    if (response == "${getUser.userId}") {
                        console.log("blacklist 값이 있을 때 실행됨  " +response);
                        $("#blacklist").attr('src','/images/userbancancle.png');
                        $("#blacklist").attr('title', '블랙리스트 취소');

                    } else {
                        console.log("blacklist  값이 없을 때 실행됨  " +response);
                        $("#blacklist").attr('src', '/images/userban.png');
                        $("#blacklist").attr('title', '블랙리스트 추가');
                    }
                },
                error: function (error) {
                    alert("다시 시도해주세요.");
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
                    getUserId: "${getUser.userId}"
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
                    alert("다시 시도해주세요.");
                }
            });
        });

        //좋아요 클릭이벤트
        $("#likeUser").on("click" , function() {

            $.ajax({
                url: "/user/addEvaluation",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    evaluaterId: "${sessionScope.user.userId}",
                    evaluatedUserId: "${getUser.userId}",
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
                    alert("다시 시도해주세요");
                }
            });
        });

        //싫어요 클릭이벤트
        $("#disLikeUser").on("click" , function() {

            $.ajax({
                url: "/user/addEvaluation",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    evaluaterId: "${sessionScope.user.userId}",
                    evaluatedUserId: "${getUser.userId}",
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
                    alert("다시 시도해주세요.");
                }
            });
        });

        //싫어요취소 클릭이벤트
        $("#disLikeUserCancle").on("click" , function() {

            $.ajax({
                url: "/user/userEvaluateCancle",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({
                    sessionUserId: "${sessionScope.user.userId}",
                    getUserId: "${getUser.userId}"
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
                    alert("다시 시도해주세요.");
                }
            });
        });

        //블랙리스트 추가 클릭이벤트
        $("#blacklist").on("click" , function() {
            if($(this).attr('src') === '/images/userban.png') {

                $.ajax({
                    url: "/user/addBlacklist",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        evaluaterId: "${sessionScope.user.userId}",
                        blacklistedUserId: "${getUser.userId}"
                    }),
                    dataType: "text",
                    success: function (response) {

                        if(response == "") {
                            swal({
                                title: "블랙리스트 등록이 완료되었습니다.",
                                text: "이제 해당 회원과 소통이 불가능합니다.",
                                icon: "success",
                                button: "확인",
                            }).then((value) => {

                                $("#blacklist").attr('src', '/images/userbancancle.png');
                                $("#blacklist").attr('title', '블랙리스트 취소');
                            });
                        }
                    },
                    error: function (error) {
                        alert("다시 시도해주세요.");
                    }
                });
            } else if($(this).attr('src') === '/images/userbancancle.png') {

                $.ajax({
                    url: "/user/deleteBlacklist",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        evaluaterId: "${sessionScope.user.userId}",
                        blacklistedUserId: "${getUser.userId}"
                    }),
                    dataType: "text",
                    success: function (response) {
                        swal({
                            title: "블랙리스트 해제가 완료되었습니다.",
                            text: "이제 해당 회원과 소통이 가능합니다.",
                            icon: "success",
                            button: "확인",
                        }).then((value) => {

                            $("#blacklist").attr('src', '/images/userban.png');
                            $("#blacklist").attr('title', '블랙리스트 등록');
                        });
                    },
                    error: function (error) {
                        alert("다시 시도해주세요.");
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

        $('#imgs img[src="/images/gear.png"]').on("click" , function() {

            $('#updateUserModal').modal('show');
        });
    });

    //회원탈퇴확인
    $( function() {

        $("#secessionUser").on("click", function () {

            Swal.fire({
                title: '정말 탈퇴하시겠습니까?',
                text: "이 동작은 되돌릴 수 없습니다!",
                icon: 'warning',
                showCancelButton: true,  // 취소 버튼 활성화
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '네, 탈퇴하겠습니다.',
                cancelButtonText: '아니오, 취소합니다.'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 사용자가 확인을 눌렀을 때의 동작
                    console.log('탈퇴를 확인하였습니다.')
                    self.location.href = "/user/secessionUser";
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    // 사용자가 취소를 눌렀을 때의 동작
                    console.log('탈퇴를 취소하였습니다.')
                }
            })
        });
    });


//     여행플랜부분#####################################################################

    $(document).ready(function () {

        // 선택된 체크박스의 ID를 가져와서 정렬 순서 변경
        $('input[name="options"]').on('click', function () {
            var option = $(this).attr('id');
            console.log(option);
        });

        // 사진의 경우 여행플랜 삭제되었을때 아무것도 안눌리도록
        $(function () {
            $(".item-img").on("click", function () {
                var tripPlanNo = $(this).find(".tripPlanNo").val();
                if (tripPlanNo == 0) {
                    // 삭제된 플랜을 눌렀을 때 아무 작업도 하지 않음
                } else {
                    console.log(tripPlanNo);
                    window.location.href = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
                }
            });
        });

        // 버튼의 경우 여행플랜 삭제되었을때 아무것도 안눌리도록
        $(function () {
            $("#getTripPlanDetail").on("click", function () {
                var tripPlanNo = $(this).find(".tripPlanNo").val();
                if (tripPlanNo == 0) {
                    // 삭제된 플랜을 눌렀을 때 아무 작업도 하지 않음
                } else {
                    console.log(tripPlanNo);
                    window.location.href = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
                }
            });
        });

        // 여행플랜 삭제하기 버튼
        $(function () {
            $("button[id='btnDelete']").on("click", function () {
                var tripPlanNo = this.value;
                var delTripPlan = $(this).closest("tr");

                console.log(tripPlanNo);

                $.ajax({
                    url: "/tripPlan/tripPlanDeleted",
                    type: "GET",
                    data: {"tripPlanNo": tripPlanNo},
                    contentType: "application/json; charset=utf-8",
                    dataType: "JSON",
                    success: function (data) {
                        if (data.isPlanDeleted) {
                            delTripPlan.css("background-color", "gray");
                            delTripPlan.class("btn btn-sm btn-info");
                            delTripPlan.find(".btn btn-sm btn-info").val(0); // 숨겨진 요소의 값을 업데이트
                            delTripPlan.find(".btnDelete").text("복구"); // 버튼 텍스트 업데이트
                        } else {
                            delTripPlan.css("background-color", "white");
                            delTripPlan.class("btn btn-sm btn-danger");
                            delTripPlan.find(".btn btn-sm btn-danger").val(data.tripPlanNo); // 숨겨진 요소의 값을 업데이트
                            delTripPlan.find(".btnDelete").text("삭제"); // 버튼 텍스트 업데이트
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("여행플랜 삭제 실패");
                    }
                });
            });
        });

        // AJAX 요청을 보내고 여행플랜의 수를 가져오는 함수
        function listCounter() {
            $.ajax({
                url: "/tripPlan/tripPlanCount",
                type: "POST",
                dataType: "json",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                data: JSON.stringify({}),
                success: function (data) {
                    console.log(data);
                    $("#tripPlanCounter").html(data); // 변경된 부분: data.count 값을 출력합니다.
                    $(".total").text("Total : " + data);
                    var t = $(".counter");
                    t.countUp({delay: 30, time: 3e3})
                },
                error: function (xhr, status, error) {
                    console.log("An error occurred: " + error);
                }
            });
        }
    });

//     여행플랜부분 끝 ######################################################################

//     채팅목록부분 시작#####################################################################
    $(document).ready(function () {
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

});
    function fncGoChatroom(){
        $("form").attr("method","POST").attr("action","/chatRoom/chat").submit();
    }
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

//     후기목록부분 시작#####################################################################

    $(function () {
        $("#getReviewDetail").on("click", function () {

            var reviewNo = $(this).find(".reviewNo").val();
            if (reviewNo == 0) {
                // 삭제된 플랜을 눌렀을 때 아무 작업도 하지 않음
            } else {

                window.location.href = "/review/getReview?reviewNo=" + reviewNo;
            }
        });
    });

</script>

<!-- 회원정보수정 모달 인클루드 -->
<jsp:include page="updateUserModal.jsp"/>

<!-- 블랙리스트 모달 인클루드 -->
<jsp:include page="listBlackModal.jsp"/>

<!-- 회원탈퇴확인 모달 인클루드 -->
<%--<jsp:include page="secessionUserModal.jsp"/>--%>


</body>

</html>