<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2023-06-05
  Time: 오전 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<link rel="stylesheet" href="/css/alarm/alarm.css" media="all">
<link rel="stylesheet" href="/css/memo/memo.css" media="all">
<link rel="stylesheet" href="/summernote/summernote.css" media="all">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/summernote/summernote.js"></script>
<script src="/js/alarm/alarm.js"></script>
<script src="/js/memo/listMemo.js"></script>
<script src="/js/memo/buildMemo.js"></script>
<script src="/js/memo/memoBtnCtrl.js"></script>
<script src="/js/memo/memoFunction.js"></script>
<script src="/js/memo/ajaxMemo.js"></script>
<%--
<script src="/js/alarm/alarm.js"></script>
--%>


<div class="pre-loader">
    <div class="loading-img"></div>
</div>

<header class="nav-menu fixed">
    <nav class="navbar normal transparent">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="/">
                    <img src="/images/motrip-logo.gif" alt="">
                </a>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>

            <div class="navbar-collapse collapse" id="main-navbar">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#">모두의 여행 <i class="fa fa-chevron-down nav-arrow"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="home_default.html">모두의 여행이란</a></li>
                            <li><a href="home_slider.html">설계 포트폴리오</a></li>
                            <li><a href="home_slider_with_searhbar.html">제작팀 소개</a></li>
                            <c:if test="${empty sessionScope.user}">
                            <li><a href="/test/login/user1">유저1로 로그인</a></li>
                            <li><a href="/test/login/user2">유저2로 로그인</a></li>
                            <li><a href="/test/login/admin">admin 로그인</a></li>
                            </c:if>
                            <c:if test="${not empty sessionScope.user}">
                            <li><a href="/test/logout">${user.userId}님,로그아웃</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#">여행플랜</a>
                        <ul class="dropdown-menu">
                            <li><a href="/tripPlan/tripPlanList">여행플랜 목록</a>
                            </li>
                            <li><a href="/tripPlan/myTripPlanList">나의 여행플랜</a>
                            </li>
                            <li><a href="/tripPlan/myTripPlanList">나의 여행플랜</a>
                            </li>
                            <li><a href="/tripPlan/addTripPlanView">여행플랜 작성</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle">채팅</a>
                        <ul class="dropdown-menu">
                            <li><a href="/chatRoom/chatRoomList">채팅 리스트</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle">후기</a>
                        <ul class="dropdown-menu">
                            <li><a href="/review/addReviewView">후기 작성</a>
                            </li>
                            <li><a href="/review/getReviewList">모든 후기</a>
                            </li>
                            <li><a  href="/review/getMyReviewList">나의 후기</a>
                            </li>
                        </ul>
                    </li>
                    <c:if test="${not empty sessionScope.user}">
                    <li id="memo-section" class="dropdown">
                        <input type="hidden" id="memo-search-condition" value="myMemo">
                        <a href="#" class="dropdown-toggle">메모</a>
                        <ul id="memo-dropdown" class="dropdown-menu">
                            <div class="my-memo-thumbnail btn-group-justified" role="group">
                                <a href="#" class="btn btn-line btn-sm btn-default" role="button" onclick="buildMemo('user2')">+ 새 메모</a>
                            </div>
                            <div class="panel-group" id="memo-accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="my-memo-btn">
                                        <p class="panel-title">
                                            <a role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#my-memo-collapse" aria-expanded="true" aria-controls="collapseOne">
                                                나의 메모 보기
                                            </a>
                                        </p>
                                    </div>
                                    <div id="my-memo-collapse" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                        <div class="panel-body">
                                            <div id="my-memo-control" class="btn-group btn-group-justified " role="group">
                                                <a href="#" id="my-memo-prev-btn" class="btn btn-line btn-sm btn-default" role="button" onclick="changePage('myMemo',-1)">◀</a>
                                                <a href="#" id="my-memo-current-page" class="btn btn-line btn-sm btn-default" role="button">1</a>
                                                <a href="#" id="my-memo-next-btn" class="btn btn-line btn-sm btn-default" role="button" onclick="changePage('myMemo',+1)">▶</a>
                                            </div>
                                            <div id="my-memo-list-container">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="shared-memo-btn">
                                        <p class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#shared-memo-collapse" aria-expanded="false" aria-controls="collapseTwo">
                                                공유받은 메모 보기
                                            </a>
                                        </p>
                                    </div>
                                    <div id="shared-memo-collapse" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                        <div class="panel-body">
                                            <div id="shared-memo-control" class="btn-group btn-group-justified " role="group">
                                                <a href="#" id="shared-memo-prev-btn" class="btn btn-line btn-sm btn-default" role="button" onclick="changePage('sharedMemo',-1)">◀</a>
                                                <a href="#" id="shared-memo-current-page" class="btn btn-line btn-sm btn-default" role="button">1</a>
                                                <a href="#" id="shared-memo-next-btn" class="btn btn-line btn-sm btn-default" role="button" onclick="changePage('sharedMemo',+1)">▶</a>
                                            </div>
                                            <div id="shared-memo-list-container">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="del-memo-btn">
                                        <p class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#memo-accordion" href="#del-memo-collapse" aria-expanded="false" aria-controls="collapseThree">
                                                삭제된 메모 보기
                                            </a>
                                        </p>
                                    </div>
                                    <div id="del-memo-collapse" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                        <div class="panel-body">
                                            <div id="del-memo-control" class="btn-group btn-group-justified " role="group">
                                                <a href="#" id="del-memo-prev-btn" class="btn btn-line btn-sm btn-default" role="button" onclick="changePage('deletedMemo',-1)">◀</a>
                                                <a href="#" id="del-memo-current-page" class="btn btn-line btn-sm btn-default" role="button">1</a>
                                                <a href="#" id="del-memo-next-btn" class="btn btn-line btn-sm btn-default" role="button" onclick="changePage('deletedMemo',+1)">▶</a>
                                            </div>
                                            <div id="del-memo-list-container">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ul>
                    </li>
                    </c:if>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="boardDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            게시판
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="boardDropdown">
                            <li>
                                <a class="dropdown-item" href="/notice/noticeList">공지사항</a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="/qna/qnaList">질의응답</a>
                            </li>
                        </ul>
                    </li>
                    <c:if test="${empty sessionScope.user}">
                    <li> <a href="/user/login"><span class="icon-user"></span>로그인</a>
                    </c:if>
                    <c:if test="${not empty sessionScope.user}">
                        <li class="dropdown">
                            <a class="icon-user" href="#">${sessionScope.user.nickname}</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">MyPage</a>
                                </li>
                                <c:if test="${sessionScope.user.role == 0}">
                                    <li><a href="/user/listUser">회원목록</a>
                                    </li>
                                </c:if>
                                <li><a href="#">로그아웃</a>
                                </li>
                            </ul>
                        </li>
                    </c:if>
                    </li>
                    <li class="dropdown">
                        <a id="alarm-set-area" href="#">
                            <span id="alarm-bell"  class="icon-bell" data-toggle="popover" data-content="popoverContents" data-placement="top" data-trigger="focus" title=""></span>
                            <span id="unreadAlarmCount" class="badge badge-danger">0</span></a>
                        <ul id="alarm-thumbnail-area" class="dropdown-menu  dropdown-menu-right cart-menu">

                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <div class="alarm-info-area">
            <%--어플리케이션 스코프로부터 값을 받거나, 3이다.--%>
            <input type="hidden" id="pollingTime" value="${applicationScope.alarmPollingTime}">
            <input type="hidden" id="alarmUserId" value="${sessionScope.user.userId}">
            <input type="hidden" id="alarmUserNickname" value="${sessionScope.user.nickname}">
            <input type="hidden" id="alarmCurrentPage" value="1">
        </div>

    </nav>
