<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

    <!-- jQuery 라이브러리 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


    <title>후기 상세 조회</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
        }

        h1 {
            font-size: 24px;
            margin: 0 0 20px;
        }

        h2 {
            font-size: 20px;
            margin: 0 0 10px;
        }

        h3 {
            font-size: 18px;
            margin: 0 0 10px;
        }

        p {
            margin: 0 0 10px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            margin-bottom: 10px;
        }

        .button-container {
            margin-top: 20px;
        }

        a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4caf50;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #45a049;
        }
    </style>


    <!-- AJAX를 사용한 댓글 작성과 목록 갱신 -->
    <script>
        $(document).ready(function() {
            // 댓글 작성 폼 제출 이벤트 핸들러
            $("#commentForm").submit(function(event) {
                event.preventDefault(); // 폼 제출 기본 동작 막기

                // 입력된 데이터 가져오기
                var reviewNo = $("#reviewNo").val();
                var author = $("#commentAuthor").val();
                var content = $("#commentContent").val();

                // AJAX 요청 보내기
                $.ajax({
                    url: "addComment", // 댓글 작성 요청 처리 URL
                    type: "POST",
                    data: {
                        reviewNo: reviewNo,
                        commentContent: content
                    },
                    success: function(data) {
                        // 성공적으로 처리되면 댓글 목록 갱신
                        $("#commentList").html(data);
                        $("#commentContent").val("");
                    },
                    error: function() {
                        alert("댓글 작성에 실패했습니다. 다시 시도해주세요.");
                    }
                });
            });
        });
    </script>
</head>
<body>
<div class="container">
    <h1>후기 상세 조회</h1>

    <c:if test="${getReview != null}">
        <h2>${getReview.reviewTitle}</h2>
        <p>작성자: ${getReview.reviewAuthor}</p>
        <p>작성일: ${getReview.reviewRegDate}</p>
        <p>조회수: ${getReview.viewCount}</p>
        <p>좋아요: ${getReview.reviewLikes}</p>
        <p>후기 내용: ${getReview.reviewContents}</p>

        <h3>댓글</h3>
        <c:if test="${not empty commentList}">
            <ul>
                <c:forEach var="comment" items="${commentList}">
                    <li>
                        작성자: ${comment.commentAuthor}<br>
                        작성일: ${comment.commentRegDate}<br>
                        내용: ${comment.commentContent}
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        <c:if test="${empty commentList}">
            <p>댓글이 없습니다.</p>
        </c:if>
    </c:if>

    <!-- 댓글 작성 폼 -->
    <!-- 댓글 작성 폼 -->
    <form id="commentForm">
        <input type="hidden" id="reviewNo" value="${getReview.reviewNo}">
        <input type="hidden" id="commentAuthor" value="${sessionScope.user.nickname}">
        <p>작성자: ${sessionScope.user.nickname}</p>
        <textarea id="commentContent" placeholder="상대방을 존중하는 댓글을 남깁시다." required></textarea><br>
        <button type="submit">댓글 작성</button>
    </form>


    <c:if test="${getReview == null}">
        <p>해당 후기를 찾을 수 없습니다.</p>
    </c:if>

    <div class="button-container">
        <a href="getReviewList">모든 후기 목록</a>
        <a href="getMyReviewList">나의 후기 목록</a>
    </div>
</div>
</body>
</html>
