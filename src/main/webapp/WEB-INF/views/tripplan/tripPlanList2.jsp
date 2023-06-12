<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<head>
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compastible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Mold Discover . HTML Template</title>

    <link rel="icon" type="image/png" href="/assets/img/favicon.png"/>
    <link rel="stylesheet" href="/assets/css/min/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">

    <script src="/vendor/jquery/dist/jquery.min.js"></script>
    <script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="/vendor/jquery.ui.touch-punch.min.js"></script>
    <script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>

    <script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
    <script src="/vendor/owlcarousel/owl.carousel.min.js"></script>
    <script src="/vendor/retina.min.js"></script>
    <script src="/vendor/jquery.imageScroll.min.js"></script>
    <script src="/assets/js/min/responsivetable.min.js"></script>
    <script src="/assets/js/bootstrap-tabcollapse.js"></script>

    <script src="/assets/js/min/countnumbers.min.js"></script>
    <script src="/assets/js/main.js"></script>


    <style>
        .center-div {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .btn-group label:not(:last-child) {
            margin-right: 30px;
        }

    </style>

</head>

<body>

<%--<header class="nav-menu fixed">--%>
    <%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%--</header>--%>

<div class="page-img" style="background-image: url('/images/tripplan2.jpg');">
    <div class="container">
        <div class="col-sm-8">
            <h1 class="main-head">여행플랜</h1>
        </div>
    </div>
</div>

<main>

    <input type="hidden" name="userId" value="${sessionScope.user.userId}">
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <div class="sort-title counter-div right">
                    <div class="sort-title counter-div"><span class="icon-map counter" style="color: green"
                                                              id="tripPlanCounter"></span>TripPlan
                    </div>
                </div>
                <label><br></label>
                <div class="border-box">
                    <div class="box-title">Search Condition</div>
                    <div class="center-div" style="width: 100%; height: 100%;">
                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="newDate">
                                <h4><span class="icon-calendar"></span>&nbsp<input type="radio" name="options"
                                                                                   id="newDate" checked></h4>
                                <h5>최신날짜순</h5>
                            </label>
                            <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="views">
                                <h4><span class="icon-eye"></span>&nbsp<input type="radio" name="options"
                                                                              id="views"></h4>
                                <h5>조회수</h5>
                            </label>
                            <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="likes">
                                <h4><span class="icon-hand-like"></span>&nbsp<input type="radio" name="options"
                                                                                    id="likes"></h4>
                                <h5>추천수</h5>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="sidebar">
                    <div class="border-box">
                        <div class="box-title">Trip Plan Search</div>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Title">
                            <div class="input-group-btn">
                                <button class="btn btn-primary">Search</button>
                            </div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">Trip Days Search</div>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Days">
                            <div class="input-group-btn"></div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="col-sm-8">

                <c:set var="i" value="0"/>
                <c:forEach var="tripPlan" items="${tripPlanList}">
                    <c:set var="i" value="${ i+1 }"/>
                    <div class="item-list trip-plan-item-list">
                        <div class="col-sm-5">
                            <div class="item-img row" style="background-image: url('/images/tripImage.jpg');"><input
                                    type="hidden"
                                    value="${tripPlan.tripPlanNo}"
                                    class="tripPlanNo"/></div>
                        </div>

                        <div class="col-sm-7">
                            <div class="item-desc">
                                <div>
                                    <h6 class="right">${tripPlan.tripPlanRegDate}</h6>
                                    <h5 class="item-title">${tripPlan.tripPlanTitle} </h5>
                                    <div class="sub-title">
                                        <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
                                            <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                                                <h6>#${place.placeTags}</h6>
                                            </c:forEach>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="right">
                                    <h4>${tripPlan.tripPlanAuthor}</h4>
                                    <div class="right"><span class="icon-date"></span>
                                        <c:if test="${tripPlan.tripDays == 1}">
                                            ${tripPlan.tripDays}일
                                        </c:if>
                                        <c:if test="${tripPlan.tripDays != 1}">
                                            ${tripPlan.tripDays-1}박 ${tripPlan.tripDays}일
                                        </c:if>
                                    </div>
                                    <div>
                                        <c:if test="${not empty sessionScope.user.userId}">
                                            <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                                <a href="/chatRoom/addChatRoom?tripPlanNo=${tripPlan.tripPlanNo}&userId=${sessionScope.user.userId}" type="button"
                                                   class="btn-sm btn-info right">채팅방 생성</a>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.user.userId && !tripPlan.isTripCompleted}">
                                            <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                                <button class="btn-sm btn-info right" name="tripPlanNo"
                                                        value="${tripPlan.tripPlanNo}">여행완료
                                                </button>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="item-book">

                                <button class="btn btn-sm btn-success" name="tripPlanNo"
                                        value="${tripPlan.tripPlanNo}">조회<input type="hidden"
                                                                                value="${tripPlan.tripPlanNo}"
                                                                                class="tripPlanNo"/>
                                </button>

                                <c:if test="${not empty sessionScope.user.userId && !tripPlan.isPlanDeleted && !tripPlan.isTripCompleted}">
                                    <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                        <button id="btnDelete" class="btn btn-sm btn-danger"
                                                value="${tripPlan.tripPlanNo}">삭제<input type="hidden"
                                                                                        value="${tripPlan.tripPlanNo}"
                                                                                        class="tripPlanNo"/>
                                        </button>
                                    </c:if>
                                </c:if>

                                <c:if test="${not empty sessionScope.user.userId && tripPlan.isPlanDeleted && !tripPlan.isTripCompleted}">
                                    <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                        <button id="btnDelete" class="btn btn-sm btn-info"
                                                value="${tripPlan.tripPlanNo}">복구<input type="hidden"
                                                                                        value="${tripPlan.tripPlanNo}"
                                                                                        class="tripPlanNo"/>
                                        </button>
                                    </c:if>
                                </c:if>

                                <div class="price">
                                    <label class="icon-hand-like">${tripPlan.tripPlanLikes}</label>
                                    <label></label>
                                    <label class="icon-eye">${tripPlan.tripPlanViews}</label>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>

                <nav aria-label="Page navigation example" class="text-center">

                    <ul class="pagination justify-content-center">

                        <li class="page-item ${page.currentPage == 1 ? 'disabled' : ''}">

                            <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${page.currentPage - 1}"
                               aria-label="Previous">
                                &laquo;
                            </a>

                        </li>

                        <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">

                            <li class="page-item ${i == page.currentPage ? 'active' : ''}">

                                <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${i}">${i}</a>

                            </li>

                        </c:forEach>

                        <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">

                            <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${page.currentPage + 1}"
                               aria-label="Next">
                                &raquo;
                            </a>

                        </li>

                    </ul>

                </nav>

            </div>

        </div>
    </div>