</header>
<%--button trigger modal--%>
<input type="hidden" data-toggle="modal" href="#alarm-modal"></input>
<%--Modal--%>
<div id="alarm-modal" class="modal" aria-labelledby="myModalLabel" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="alarm-modal-title" class="modal-title">Modal Title</h3>
            </div>
            <div id="alarm-modal-contents" class="modal-body">
                Modal Content..
            </div>
            <div id="alarm-modal-footer" class="modal-footer">
                <button type="button" class="btn btn-sm btn-default hvr-grow" data-dismiss="modal">닫기</button>
                <button type="button" id="alarm-confirm-btn" class="btn btn-sm btn-primary hvr-grow">읽음</button>
                <button type="button" id="alarm-navigate-btn" class="btn btn-sm btn-info hvr-grow">이동</button>
                <button type="button" id="alarm-accept-btn" class="btn btn-sm btn-primary hvr-grow">승인</button>
                <button type="button" id="alarm-hold-btn" class="btn btn-sm btn-warning hvr-grow">보류</button>
                <button type="button" id="alarm-reject-btn" class="btn btn-sm btn-danger hvr-grow">거절</button>
            </div>
        </div>
    </div>
</div>
<div id="memo-dialogs">
    <%--유저 아이디를 담을 hidden input 만들기.--%>
    <input type="hidden" id="memo-user-id" value="${sessionScope.user.userId}">
</div>
<div id="memo-share-modal" class="modal" aria-labelledby="myModalLabel" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="memo-share-modal-title" class="modal-title">메모 권한설정</h3>
                <input id="memo-share-modal-memo-no" type="hidden" value="invalidMemoNo">
            </div>
            <div id="memo-share-modal-contents" class="modal-body">
                <div id="memo-share-modal-list-area">
                    <div class="panel panel-default">
                        <!-- Default panel contents -->
                        <div class="panel-heading">이 메모를 공유중인 사람들</div>
                        <!-- Table -->
                        <table class="table">
                            <thead>
                            </thead>
                            <tbody id="memo-sharer-list-body">

                            </tbody>
                        </table>
                        <div class="panel-heading">이 메모가 필요한 사람들</div>
                        <!-- Table -->
                        <table class="table">
                            <thead>
                            </thead>
                            <tbody id="memo-sharee-list-body">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div id="memo-share-modal-footer" class="modal-footer">
                <button type="button" class="btn btn-sm btn-default hvr-grow" data-dismiss="modal">닫기</button>
                <button type="button" id="memo-share-modal-unShare-btn-for-shared" class="btn btn-sm btn-danger hvr-grow">공유 해제</button>
            </div>
        </div>
    </div>
</div>
