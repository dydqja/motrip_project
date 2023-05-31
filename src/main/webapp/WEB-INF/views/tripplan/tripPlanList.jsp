<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>motip</title>

    <script type="text/javascript">
        $(document).ready(function() {
            $(".ct_list_pop td:nth-child(3)").on("click", function() {
                console.log($(this).find("input").val());
                var tripPlanNo = $(this).find("input").val();
                window.location.href = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
            });
        });

        $(function() {
              $("button[id='addTripPlan']").on("click", function() {
                      window.location.href = "/tripPlan/addTripPlanView";
              });
        });

        $(function() {
              $("button[id='btnDelete']").on("click", function() {
                    var tripPlanNo = this.value;
                    alert("여행플랜번호 : " + tripPlanNo);

                    $.ajax({
                            url: "/tripPlan/tripPlanDeleted",
                            type: "GET",
                            data: { "tripPlanNo" : tripPlanNo},
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                console.log("여행플랜 삭제 성공");
                            },
                            error: function (xhr, status, error) {
                                console.log("여행플랜 삭제 실패");
                            }
                    });

              });
        });

    </script>

</head>
	<body>
		<div class="join-container">
			<header class="join-header">
			<h1><i class="fas fa-smile">
			</i> 여행플랜 리스트 테스트 </h1>
			</header>
		<main class="join-main">

			<table>
					<tr>
						<td align="center" width="200">No</td>
						<td></td>
						<td align="center" width="200">여행플랜 타이틀</td>
						<td></td>
						<td align="center" width="200">여행플랜 작성자</td>
						<td></td>
						<td align="center" width="200">여행일수</td>
						<td></td>
						<td align="center" width="200">작성날짜</td>
						<td></td>
						<td align="center" width="200">여행플랜 추천수</td>
						<td></td>
						<td align="center" width="200">여행플랜 조회수</td>
						<td></td>
						<td align="center" width="200">여행플랜 번호</td>
                        <td></td>
                        <td></td>
					</tr>
					<tr>
						<td colspan="15" bgcolor="808285" height="1"></td>
					</tr>
						<c:set var="i" value="0" />
						<c:forEach var="tripPlan" items="${tripPlanList}">
						<c:set var="i" value="${ i+1 }" />
						<tr class="ct_list_pop">
						<td align="center" width="200">${i}</td>
                        <td></td>
						<td align="center" width="200">${tripPlan.tripPlanTitle} <input type="hidden" value="${tripPlan.tripPlanNo}" id="tripPlanNo" /></td>
						<td></td>
						<td align="center" width="200">${tripPlan.tripPlanAuthor}</td>
						<td></td>
						<td align="center" width="200">${tripPlan.tripDays}</td>
                        <td></td>
                        <td align="center" width="200">${tripPlan.tripPlanRegDate}</td>
                        <td></td>
                        <td align="center" width="200">${tripPlan.tripPlanLikes}</td>
                        <td></td>
                        <td align="center" width="200">${tripPlan.tripPlanViews}</td>
                        <td></td>
                        <td align="center" width="200">${tripPlan.tripPlanNo}</td>
                        <td></td>
                        <td align="center" width="200">
                            <button id="btnDelete" value="${tripPlan.tripPlanNo}">여행플랜 삭제</button>
                        </td>
				    </tr>
				    <td colspan="15" bgcolor="808285" height="1"></td>
			    </c:forEach>
		    </table>

    </main>
</div>
<button type="button" id="addTripPlan">여행플랜 작성</button>
</body>
</html>