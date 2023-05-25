<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>motrip</title>

    <script type="text/javascript">
            $(function() {
                     $("button[id='updateTripPlan']").on("click", function() {
                        window.location.href = "/tripPlan/updateTripPlan";
                     });
            });

            $(function() {
                     $("button[id='history']").on("click", function() {
                          console.log("이전");
                     });
            });
    </script>

</head>
<body>
    <h1>여행플랜</h1>
    <td colspan="5"><hr></td>
    <table>
        <tr>
            <th align="center" width="200">작성자 아이디</th>
            <th align="center" width="200">여행플랜 제목</th>
            <th align="center" width="200">총 여행일수</th>
            <th align="center" width="200">작성날짜</th>
            <th align="center" width="200">추천수</th>
            <th align="center" width="200">조회수</th>
            <th align="center" width="200">여행플랜 번호</th>
        </tr>
        <tr>
            <td align="center" width="200">${tripPlan.tripPlanAuthor}</td>
            <td align="center" width="200">${tripPlan.tripPlanTitle}</td>
            <td align="center" width="200">${tripPlan.tripDays}</td>
            <td align="center" width="200">${tripPlan.tripPlanRegDate}</td>
            <td align="center" width="200">${tripPlan.tripPlanLikes}</td>
            <td align="center" width="200">${tripPlan.tripPlanViews}</td>
            <td align="center" width="200">${tripPlan.tripPlanNo}</td>
        </tr>
    </table>
    <td colspan="5"><hr></td>
    <c:set var="i" value="0" />
    <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
        <c:set var="i" value="${ i+1 }" />
        <h2>${i}일차 여행플랜</h2>
        <table>
            <tr>
                <th align="center" width="200">여행플랜 본문</th>
                <th align="center" width="200">총 이동시간</th>
                <th align="center" width="200">일차별 여행플랜 번호</th>
            </tr>
            <tr>
                <td align="center" width="200">${dailyPlan.dailyPlanContents}</td>
                <td align="center" width="200">${dailyPlan.totalTripTime}</td>
                <td align="center" width="200">${dailyPlan.dailyPlanNo}</td>
            </tr>
        </table>

        <h2>명소</h2>
        <td>
            <table>
                    <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                    <tr>
                        <td align="center" width="200">명소태그 : ${place.placeTags}</td>
                        <td align="center" width="200">명소좌표 : ${place.placeCoordinates}</td>
                        <td align="center" width="200">명소전화번호 : ${place.placePhoneNumber}</td>
                        <td align="center" width="200">명소주소 : ${place.placeAddress}</td>
                        <td align="center" width="200">카테고리 : ${place.placeCategory}</td>
                        <td align="center" width="200">명소번호 : ${place.placeNo}</td>
                    </tr>
                    </c:forEach>
            </table>
        </td>
        <td colspan="5"><hr></td>
    </c:forEach>
    <button type="button" id="updateTripPlan">여행플랜 수정</button>
    <button type="button" id="history">이전</button>
</body>
</html>
