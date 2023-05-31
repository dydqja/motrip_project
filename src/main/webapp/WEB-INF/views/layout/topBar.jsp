<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .three-sections {
        display: flex;
        justify-content: space-between;
    }

    .left-section,
    .middle-section,
    .right-section {
        flex-basis: 33.33%;
    }


    /* 각 섹션의 스타일을 추가로 수정할 수 있습니다. */
    .left-section {
        /* 왼쪽 섹션의 스타일 */
    }

    .middle-section {
        /* 중간 섹션의 스타일 */
    }

    .right-section {
        /* 오른쪽 섹션의 스타일 */
    }
</style>
<div class="logo-section">
    <H1>[멋있는 로고]</H1>
</div>
<header class="three-sections">
    <nav class="left-section">
        <button id="login" onclick="location.href='/user/login'">로그인/회원가입</button>
        <button id="listUser" onclick="location.href='/user/listUser'">회원목록보기</button>
        <button type="button" id="listTripPlan" onclick="location.href='/tripPlan/listTripPlan'">여행플랜 목록이동</button>
        <button id="addReview" onclick="location.href='/review/addReviewView'">후기작성</button>
        <button id="noticeList" onclick="location.href='/notice/getNoticeList'">공지사항</button>
        <button type="button" id="addTripPlan" onclick="location.href='/tripPlan/addTripPlanView'">여행플랜 작성</button>
    </nav>
    <div class="middle-section">
        <c:if test="${empty sessionScope.user}">
            간편 로그인 버튼
            <button id="loginAsUser1" onclick="location.href='/test/login/user1'">user1</button>
            <button id="loginAsUser2" onclick="location.href='/test/login/user2'">user2</button>
            <button id="loginAsAdmin" onclick="location.href='/test/login/admin'">admin</button>
        </c:if>
        <c:if test="${not empty sessionScope.user}">
            ${user.userId}님 환영합니다.
            <button id="logout" onclick="location.href='/test/logout'">로그아웃</button>
        </c:if>
    </div>
    <div class="right-section">
        알람이 들어올 곳
    </div>

    <hr/>
</header>