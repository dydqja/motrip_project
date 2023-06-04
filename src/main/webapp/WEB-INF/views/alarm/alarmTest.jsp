<%--
  Created by IntelliJ IDEA.
  User: bitcamp
  Date: 2023-06-01
  Time: 오전 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
</style>
<script src="/js/alarm/alarm.js"></script>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<li class="dropdown" id="alarm-set-area">
    <div id="alarm-modal-area">
    </div>
    <div class="alarm-info-area">
        <%--어플리케이션 스코프로부터 값을 받거나, 3이다.--%>
        <input type="text" id="pollingTime" value="${applicationScope.alarmPollingTime}">
        <input type="text" id="userId" value="${sessionScope.user.userId}">
        <input type="text" id="alarmCurrentPage" value="1">
    </div>
    <span class="icon-bell" style="position: relative;">
    </span>
    <span class="badge bg-danger" id="unreadAlarmCount">0</span>
    <ul id="alarm-thumbnail-area" class="dropdown-menu  dropdown-menu-right cart-menu">
        <li class="dropdown-header">
            <a href="" id="getAlarmListBtn" class="btn btn-line btn-primary hvr-underline-from-center">최근 알람 보기</a>
            <a href="" id="getHoldAlarmListBtn" class="btn btn-line btn-primary hvr-underline-from-center">보류 알람 보기</a>
        </li>
        <li class="alarm-thumbnail">
            <img src="http://placehold.it/40x40" alt="" class="item-img">
            <span class="delete icon-trash"></span>
            <div class="text">
                Lorem ipsum dolor sit amet, consectetur.
                <p>USD 473 X 2</p>
            </div>
        </li>
        <li class="alarm-thumbnail">
            <img src="http://placehold.it/40x40" alt="" class="item-img">
            <span class="delete icon-trash"></span>
            <div class="text">
                Lorem ipsum dolor sit amet, consectetur.
                <p>USD 473 X 2</p>
            </div>
        </li>
        <li class="alarm-thumbnail">
            <img src="http://placehold.it/40x40" alt="" class="item-img">
            <span class="delete icon-trash"></span>
            <div class="text">
                Lorem ipsum dolor sit amet, consectetur.
                <p>USD 473 X 2</p>
            </div>
        </li>
    </ul>
    <br><br><br><br><br><br><br>
    <div class="hidden" id="newAlarmDialog"></div>
</li>





<%--

<div class="alarm-set-area">
        bell
        <div>
            <button id="alarmUnreadCount">5</button><br>
            <button id="addAlarmTest" >테스트용 알람생생기</button><br>
            <button id="alarm-modalize">알람을 모달화</button>
        </div>
        <div class="alarm-area">
            <div class="alarm-control-area">
                <input type="text" id="alarmCurrentPage" value="${empty sessionScope.alarmCurrentPage ? '1' : sessionScope.alarmCurrentPage}" readonly><br/>
                <input type="text" id="alarmPollingTime" value="${empty applicationScope.alarmPollingTime ? '30' : sessionScope.alarmCurrentPage}" readonly><br/>
                <input type="text" id="alarmPollingCount" value="0" readonly><br/>
                <button type="button" id="alarmPrevPage">▲</button>
            </div>
            <div class="alarm-list-area" style="background-color: black;">
                <button class="alarm-thumbnail" value="JsonDetail">ㅁㅁㅁㅁ채팅방으로 초대되셨습니다.</button><br>
                <button class="alarm-thumbnail" value="JsonDetail">ㅁㅁ/리뷰/이 추천(43+1)을 받았습니다.</button><br>
                <button class="alarm-thumbnail" value="JsonDetail">ㅁㅁ일까지 정지되셨습니다.</button><br>
            </div>
            <div class="after-alarm-control-area">
                <button type="button" id="alarmNextPage">▼</button>
            </div>
        </div>
        <div id="alarm-modal-area">
            <div class="alarm-contents">
                <h1>알람의 내용입니다.</h1>
            </div>
            <div clsass="alarm-control-area">
                <button type="button" id="alarm-confirm">확인</button>
                <button type="button" id="alarm-navigate" value="url">이동</button>
                <button type="button" id="alarm-accept" value="url">수락</button>
                <button type="button" id="alarm-reject" value="url">거절</button>
                <button type="button" id="alarm-hold" value="url"></button>
            </div>
        </div>
        </div>
</div>--%>
