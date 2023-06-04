<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--부트스트랩 css--%>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<%--제이쿼리 스크립트--%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%--부트스트랩 스크립트--%>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%--제이쿼리ui css--%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
<%--제이쿼리ui 스크립트--%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%--탑바 삼분할 스크립트--%>
<link rel="stylesheet" type="text/css" href="/css/layout/three-sections.css" />
<%--html body 부분 시작--%>

<div class="logo-section">
    <H1>[멋있는 로고]</H1>
</div>
<header class="three-sections">
    <nav class="left-section">
        <button id="login" onclick="location.href='/user/login'">로그인/회원가입</button>
        <button id="listUser" onclick="location.href='/user/listUser'">회원목록보기</button>
        <button type="button" id="tripPlanList1" onclick="location.href='/tripPlan/tripPlanList'">여행플랜 목록이동</button>
        <c:if test="${user.userId != null}">
            <button type="button" id="tripPlanList2" onclick="location.href='/tripPlan/myTripPlanList'">나의 여행플랜</button>
            <button type="button" id="tripPlanList3" onclick="location.href='/tripPlan/addTripPlanView'">여행플랜작성</button>
        </c:if>
        <button id="addReview" onclick="location.href='/review/addReviewView'">후기작성</button>
        <button id="getReviewList" onclick="location.href='/review/getReviewList'">모든 후기</button>
        <button id="getMyReviewList" onclick="location.href='/review/getMyReviewList'">나의 후기</button>
        <button id="noticeList" onclick="location.href='/notice/noticeList'">공지사항</button>
        <button id="qnaList" onclick="location.href='/qna/qnaList'">질의응답</button>
        <button id="chatRoomList" onclick="location.href='/chatRoom/chatRoomList'">채팅리스트</button>
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
    </div


    <div class="right-section">


    </div>
        <hr/>
</header>
<<%--아직 body 안. html 헤더 종료--%>

<%--스크립트 삽입--%>
<script>
    function getUnreadAlarmCount(userId){
        $ajax({
            url: "/alarm/getUnreadAlarmCount",
            data: {userId: userId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                if(data=0){
                    alert("읽지 않은 알람 수는"+data);
                    //2. 우선도가 1인 알람은 즉시 회원 사진 위에 다이얼로그를 띄운다.
                    //3. 이후 알람의 우선도를 2로 낮춘다.
                    //alert(""+data.emergencyAlarms);
                }else {
                    //alarmPollingCount 의 값을 1 올린다.
                    $("#alarmPollingCount").val(parseInt($("#alarmPollingCount").val())+1);
                }
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    }

    function changeRedDot(unreadCount){
        $("#alarmUnreadCount").text(unreadCount);
    }
    //제이쿼리 영역
    //알람 온오프 리스너
    $("#alarmOn").click(function () {
        event.preventDefault();
        //alarm-aria 를 토글한다.
        $(".alarm-area").toggle();
    });
    //알람 모달화 리스너
    $("#alarm-modalize").click(function () {
        event.preventDefault();
        $( "#alarm-modal-area" ).dialog({
            modal: true
        });
    });
    //알람 폴링 리스너
    $("#alarmPollingCount").change(function () {
        event.preventDefault();
        //alarm-aria 를 토글한다.
        $ajax({
            url: "/alarm/giveMeAlarms",
            type: "POST",
            dataType: "json",
            success: function (data) {
                alert("알람이 생성되었습니다.");
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    });


    //페이지 로드 직후 실행
    $(document).onload(function () {
        //3초를 대기한 뒤 에이젝스를 시작한다.
        setTimeout(getUnreadAlarmCount, 3000);
    });



    /*테스트용 펑션 영역*/
    //알람 생성기 테스트
    $(#addAlarmTest).click(function () {
        event.preventDefault();
        $.ajax({
            url: "/alarm/addAlarmTest",
            type: "POST",
            dataType: "json",
            success: function (data) {
                alert("알람이 생성되었습니다.");
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });
    });
</script>
