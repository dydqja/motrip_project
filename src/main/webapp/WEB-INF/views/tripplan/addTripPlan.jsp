<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>Add Trip Plan</title>
</head>
<body>

<h1>Add Trip Plan</h1>

<form action="addTripPlan" method="post">

<input type="hidden" name="tripPlanNo" value="${tripPlan.tripPlanNo}" />

<table>

<tr>
<td>Trip Plan Author</td>
<td><input type="text" name="tripPlanAuthor" value="${tripPlan.tripPlanAuthor}" /></td>
</tr>

<tr>
<td>Trip Plan Title</td>
<td><input type="text" name="tripPlanTitle" value="${tripPlan.tripPlanTitle}" /></td>
</tr>

<tr>
<td>Trip Plan Thumbnail</td>
<td><input type="text" name="tripPlanThumbnail" value="${tripPlan.tripPlanThumbnail}" /></td>
</tr>

<tr>
<td>Trip Days</td>
<td><input type="text" name="tripDays" value="${tripPlan.tripDays}" /></td>
</tr>

<tr>
<td>Trip Plan Reg Date</td>
<td><input type="text" name="tripPlanRegDate" value="${tripPlan.tripPlanRegDate}" /></td>
</tr>

<tr>
<td>Trip Plan Del Date</td>
<td><input type="text" name="tripPlanDelDate" value="${tripPlan.tripPlanDelDate}" /></td>
</tr>

<tr>
<td>Is Plan Deleted</td>
<td><input type="text" name="isPlanDeleted" value="${tripPlan.isPlanDeleted}" /></td>
</tr>

<tr>
<td>Is Plan Public</td>
<td><input type="text" name="isPlanPublic" value="${tripPlan.isPlanPublic}" /></td>
</tr>

<tr>
<td>Is Plan Downloadable</td>
<td><input type="text" name="isPlanDownloadable" value="${tripPlan.isPlanDownloadable}" /></td>
</tr>

<tr>
<td>Is Trip Completed</td>
<td><input type="text" name="isTripCompleted" value="${tripPlan.isTripCompleted}" /></td>
</tr>

<tr>
<td>Trip Plan Likes</td>
<td><input type="text" name="tripPlanLikes" value="${tripPlan.tripPlanLikes}" /></td>
</tr>

<tr>
<td>Trip Plan Views</td>
<td><input type="text" name="tripPlanViews" value="${tripPlan.tripPlanViews}" /></td>
</tr>

</table>

<input type="submit" value="Add Trip Plan" />

</form>

</body>
</html>