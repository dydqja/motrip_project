<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <title>Motip Review List</title>
</head>

<body>
<script>
  // 공개된 후기 목록 버튼 클릭 이벤트 처리
  function getPublicReviewList() {
    $.ajax({
      url: "/review/publicReviewList",
      type: "GET",
      success: function (data) {
        $("#reviewListContainer").html(data)
        console.log("publicReviewList 성공");
      },
      error: function (xhr, status, error) {
        console.log("publicReviewList 실패"+error);
      }
    });
  }

  // 나의 후기 목록 버튼 클릭 이벤트 처리
  function getMyReviewList() {
    // 로그인된 사용자의 ID를 가져옵니다.
    var loggedInUserId = '${user.userId}';
    console.log("sakdasd")
    console.log(loggedInUserId)
    // userId를 URL에 추가하여 요청합니다.
    $.ajax({
      url: "/review/myReviewList",
      type: "GET",
      data: { reviewAuthor: loggedInUserId },
      success: function (data) {
        $("#reviewListContainer").html(data)
        console.log("myReviewList 성공");
      },
      error: function (xhr, status, error) {
        console.log("myReviewList 실패"+error);
      }
    });
  }
</script>

<div>
  <!-- 공개된 후기 목록 버튼 -->
  <button onclick="getPublicReviewList()">공개된 후기 목록</button>

  <!-- 나의 후기 목록 버튼 -->
  <button onclick="getMyReviewList()">나의 후기 목록</button>
</div>

<div id="reviewListContainer">
  <!-- Ajax를 통해 동적으로 리뷰 목록이 표시될 부분 -->
</div>
</body>

</html>
