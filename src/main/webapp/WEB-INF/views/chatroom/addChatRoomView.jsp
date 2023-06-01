<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bit.motrip.domain.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅방 추가</title>
</head>
<body>
<h1>채팅방 추가완료</h1>
<table>
    <tr>
        <td width="104" class="ct_write">채팅방 제목</td>
        <td bgcolor="D6D6D6" width="1"></td>
        <td class="ct_write01">${chatRoom.chatRoomTitle}</td>
    </tr>
    <tr>
        <td width="104" class="ct_write">여행 시작일</td>
        <td bgcolor="D6D6D6" width="1"></td>
        <td class="ct_write01">${chatRoom.travelStartDate}</td>
    </tr>
    <tr>
        <td width="104" class="ct_write">나잇대</td>
        <td bgcolor="D6D6D6" width="1"></td>
        <td class="ct_write01">${chatRoom.ageRange}</td>
    </tr>
    <tr>
        <td width="104" class="ct_write">최대 인원수</td>
        <td bgcolor="D6D6D6" width="1"></td>
        <td class="ct_write01">${chatRoom.maxPersons}</td>
    </tr>
    <tr>
        <td width="104" class="ct_write">여행 번호</td>
        <td bgcolor="D6D6D6" width="1"></td>
        <td class="ct_write01">${chatMember.tripPlanNo}</td>
    </tr>
    <tr>
        <td width="104" class="ct_write">유저 이름</td>
        <td bgcolor="D6D6D6" width="1"></td>
        <td class="ct_write01">${chatMember.userId}</td>
    </tr>
    <button id="chatRoomList" onclick="location.href='/chatRoom/chatRoomList'">채팅리스트</button>
</table>
</body>
</html>