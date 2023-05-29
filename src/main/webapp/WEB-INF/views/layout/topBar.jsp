<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <nav>
        <button id="login" onclick="location.href='/user/login'">로그인/회원가입</button>
        <button type="button" id="tripPlanList" onclick="location.href='/tripPlan/tripPlanList'">여행플랜 목록이동</button>
        <button id="addReview" onclick="location.href='/review/addReviewView'">후기작성</button>
        <button id="noticeList" onclick="location.href='/notice/getNoticeList'">공지사항</button>
    </nav>
    <div>
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

    <hr/>
</header>