</main>

<!-- Current Page JS -->
<script src="/assets/js/min/priceslider.min.js"></script>

<script type="text/javascript">

    $(document).ready(function () {
        // 선택된 체크박스의 ID를 가져와서 정렬 순서 변경
        $('input[name="options"]').on('click', function () {
            var option = $(this).attr('id');
            console.log(option);
        });

        // 사진의 경우 여행플랜 삭제되었을때 아무것도 안눌리도록
        $(function () {
            $(".item-img").on("click", function () {
                var tripPlanNo = $(this).find(".tripPlanNo").val();
                if (tripPlanNo == 0) {
                    // 삭제된 플랜을 눌렀을 때 아무 작업도 하지 않음
                } else {
                    console.log(tripPlanNo);
                    window.location.href = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
                }
            });
        });

        // 버튼의 경우 여행플랜 삭제되었을때 아무것도 안눌리도록
        $(function () {
            $(".btn.btn-sm.btn-success").on("click", function () {
                var tripPlanNo = $(this).find(".tripPlanNo").val();
                if (tripPlanNo == 0) {
                    // 삭제된 플랜을 눌렀을 때 아무 작업도 하지 않음
                } else {
                    console.log(tripPlanNo);
                    window.location.href = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
                }
            });
        });

        // 여행플랜 삭제하기 버튼
        $(function () {
            $("button[id='btnDelete']").on("click", function () {
                var tripPlanNo = this.value;
                var delTripPlan = $(this).closest("tr");

                console.log(tripPlanNo);

                $.ajax({
                    url: "/tripPlan/tripPlanDeleted",
                    type: "GET",
                    data: {"tripPlanNo": tripPlanNo},
                    contentType: "application/json; charset=utf-8",
                    dataType: "JSON",
                    success: function (data) {
                        if (data.isPlanDeleted) {
                            delTripPlan.css("background-color", "gray");
                            delTripPlan.class("btn btn-sm btn-info");
                            delTripPlan.find(".btn btn-sm btn-info").val(0); // 숨겨진 요소의 값을 업데이트
                            delTripPlan.find(".btnDelete").text("복구"); // 버튼 텍스트 업데이트
                        } else {
                            delTripPlan.css("background-color", "white");
                            delTripPlan.class("btn btn-sm btn-danger");
                            delTripPlan.find(".btn btn-sm btn-danger").val(data.tripPlanNo); // 숨겨진 요소의 값을 업데이트
                            delTripPlan.find(".btnDelete").text("삭제"); // 버튼 텍스트 업데이트
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("여행플랜 삭제 실패");
                    }
                });
            });
        });

    });

</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>