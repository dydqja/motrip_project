<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="navbar navbar-expand-lg navbar-light bg-light fixed-top">

    <div class="container">

        <a class="navbar-brand" href="/">

            <img src="/images/motrip-logo.png" alt="">
        </a>

        <div class="login-test">

            <c:if test="${empty sessionScope.user}">

                <button id="loginAsAdmin" onclick="location.href='/test/login/admin'">admin</button>
                <button id="loginAsUser1" onclick="location.href='/test/login/user1'">user1</button>
                <button id="loginAsUser2" onclick="location.href='/test/login/user2'">user2</button>

            </c:if>

            <c:if test="${not empty sessionScope.user}">

                ${user.userId}님 환영합니다.

                <button id="logout" onclick="location.href='/test/logout'">로그아웃</button>

            </c:if>

        </div>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse" id="navbarNav">

            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">

                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle" href="#" id="moyohaengDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">

                        모여행
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="moyohaengDropdown">

                        <li>
                            <a class="dropdown-item" href="home_default.html">모여행이란</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="home_slider.html">설계 포트폴리오</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="home_slider_with_searhbar.html">제작팀 소개</a>
                        </li>

                    </ul>

                </li>

                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle" href="#" id="tripPlanDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">

                        여행플랜
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="tripPlanDropdown">

                        <li>
                            <a class="dropdown-item" href="/tripPlan/tripPlanList">여행플랜 목록</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="/tripPlan/myTripPlanList">나의 여행플랜</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="/tripPlan/addTripPlanView">여행플랜 작성</a>
                        </li>

                    </ul>

                </li>

                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle" href="#" id="reviewDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">

                        후기
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="reviewDropdown">

                        <li>
                            <a class="dropdown-item" href="/review/addReviewView">후기 작성</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="/review/getReviewList">모든 후기</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="/review/getMyReviewList">나의 후기</a>
                        </li>

                    </ul>

                </li>

                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle" href="#" id="boardDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">

                        게시판
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="boardDropdown">

                        <li>
                            <a class="dropdown-item" href="/notice/noticeList">공지사항</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="/qna/qnaList">질의응답</a>
                        </li>

                    </ul>

                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="chatDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">

                        채팅
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="chatDropdown">

                        <li>
                            <a class="dropdown-item" href="/chatRoom/chatRoomList">채팅 리스트</a>
                        </li>

                    </ul>

                </li>


                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">

                        <span class="icon-user"></span> 회원
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="userDropdown">

                        <li>
                            <a class="dropdown-item" href="/user/login">로그인</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="/user/listUser">회원목록</a>
                        </li>

                    </ul>

                </li>

                <li class="nav-item">
                    <a class="nav-link position-relative" href="cart_page.html">
                        <span class="icon-minicart">
                            <span class="badge bg-danger position-absolute bottom-0 end-0">3</span>
                        </span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</header>

