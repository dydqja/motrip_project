<%--
  Created by IntelliJ IDEA.
  User: ksg
  Date: 2023-05-29
  Time: 오후 2:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header>
    <button id="login" onclick="location.href='/user/login'">로그인/회원가입</button>
    <button type="button" id="tripPlanList" onclick="location.href='/tripPlan/tripPlanList'">여행플랜 목록이동</button>
    <button id="addReview" onclick="location.href='/review/addReviewView'">후기작성</button>
    <button id="noticeList" onclick="location.href='/notice/getNoticeList'">공지사항</button>
</header>