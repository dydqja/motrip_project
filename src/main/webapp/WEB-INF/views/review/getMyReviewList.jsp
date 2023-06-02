<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Public Review List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        img {
            max-width: 100px;
            max-height: 100px;
        }
        .review-container {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
        }
        .review-title {
            font-size: 18px;
            font-weight: bold;
        }
        .review-thumbnail {
            max-width: 200px;
            max-height: 200px;
        }
        .review-info {
            margin-top: 10px;
        }
        .review-info p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
<table>
    <thead>
    <tr>
        <th>제목</th>
        <th>썸네일</th>
        <th>좋아요</th>
        <th>조회수</th>
        <th>날짜</th>

    </tr>
    </thead>
    <tbody>
    <c:forEach items="${myReviews}" var="review">
        <c:if test="${review.reviewAuthor eq user.userId}">
            <tr>
                <td><a href="getReview?reviewNo=${review.reviewNo}">${review.reviewTitle}</a></td>
                <td><img src="${review.reviewThumbnail}" alt="Review Thumbnail"></td>
                <td>${review.reviewLikes}</td>
                <td>${review.viewCount}</td>
                <td>${review.reviewRegDate}</td>
            </tr>
        </c:if>
    </c:forEach>
    </tbody>
</table>
<c:forEach var="review" items="${reviews}">
    <c:if test="${review.reviewAuthor eq user.userId}">
        <div class="review-container">
            <h2 class="review-title">${review.reviewTitle}</h2>
            <img class="review-thumbnail" src="${review.reviewThumbnail}" alt="Review Thumbnail">
            <div class="review-info">
                <p>Author: ${review.reviewAuthor}</p>
                <p>Likes: ${review.reviewLikes}</p>
                <p>Views: ${review.viewCount}</p>
                <p>Date: ${review.reviewRegDate}</p>
            </div>
        </div>
    </c:if>
</c:forEach>
</body>
</html>
