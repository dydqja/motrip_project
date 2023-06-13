<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>후기작성이 가능한 여행플랜 목록</title>
  <style>
    body {
      font-family: Arial, sans-serif;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
    }

    h1 {
      text-align: center;
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
    }

    th, td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #ccc;
    }

    th {
      background-color: #f2f2f2;
    }

    .button-container {
      position: fixed;
      bottom: 20px;
      right: 20px;
      display: flex;
      flex-direction: column;
      align-items: flex-end;
    }

    .button-container a {
      margin-top: 10px;
      padding: 5px 10px;
      background-color: #f2f2f2;
      border: 1px solid #ccc;
      text-decoration: none;
      color: #333;
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

  <form action="review/searchReview" method="GET">
    <input type="text" name="keyword" placeholder="후기 검색">
    <button type="submit">검색</button>
  </form>

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
        <td>${tripPlan.tripPlanNo}</td>
        <td>
          <a href="addReviewView?tripPlanNo=${tripPlan.tripPlanNo}&tripPlanTitle=${tripPlan.tripPlanTitle}">
              ${tripPlan.tripPlanTitle}</a>
        </td>
        <td>${tripPlan.tripPlanRegDate}</td>
      </tr>
    </c:forEach>

    </tbody>
  </table>

  <div class="button-container">
    <button id="cancelBtn" onclick="cancelForm()">작성취소</button>
  </div>

</div>

</body>
</html>
