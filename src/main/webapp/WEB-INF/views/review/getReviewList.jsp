<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>공개된 후기 게시글 목록</title>
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
    function getPublicReviewList() {
      // 메서드 시작 시 로그 출력
      console.log('getPublicReviewList(): 호출됨.');

      // 메서드 종료 시 로그 출력
      console.log('getPublicReviewList(): 작동 완료.');
    }
    // getPublicReviewList() 메서드 호출
    getPublicReviewList();
  </script>

</head>
<body>
<div class="container">
  <h1>공개된 후기 게시글 목록</h1>

  <form action="${pageContext.request.contextPath}/searchReview" method="GET">
    <input type="text" name="keyword" placeholder="후기 검색">
    <button type="submit">검색</button>
  </form>

  <table>
    <thead>
    <tr>
      <th>후기번호</th>
      <th>제목</th>
      <th>후기작성자</th>
      <th>등록일</th>
      <th>조회수</th>
      <th>좋아요</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="review" items="${reviewList}">
      <tr>
        <td>${review.reviewNo}</td>
        <td><a href='getReview?reviewNo=${review.reviewNo}'>${review.reviewTitle}</a></td>
        <td>${review.reviewAuthor}</td>
        <td>${review.reviewRegDate}</td>
        <td>${review.viewCount}</td>
        <td>${review.reviewLikes}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <div class="button-container">
    <a href="addReviewView">후기작성</a>
    <a href="getMyReviewList?reviewAuthor=${sessionScope.userId}">나의 후기1</a>
  </div>
</div>
</body>
</html>
