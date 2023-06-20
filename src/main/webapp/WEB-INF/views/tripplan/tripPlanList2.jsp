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

    <script type="text/javascript">

        $(document).ready(function () {
            var radioButtonId = '${search.planCondition}';
            // 해당 라디오 버튼을 체크 상태로 설정
            document.getElementById(radioButtonId).checked = true;
        });

    </script>

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
                                                              id="tripPlanCounter">${page.totalCount}</span>TripPlan
                    </div>
                </div>
                <label><br></label>
                <div class="border-box">
                    <div class="box-title">정렬 조건</div>
                    <div class="center-div" style="width: 100%; height: 100%;">
                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="newDate">
                                <h4><span class="icon-calendar"></span>&nbsp
                                    <input type="radio" name="options" id="newDate"
                                           value="newDate" OnClick="window.location.href='/tripPlan/tripPlanList?type=${condition}&planCondition=newDate'"></h4>
                                <h5>최신날짜순</h5>
                            </label>
                            <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="views">
                                <h4><span class="icon-eye"></span>&nbsp<input type="radio" name="options"
                                                                              id="views" value="views" OnClick="window.location.href='/tripPlan/tripPlanList?type=${condition}&planCondition=views'"></h4>
                                <h5>조회수</h5>
                            </label>
                            <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="likes">
                                <h4><span class="icon-hand-like"></span>&nbsp<input type="radio" name="options"
                                                                                    id="likes" value="likes" OnClick="window.location.href='/tripPlan/tripPlanList?type=${condition}&planCondition=likes'"></h4>
                                <h5>추천수</h5>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="sidebar">
                    <div class="border-box">
                        <div class="box-title">여행플랜 검색</div>
                        <div class="input-group">
                            <input type="text" name="searchKeyword" id="searchKeyword" value="" class="form-control" placeholder="여행플랜 타이틀">
                            <div class="input-group-btn">
                                <button class="btn btn-primary" id="searchButton">검색</button>
                            </div>
                        </div>
                    </div>

