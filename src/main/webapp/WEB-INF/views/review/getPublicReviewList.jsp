<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html<html>
<head>
  <meta charset="UTF-8">
  <title>Public Review List</title>
</head>
<body>
<c:forEach var="review" items="${review}">
  <div>
    <h2>${review.reviewTitle}</h2>
    <img src="${review.reviewThumbnail}" alt="Review Thumbnail">
    <p>Author: ${review.reviewAuthor}</p>
    <p>Likes: ${review.reviewLikes}</p>
    <p>Views: ${review.viewCount}</p>
    <p>Date: ${review.reviewRegDate}</p>
  </div>
</c:forEach>
</body>
</html>