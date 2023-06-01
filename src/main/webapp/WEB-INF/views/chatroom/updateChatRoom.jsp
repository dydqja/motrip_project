<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bit.motrip.domain.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅방 수정</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">

        function fncAddChatroom(){
            $("form").attr("method","POST").attr("action","updateChatRoom").submit();
        }

        $(function() {
            $("#sub").on("click", function() {
                fncAddChatroom();
            });
        });

        const leaveBtn = document.getElementById('leave-btn');
        leaveBtn.addEventListener('click', () => {
            window.history.back();
        });
    </script>
</head>
</head>
<body>
<h1>채팅방 추가</h1>
<form name="addChatRoom">

    <input type="hidden" name="chatRoomNo" value="${chatRoom.chatRoomNo}"/>
    <input type="text" name="chatRoomTitle" value="${chatRoom.chatRoomTitle}" />
    <input type="date" name="travelStartDateHtml" value="${chatRoom.travelStartDate}" />
    <input type="text" name="ageRange" value="${chatRoom.ageRange}" />
    <input type="number" name="maxPersons" value="${chatRoom.maxPersons}" />
    <input type="number" name="tripPlanNo" value="1" />
    <input type="hidden" name="userId" value="${sessionScope.user.userId}"  >
    <table>

        <button id="sub" class="btn insert" style="color: blue;" >
            채팅방 참여
        </button>
        <a id="leave-btn" class="btn">취소</a>

</table>
</form>
</body>
</html>