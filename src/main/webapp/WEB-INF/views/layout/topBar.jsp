<%@ page import="com.bit.motrip.domain.User" %><%--
  Created by IntelliJ IDEA.
  User: ksg
  Date: 2023-05-29
  Time: 오후 2:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <hr/>
    <button id="login" onclick="location.href='/user/login'">로그인/회원가입</button>
    <button type="button" id="tripPlanList" onclick="location.href='/tripPlan/tripPlanList'">여행플랜 목록이동</button>
    <button id="addReview" onclick="location.href='/review/addReviewView'">후기작성</button>
    <button id="noticeList" onclick="location.href='/notice/getNoticeList'">공지사항</button>

    <div>
        현재 로그인중인 유저 : ${sessionScope.user.userId}<br/>
        <button id="loginAsUser1" onclick="location.href='/test/login/user1'">user1</button>
        <button id="loginAsUser2" onclick="location.href='/test/login/user2'">user2</button>
        <button id="loginAsAdmin" onclick="location.href='/test/login/admin'">admin</button>
        <button id="logout" onclick="location.href='/test/logout'">로그아웃</button>
    </div>
    <hr/>
</header>