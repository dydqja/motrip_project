<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="com.bit.motrip.domain.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Photos</title>
    <style>
        .photos-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 20px;
            margin-top: 20px;
        }
        .photo-item {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
    </style>
</head>
<body>
<h1>Room Photos</h1>
<div class="photos-container">
    <c:set var="i" value="0" />
    <c:forEach var="photo" items="${photos}">
        <c:set var="i" value="${ i+1 }" />
        <div class="photo-item">
            <img src="/imagePath/${photo.photoId}" alt="Photo">
        </div>
    </c:forEach>
</div>
</body>
</html>
