<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bit.motrip.domain.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅방 추가</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">

        function fncAddChatroom(){
            $("form").attr("method","POST").attr("action","addChatRoom").submit();
        }

        $(function() {
            $("#sub").on("click", function() {
                fncAddChatroom();
            });
        });

    </script>
</head>
</head>
<body>
<h1>채팅방 추가</h1>
<form name="addChatRoom">
    <input type="text" name="chatRoomTitle" placeholder="채팅방 제목" />
    <input type="date" name="travelStartDateHtml" placeholder="여행 시작일" />
    <input type="text" name="ageRange" placeholder="나잇대" />
<%--    <input type="number" name="maxPersons" placeholder="최대 인원수" />--%>
    <input type="number" name="tripPlanNo" placeholder="여행 번호" />
<%--    <input type="hidden" name="userId" value="${userId}"/> <!--hidden 예정 -->--%>

    <input id="sub" type="submit" value="생성" />
</form>
</body>
</html>