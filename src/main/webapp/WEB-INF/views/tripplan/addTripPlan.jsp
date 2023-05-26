<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>motip</title>
</head>

<script>
    // dailyplanResultMap에 새로운 DailyPlan 객체 추가
    function addDailyPlan() {
        // 새로운 DailyPlan 객체 생성
        var newDailyPlan = {
            dailyPlanNo: 0, // 적절한 값을 설정해야 함
            tripPlanNo: ${tripPlan.tripPlanNo}, // 적절한 값을 설정해야 함
            dailyPlanContents: '',
            totalTripTime: '',
            placeResultMap: []
        };

        // dailyplanResultMap에 추가
        ${tripPlan.dailyplanResultMap}.push(newDailyPlan);
    }

    // 선택한 DailyPlan 및 해당 DailyPlan에 속한 Place 객체 삭제
    function removePlace(dailyPlanNo, placeNo) {
        // 선택한 DailyPlan 객체 찾기
        var selectedDailyPlan;
        for (var i = 0; i < ${tripPlan.dailyplanResultMap}.length; i++) {
            if (${tripPlan.dailyplanResultMap}[i].dailyPlanNo === dailyPlanNo) {
                selectedDailyPlan = ${tripPlan.dailyplanResultMap}[i];
                break;
            }
        }

        // 선택한 Place 객체 삭제
        for (var j = 0; j < selectedDailyPlan.placeResultMap.length; j++) {
            if (selectedDailyPlan.placeResultMap[j].placeNo === placeNo) {
                selectedDailyPlan.placeResultMap.splice(j, 1);
                break;
            }
        }
    }
</script>

<body>

<h1>여행플랜 작성창</h1>
<button onclick="addDailyPlan()">추가</button>

<form action="addTripPlan" method="post">

<table>

<td><input type="hidden" name="tripPlanAuthor" value="admin" /></td>

<tr>
<td>여행플랜 제목</td>
<td><input type="text" name="tripPlanTitle" value="" /></td>
</tr>

<tr>
<td>여행일수</td>
<td><input type="text" name="tripDays" value="" />숫자만 가능</td>
</tr>

<tr>
<td>공유여부</td>
<td>
<input type="checkbox" name="isPlanPublic" value="true" />
<label for="isPlanPublic">true</label>
<input type="checkbox" name="isPlanPublic" value="false" />
<label for="isPlanPublic">false // 둘중에 하나만 해야합니다...</label>
</td>
</tr>

<tr>
<td>가져가기 가능여부</td>
<td>
<input type="checkbox" name="isPlanDownloadable" value="true" />
<label for="isPlanDownloadable">true </label>
<input type="checkbox" name="isPlanDownloadable" value="false" />
<label for="isPlanDownloadable">false // 둘중에 하나만 해야합니다...</label>
</td>
</tr>

</table>

<c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
    <h3>Daily Plan No: ${dailyPlan.dailyPlanNo}</h3>
    <table>
        <!-- DailyPlan 정보 작성 -->
        <tr>
            <th>Contents</th>
            <td><input type="text" name="dailyPlanContents_${dailyPlan.dailyPlanNo}" value="${dailyPlan.dailyPlanContents}"></td>
        </tr>
        <tr>
            <th>Total Trip Time</th>
            <td><input type="text" name="totalTripTime_${dailyPlan.dailyPlanNo}" value="${dailyPlan.totalTripTime}"></td>
        </tr>
    </table>

    <h4>명소 작성 창</h4>
    <!-- placeResultMap 작성 창 -->
    <table>
        <tr>
            <th>Place No</th>
            <th>Tags</th>
            <th>Coordinates</th>
            <th>Image</th>
            <th>Phone Number</th>
            <th>Address</th>
            <th>Category</th>
            <th>Trip Time</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="place" items="${dailyPlan.placeResultMap}">
            <tr>
                <td><input type="text" name="placeNo_${dailyPlan.dailyPlanNo}_${place.placeNo}" value="${place.placeNo}"></td>
                <td><input type="text" name="placeTags_${dailyPlan.dailyPlanNo}_${place.placeNo}" value="${place.placeTags}"></td>
                <td><input type="text" name="placeCoordinates_${dailyPlan.dailyPlanNo}_${place.placeNo}" value="${place.placeCoordinates}"></td>
                <td><input type="text" name="placeImage_${dailyPlan.dailyPlanNo}_${place.placeNo}" value="${place.placeImage}"></td>
                <td><input type="text" name="placePhoneNumber_${dailyPlan.dailyPlanNo}_${place.placeNo}" value="${place.placePhoneNumber}"></td>
                <td><input type="text" name="placeAddress_${dailyPlan.dailyPlanNo}_${place.placeNo}" value="${place.placeAddress}"></td>
                <td><input type="text" name="placeCategory_${dailyPlan.dailyPlanNo}_${place.placeNo}" value="${place.placeCategory}"></td>
                <td><input type="text" name="tripTime_${dailyPlan.dailyPlanNo}_${place.placeNo}" value="${place.tripTime}"></td>
                <td><button onclick="removePlace(${dailyPlan.dailyPlanNo}, ${place.placeNo})">삭제</button></td>
            </tr>
        </c:forEach>
    </table>

    <hr>
</c:forEach>


<input type="submit" value="저장" />

</form>

</body>
</html>