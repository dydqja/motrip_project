<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>후기작성이 가능한 여행플랜 목록</title>
  <style>
    body {
      font-family: 'Raleway', sans-serif;
      background-color: rgba(243, 239, 233, 0.89); /* 옅은 오트밀색 배경 */
      display: flex;
      align-items: center;
      justify-content: flex-end; /* 하단 오른쪽으로 정렬 */
      min-height: 100vh;
      margin: 0;
      padding: 30px; /* 바깥 여백 추가 */
      box-sizing: border-box;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 70px;
      border-radius: 20px; /* 모서리가 둥근 사각형 */
      background-color: #fff; /* 하얀색 배경 */
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    }

    h1 {
      text-align: center;
      font-size: 28px;
      color: #357a38; /* 진녹색 */
    }

    h5 {
      text-align: center;
      font-size: 15px;
      color: #696b69; /* 진녹색 */
    }



    form {
      margin-bottom: 20px;
      text-align: center;
    }

    input[type="text"] {
      padding: 5px;
      width: 200px;
    }

    button[type="submit"] {
      padding: 5px 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
      border-radius: 10px; /* 모서리가 둥근 사각형 */
      overflow: hidden; /* 내용이 넘칠 경우를 대비하여 숨김 처리 */
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    }

    th, td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #ccc;
    }

    th {
      background-color: #efecec;
    }

    .button-container {
      display: flex;
      flex-direction: row; /* 가로 정렬로 수정 */
      justify-content: flex-end; /* 오른쪽 정렬로 수정 */
      margin-top: 20px; /* 상단 여백 추가 */
    }

    .button-container button {
      font-family: 'Open Sans', sans-serif;
      font-size: 15px; /* 글자 크기 18px로 변경 */
      font-weight: bold;
      letter-spacing: 0.05em;
      padding: 7px 12px; /* 크기 2배로 변경 */
      margin-bottom: 8px;
      text-transform: uppercase;
      border: none;
      color: #fff;
      background-color: #558B2F; /* 버튼 색상 변경 */
      border-radius: 6px; /* 모서리가 둥근 사각형 */
    }

    #cancelBtn {
      padding: 14px 30px; /* 크기 2배로 변경 */
    }

  </style>

  <script>
    function getCompletedTripPlanList() {
      // 메서드 시작 시 로그 출력
      console.log('getCompletedTripPlanList(): 호출됨.');

      // 메서드 종료 시 로그 출력
      console.log('getCompletedTripPlanList(): 작동 완료.');
    }
    // getCompletedTripPlanList() 메서드 호출
    getCompletedTripPlanList();
  </script>
  <script>
    function cancelForm() {
      history.go(-1); // 이전 페이지로 이동
    }
  </script>


</head>
<body>
<div class="container">
  <h1>후기작성이 가능한 여행플랜 목록</h1>
  <h5>여행을 마친 플랜만 후기로 작성할 수 있어요.</h5>

  <div style="margin-bottom: 80px;"></div><!--그냥 여백-->

  <table>
    <thead>
    <tr>
      <th>여행플랜번호</th>
      <th>제목</th>
      <th>등록일</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${tripPlanList}" var="tripPlan" >
      <tr>
        <td style="text-align: center;">${tripPlan.tripPlanNo}</td>
        <td>
          <a href="addReviewView?tripPlanNo=${tripPlan.tripPlanNo}">
              ${tripPlan.tripPlanTitle}</a>
        </td>
        <td>${tripPlan.tripPlanRegDate}</td>
      </tr>
    </c:forEach>

    </tbody>
  </table>
  <div style="margin-bottom: 80px;"></div><!--그냥 여백-->
  <div class="button-container">
    <button id="cancelBtn" onclick="cancelForm()">작성취소</button>
  </div>

</div>

</body>
</html>