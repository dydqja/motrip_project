<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>✈️Motrip🚤</title>


    <!-- Form 유효성 검증 -->
    <script type="text/javascript">

        function fncAddReview() {
            var reviewTitle = $("input[name='reviewTitle']").val();
            var reviewContents = $("textarea[name='reviewContents']").val();
            var tripPlanNo = $("input[name='selectedTripPlanNo']").val();

            if (reviewTitle == null || reviewTitle.length < 1) {
                alert("후기 제목을 반드시 입력하여야 합니다.");
                return;
            }
            if (reviewContents == null || reviewContents.length < 1) {
                alert("후기 본문을 반드시 입력하여야 합니다.");
                return;
            }
            $("form")
                .attr("method", "post")
                .attr("action", "/review/addReview")
                .submit();
        }

        $(function () {
            $("button.btn.btn-primary").on("click", function () {
                fncAddReview();
            });

            $("a[href='#']").on("click", function () {
                $("form")[0].reset(); 0
            });
        });

        $(function () {
            $("#checkStatusBtn").on("click", function () {
                var isPublic = $(".isReviewPublic").is(":checked");
                var status = isPublic ? "True" : "False";
                alert("현재 공개여부: " + status);
            });
        });
    </script>

    <!-- 모달 JavaScript 코드 -->
    <script>
        $(document).ready(function() {
            $("#tripPlanModal").modal("show");
        });
    </script>
    <script>
        function selectTripPlan(tripPlanTitle, tripPlanNo) {
            $("#selectedTripPlanTitle").val(tripPlanTitle);
            $("#selectedTripPlanNo").val(tripPlanNo); // Set the tripPlanNo value
            $("#displaySelectedTripPlanNo").text(tripPlanNo);
            $("#displaySelectedTripPlanTitle").text(tripPlanTitle);
            $("#tripPlanModal").modal("hide");
        }

    </script>

    <!-- Bootstrap, jQuery CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 화면구성 div Start -->
<!-- 모달 창 내용 -->
<div id="tripPlanModal" class="modal">
    <div class="modal-content">
        <h4>✈️✈️Trip Plans✈️✈️</h4>
        <ul>
            <c:if test="${not empty tripPlanList['tripPlanList']}">
                <ul>
                    <c:forEach items="${tripPlanList['tripPlanList']}" var="tripPlan">
                        <li>
                            <a href="#" onclick="selectTripPlan('${tripPlan.tripPlanTitle}', '${tripPlan.tripPlanNo}')">${tripPlan.tripPlanTitle}</a>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </ul>
    </div>
</div>

<div class="container">
    <h1>후기 작성</h1>
    <!-- form Start -->
    <form action="/review/addReview" method="post">
        <div class="row">
            <div class="col-xs-4 col-md-2"><strong>Selected TripPlanTitle:</strong></div>
            <div class="col-xs-8 col-md-4">
                <input type="hidden" id="selectedTripPlanTitle" name="selectedTripPlanTitle" value="${TripPlan.tripPlanTitle}" />
                <input type="hidden" id="selectedTripPlanNo" name="tripPlanNo" value="" />
                <span id="displaySelectedTripPlanTitle"></span>
            </div>
        </div>

        <div class="form-group">
            <label for="reviewAuthor">Review Author:</label>
            <input type="text" id="reviewAuthor" name="reviewAuthor" required><br><br>
        </div>
        <div class="form-group">
            <label for="reviewTitle">제목:</label>
            <input type="text" id="reviewTitle" name="reviewTitle" required /><br><br>
        </div>
        <div class="form-group">
            <label for="reviewContents">내용:</label><br>
            <textarea id="reviewContents" name="reviewContents" required></textarea><br><br>
        </div>
        <div class="form-group">
            <label for="reviewThumbnail">썸네일:</label>
            <input type="text" id="reviewThumbnail" name="reviewThumbnail" required /><br><br>
        </div>
        <div class="form-group">
            <label for="instaPostLink">인스타그램 링크:</label>
            <input type="text" id="instaPostLink" name="instaPostLink" required /><br><br>
        </div>
        <div class="form-group">
            <label class="switch">
                <input class="isReviewPublic" type="checkbox" />
                <span class="switch-label" data-on="True" data-off="False"></span>
                <span>공개여부</span>
                <span class="switch-handle"></span>
            </label>
            <button class="btn btn-primary" id="checkStatusBtn">상태 확인</button>
        </div>
        <div class="form-group">
            <label for="reviewLikes">Review Likes:</label>
            <input type="number" id="reviewLikes" name="reviewLikes" required><br><br>
        </div>
        <div class="form-group">
            <label for="viewCount">View Count:</label>
            <input type="number" id="viewCount" name="viewCount" required><br><br>
        </div>


        <div class="form-group">
            <label class="switch">
                <input class="isReviewDeleted" type="checkbox" />
                <span class="switch-label" data-on="True" data-off="False"></span>
                <span>isReviewDeleted</span>
                <span class="switch-handle"></span>
            </label>
            <button class="btn btn-primary" id="isReviewDeleted">상태 확인</button>
        </div>

        <div class="form-group">
            <label for="reviewDelDate">Review Delete Date:</label>
            <input type="date" id="reviewDelDate" name="reviewDelDate"><br><br>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-4 col-sm-4 text-center">
                <button type="submit" class="btn btn-primary mr-2">작성완료</button>
                <a class="btn btn-primary" href="#" role="button">취소</a>
            </div>
        </div>
    </form>
    <!-- form End -->
</div>
<!-- 화면구성 div End -->
</body>
</html>