<%--                    <div class="border-box">--%>
<%--                        <div class="box-title">Trip Days Search</div>--%>
<%--                        <div class="input-group">--%>
<%--                            <input type="text" class="form-control" placeholder="Days">--%>
<%--                            <div class="input-group-btn"></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

                </div>
            </div>

            <div class="col-sm-8">

                <c:set var="i" value="0"/>
                <c:forEach var="tripPlan" items="${tripPlanList}">
                    <c:set var="i" value="${ i+1 }"/>
                    <div class="item-list trip-plan-item-list">
                        <div class="col-sm-5">
                            <c:if test="${tripPlan.tripPlanThumbnail != null && tripPlan.tripPlanThumbnail != ''}">
                                <div class="item-img row" style="background-image: url('/imagePath/thumbnail/${tripPlan.tripPlanThumbnail}');">
                                    <input type="hidden" id="tripPlanImage${tripPlan.tripPlanNo}"
                                            <c:if test="${tripPlan.isPlanDeleted}">
                                                value="0"
                                            </c:if>
                                            <c:if test="${!tripPlan.isPlanDeleted}">
                                                value="${tripPlan.tripPlanNo}"
                                            </c:if>
                                           class="tripPlanNo"/></div>
                            </c:if>
                            <c:if test="${tripPlan.tripPlanThumbnail == ''}">
                            <div class="item-img row" style="background-image: url('/images/tripImage.jpg');">
                                <input type="hidden" id="tripPlanImage${tripPlan.tripPlanNo}"
                                    <c:if test="${tripPlan.isPlanDeleted}">
                                        value="0"
                                    </c:if>
                                    <c:if test="${!tripPlan.isPlanDeleted}">
                                        value="${tripPlan.tripPlanNo}"
                                    </c:if>
                                    class="tripPlanNo"/></div>
                            </c:if>
                        </div>

                        <div class="col-sm-7">
                            <div class="item-desc">
                                <div style="margin-top: -25px">
                                    <h6 class="right">${tripPlan.strDate}</h6>
                                    <h5 class="item-title">${tripPlan.tripPlanTitle} </h5>
                                    <div class="sub-title">
                                        <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
                                            <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                                                <h6 style="text-overflow: ellipsis">#${place.placeTags}</h6>
                                            </c:forEach>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="right" style="margin-top: -8px">
                                    <h4>${tripPlan.tripPlanNickName}<div class="hidden">${tripPlan.tripPlanAuthor}</div></h4>
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
                                                <a href="/chatRoom/addChatRoom?tripPlanNo=${tripPlan.tripPlanNo}&userId=${sessionScope.user.userId}"
                                                        <c:if test="${tripPlan.isPlanDeleted}">
                                                            style="display: none;"
                                                        </c:if>
                                                   type="button" id="addChatRoom${tripPlan.tripPlanNo}"
                                                   class="btn-sm btn-info right" >채팅방 생성</a>
                                            </c:if>
                                        </c:if>

                                        <c:if test="${tripPlan.chatRoomNo != 0 && condition == 'all'}">
                                            <button type="button" onclick="chatRoomRequest(${tripPlan.chatRoomNo})"
                                                    class="btn-sm btn-warning right" style="height: 25px; font-size: 8px">채팅방 접속</button>
                                        </c:if>

                                        <c:if test="${not empty sessionScope.user.userId && !tripPlan.isTripCompleted}">
                                            <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                                <button class="btn-sm btn-info right tripPlanComplete" name="tripPlanNo"
                                                        <c:if test="${tripPlan.isPlanDeleted}">
                                                            style="display: none;"
                                                        </c:if>
                                                        id="tripPlanComplete${tripPlan.tripPlanNo}"
                                                        value="${tripPlan.tripPlanNo}" style="height: 25px; font-size: 8px">여행완료
                                                </button>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="item-book" style="margin-top: -5px">

                                <button class="btn btn-sm btn-success" name="tripPlanNo"
                                        <c:if test="${tripPlan.isPlanDeleted}">
                                            style="display: none;"
                                        </c:if>
                                        id="tripPlanView${tripPlan.tripPlanNo}"
                                        value="${tripPlan.tripPlanNo}">조회<input type="hidden"
                                                                                value="${tripPlan.tripPlanNo}"
                                                                                class="tripPlanNo"/>
                                </button>


                                <c:if test="${not empty sessionScope.user.userId && tripPlan.isPlanDeleted && !tripPlan.isTripCompleted}">
                                    <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                        <button id="btnDelete${tripPlan.tripPlanNo}" class="btn btn-sm btn-info btnDelete"
                                                value="${tripPlan.tripPlanNo}">복구<input type="hidden"
                                                                                        value="${tripPlan.tripPlanNo}"
                                                                                        class="tripPlanNo"/>
                                        </button>
                                    </c:if>
                                </c:if>

                                <c:if test="${not empty sessionScope.user.userId && !tripPlan.isPlanDeleted && !tripPlan.isTripCompleted}">
                                    <c:if test="${sessionScope.user.userId == tripPlanAuthor}">
                                        <button id="btnDelete${tripPlan.tripPlanNo}" class="btn btn-sm btn-warning btnDelete"
                                                value="${tripPlan.tripPlanNo}">삭제<input type="hidden"
                                                                                        value="${tripPlan.tripPlanNo}"
                                                                                        class="tripPlanNo"/>
                                        </button>
                                    </c:if>
                                </c:if>

                                <c:if test="${sessionScope.user.userId == tripPlanAuthor && !tripPlan.isTripCompleted}">
                                    <button id="btnTripPlanDelete${tripPlan.tripPlanNo}" class="btn btn-sm btn-danger btnTripPlanDelete"
                                            <c:if test="${!tripPlan.isPlanDeleted}">
                                                style="display: none;"
                                            </c:if>
                                            value="${tripPlan.tripPlanNo}">완전삭제<input type="hidden"
                                                                                    value="${tripPlan.tripPlanNo}"
                                                                                    class="tripPlanNo"/>
                                    </button>
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

                            <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${page.currentPage - 1}&planCondition=${search.planCondition}&searchKeyword=${search.searchKeyword}"
                               aria-label="Previous">
                                &laquo;
                            </a>

                        </li>

                        <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">

                            <li class="page-item ${i == page.currentPage ? 'active' : ''}">

                                <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${i}&planCondition=${search.planCondition}&searchKeyword=${search.searchKeyword}">${i}</a>

                            </li>

                        </c:forEach>

                        <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">

                            <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${page.currentPage + 1}&planCondition=${search.planCondition}&searchKeyword=${search.searchKeyword}"
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

    // 여행플랜 검색
    document.getElementById('searchButton').addEventListener('click', function() {
        var searchKeyword = document.getElementById('searchKeyword').value;
        var url = '/tripPlan/tripPlanList?searchKeyword=' + encodeURIComponent(searchKeyword);
        window.location.href = url;
    });

    document.getElementById('searchKeyword').addEventListener('keypress', function(event) {
        if (event.keyCode === 13) { // 엔터 키
            var searchKeyword = document.getElementById('searchKeyword').value;
            var url = '/tripPlan/tripPlanList?searchKeyword=' + encodeURIComponent(searchKeyword);
            window.location.href = url;
        }
    });

    $(document).ready(function() {
        $('.right h4').hover(
            function() {
                $(this).css('cursor', 'pointer');
                /* 마우스를 올렸을 때의 스타일 변경 */
            },
            function() {
                $(this).css('cursor', 'auto');
                /* 마우스가 벗어났을 때의 스타일 변경 */
            }
        );

        $('.right h4').click(function() {
            var tripPlanAuthor = $(this).find('.hidden').text();  // h4 요소의 텍스트를 가져옵니다.
            window.location.href = '/user/getUser?userId=' + tripPlanAuthor;
        });
    });

    $(document).ready(function () {

        // 사진의 경우 여행플랜 삭제되었을때 아무것도 안눌리도록
        $(function () {
            $(".item-img").on("click", function () {
                var tripPlanNo = $(this).find(".tripPlanNo").val();
                if (tripPlanNo == 0) {
                    // 삭제된 플랜을 눌렀을 때 아무 작업도 하지 않음
                } else {
                    window.location.href = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
                }
            });
        });

        // 여행플랜 조회 버튼
        $(function () {
            $(".btn.btn-sm.btn-success").on("click", function () {
                var tripPlanNo = $(this).find(".tripPlanNo").val();
                window.location.href = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
            });
        });

        // 여행플랜 삭제하기 버튼
        $(function () {
            $(".btnDelete").on("click", function () {
                var tripPlanNo = this.value;
                console.log(tripPlanNo);

                var button = $(this); // 클릭한 버튼을 변수에 저장
                console.log(button)

                var swalTitle = "삭제";
                var swalText = "정말로 여행플랜을 삭제하겠습니까? 삭제된 여행플랜은 임시보관되며 복구할수있습니다.";
                var successMessage = "삭제되었습니다.";
                var cancelButtonText = "취소";

                if (button.hasClass("btn-info")) {
                    swalTitle = "복구";
                    swalText = "여행플랜을 복구하겠습니까?";
                    successMessage = "복구되었습니다.";
                    cancelButtonText = "취소";
                }

                Swal.fire({
                    title: swalTitle,
                    text: swalText,
                    icon: "question",
                    showCancelButton: true,
                    confirmButtonText: "확인",
                    cancelButtonText: cancelButtonText
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: "/tripPlan/tripPlanDeleted",
                            type: "GET",
                            data: { "tripPlanNo": tripPlanNo },
                            contentType: "application/json; charset=utf-8",
                            dataType: "JSON",
                            success: function (data) {
                                if (data.isPlanDeleted) {
                                    button
                                        .removeClass("btn-warning")
                                        .addClass("btn-info")
                                        .html("복구");

                                    $("#tripPlanView" + tripPlanNo).hide(); // 조회 버튼 숨기기
                                    $("#addChatRoom" + tripPlanNo).hide(); // 채팅방 생성 버튼 숨기기
                                    $("#tripPlanComplete" + tripPlanNo).hide(); // 여행완료 버튼 숨기기
                                    $("#btnTripPlanDelete" + tripPlanNo).show();
                                    $("#tripPlanImage" + tripPlanNo).val(0);

                                    Swal.fire(successMessage, "", "success");
                                } else {
                                    button
                                        .removeClass("btn-info")
                                        .addClass("btn-warning")
                                        .html("삭제");

                                    $("#tripPlanView" + tripPlanNo).show(); // 조회 버튼 숨기기
                                    $("#addChatRoom" + tripPlanNo).show(); // 채팅방 생성 버튼 숨기기
                                    $("#tripPlanComplete" + tripPlanNo).show(); // 여행완료 버튼 숨기기
                                    $("#btnTripPlanDelete" + tripPlanNo).hide();
                                    $("#tripPlanImage" + tripPlanNo).val(tripPlanNo);

                                    Swal.fire(successMessage, "", "success");
                                }
                            },
                            error: function (xhr, status, error) {
                                console.log("여행플랜 삭제 실패");
                            }
                        });
                    }
                });
            });
        });

        // 여행플랜 완료 버튼
        $(function () {
            $(".tripPlanComplete").on("click", function () {
                var tripPlanNo = $(this).val();
                console.log(tripPlanNo);

                swal.fire({
                    title: "여행완료",
                    text: "여행을 완료하면 후기를 작성할 수 있습니다(삭제 불가능)",
                    icon: "question",
                    showCancelButton: true,
                    confirmButtonText: "확인",
                    cancelButtonText: "취소"
                }).then((result) => {
                    if (result.isConfirmed) {
                        // 확인 버튼을 눌렀을 때의 동작
                        $.ajax({
                            url: "/tripPlan/tripPlanCompleted",
                            type: "GET",
                            data: { "tripPlanNo": tripPlanNo },
                            contentType: "application/json; charset=utf-8",
                            dataType: "JSON",
                            success: function (data) {
                                swal.fire("여행 완료", "여행이 완료되어 공개여부를 제외하고 수정,삭제가 불가능합니다.", "success").then(() => {
                                    location.reload();
                                });
                            },
                            error: function (xhr, status, error) {
                                console.log("여행 플랜 완료 실패");
                            }
                        });
                    }
                });
            });
        });

        // 여행플랜 완전삭제 버튼
        $(function () {
            $(".btnTripPlanDelete").on("click", function () {
                var tripPlanNo = $(this).val();
                console.log(tripPlanNo);

                swal.fire({
                    title: "여행플랜 삭제",
                    text: "정말로 여행플랜을 완전삭제하겠습니까? 다시는 복구할 수 없습니다.",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "확인",
                    cancelButtonText: "취소"
                }).then((result) => {
                    if (result.isConfirmed) {
                        // 확인 버튼을 눌렀을 때의 동작
                        $.ajax({
                            url: "/tripPlan/tripPlanDrop",
                            type: "GET",
                            data: { "tripPlanNo": tripPlanNo },
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                swal.fire("삭제 완료", "여행 플랜을 완전히 삭제하였습니다.", "success").then(() => {
                                    location.reload();
                                });
                            },
                            error: function (xhr, status, error) {
                                console.log("여행 플랜 완전 삭제 실패");
                            }
                        });
                    }
                });
            });
        });

    });

</script>

<script>
    function chatRoomRequest(chatRoomNo) {
        var url = "/chatRoom/chat";
        var data = {
            chatRoomNo: chatRoomNo
        };
        console.log(chatRoomNo);

        $.ajax({
            type: "POST",
            url: url,
            data: data,
            success: function(response) {
                // POST 요청 성공 시 수행할 동작
            },
            error: function(xhr, status, error) {
                // POST 요청 실패 시 수행할 동작
            }
        });
    }
</script>


<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>