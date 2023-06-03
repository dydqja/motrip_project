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
        // 여행플랜 선택하여 정보보기
        $(document).ready(function() {
            $(".ct_list_pop td:nth-child(3)").on("click", function() {
                if($(this).find("input").val() == 0){ // 삭제된 플랜을 눌렀을때는 아무동작도 하지않는다.

                } else {
                    console.log($(this).find("input").val());
                    var tripPlanNo = $(this).find("input").val();
                    window.location.href = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
                }
            });
        });
        // 여행플랜 삭제하기 버튼
        $(function() {
            $("button[id='btnDelete']").on("click", function() {
            var tripPlanNo = this.value;
            var row = $(this).closest("tr");
                $.ajax({
                    url: "/tripPlan/tripPlanDeleted",
                    type: "GET",
                    data: { "tripPlanNo" : tripPlanNo},
                    contentType: "application/json; charset=utf-8",
                    dataType: "JSON",
                    success: function (data) {
                        if (data.isPlanDeleted) {
                          row.css("background-color", "gray");
                          row.find(".tripPlanNo").val(0); // 숨겨진 요소의 값을 업데이트
                          row.find(".btnDelete").text("여행플랜 복구"); // 버튼 텍스트 업데이트
                        } else {
                          row.css("background-color", "white");
                          row.find(".tripPlanNo").val(data.tripPlanNo); // 숨겨진 요소의 값을 업데이트
                          row.find(".btnDelete").text("여행플랜 삭제"); // 버튼 텍스트 업데이트
                        }
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
			${tripPlan.tripPlanAuthor == '' ? '</i>여행플랜 리스트</h1>' : '</i>여행플랜 리스트</h1>'}
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
						<c:if test="${publicPlanList}">
                            <td></td>
                        </c:if>
                        <td></td>
                        <td align="center" width="200">공유 여부</td>
                        <td align="center" width="200">가져가기 가능여부</td>
					</tr>
					<tr>
						<td colspan="15" bgcolor="808285" height="1"></td>
					</tr>
						<c:set var="i" value="0" />
						<c:forEach var="tripPlan" items="${tripPlanList}">
						<c:set var="i" value="${ i+1 }" />
						<tr class="ct_list_pop" style="background-color: ${tripPlan.isPlanDeleted ? 'gray' : 'white'}">
						<td align="center" width="200">${i}</td>
                        <td></td>
						<td align="center" width="200">
						    ${tripPlan.tripPlanTitle}
						    <c:if test="${!tripPlan.isPlanDeleted}">
						        <input type="hidden" value="${tripPlan.tripPlanNo}" id="tripPlanNo" class="tripPlanNo"/>
						    </c:if>
						    <c:if test="${tripPlan.isPlanDeleted}">
						        <input type="hidden" value=0 id="tripPlanNo" id="tripPlanNo" class="tripPlanNo"/>
                            </c:if>
						</td>
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
                        <c:if test="${publicPlanList}">
                            <td align="center" width="200">
                                <c:if test="${tripPlan.isPlanDeleted}">
                                    <button id="btnDelete" class="btnDelete" value="${tripPlan.tripPlanNo}">여행플랜 복구</button>
                                </c:if>
                                <c:if test="${!tripPlan.isPlanDeleted}">
                                    <button id="btnDelete" class="btnDelete" value="${tripPlan.tripPlanNo}">여행플랜 삭제</button>
                                </c:if>
                            </td>
                        </c:if>
                        <td align="center" width="200">${tripPlan.isPlanPublic}</td>
                        <td align="center" width="200">${tripPlan.isPlanDownloadable}</td>
				    </tr>
				    <td colspan="15" bgcolor="808285" height="1"></td>
			    </c:forEach>
		    </table>

    </main>
</div>
</body>
</html>