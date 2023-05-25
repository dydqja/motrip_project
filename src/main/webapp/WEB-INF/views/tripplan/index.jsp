<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<title>Hello World</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    $(function() {
        $("button").on("click", function() {
            window.location.href = "/tripPlan/tripPlanList";
        });
    });



    $(function() {
           $("button[id='addTripPlan']").on("click", function() {
               window.location.href = "/tripPlan/addTripPlanView";
           });
    });
</script>

</head>
<body>
<h1>Hello World!</h1>

<button type="button" id="addTripPlan">여행플랜 작성</button>
</body>
</html>
