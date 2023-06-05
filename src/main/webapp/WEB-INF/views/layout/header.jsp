<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pre-loader" style="display: none;">
    <div class="loading-img"></div>
</div>
<header class="nav-menu fixed">
    <nav class="navbar normal transparent">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="/">
                    <img src="/images/motrip-logo.png" alt="">
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
                        <a href="#">Motrip <i class="fa fa-chevron-down nav-arrow"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="home_default.html">모여행이란</a></li>
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
                    <li> <a href="login_page.html"><span class="icon-user"></span>로그인</a>
                    </li>
                    <li class="dropdown" id="alarm-set-area">
                        <a href="#"><span class="icon-bell"></span><span class="badge badge-danger">3</span></a>
                        <ul id="alarm-thumbnail-area" class="dropdown-menu  dropdown-menu-right cart-menu">

                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <div id="alarm-modal-area">
        </div>
        <div class="alarm-info-area">
            <%--어플리케이션 스코프로부터 값을 받거나, 3이다.--%>
            <input type="hidden" id="pollingTime" value="${applicationScope.alarmPollingTime}">
            <input type="hidden" id="alarmUserId" value="${sessionScope.user.userId}">
            <input type="hidden" id="alarmCurrentPage" value="1">
        </div>
    </nav>
</header>
