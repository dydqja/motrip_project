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
                            <div class="item-img row" style="background-image: url('/images/default_motrip.png');">
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
                                    <h5 class="item-title" style="text-overflow: ellipsis;  overflow: hidden; white-space: nowrap; max-width: 400px;">${tripPlan.tripPlanTitle} </h5>
                                    <div class="sub-title">
                                        <c:forEach var="dailyPlan" items="${tripPlan.dailyplanResultMap}">
                                            <c:forEach var="place" items="${dailyPlan.placeResultMap}">
                                                <h6 style="text-overflow: ellipsis;  overflow: hidden; white-space: nowrap; max-width: 350px;">#${place.placeTags}</h6>
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
                                                   class="btn-sm btn-info right">채팅방 생성</a>
                                            </c:if>
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

                                <c:if test="${navigation eq 'myPage'}">
                                    <a class="page-link" href="/user/getUser?userId=${getUser.userId}&type=my&currentPage=${i}&planCondition=${search.planCondition}&searchKeyword=${search.searchKeyword}">${i}</a>
                                </c:if>

                                <c:if test="${navigation ne 'myPage'}">
                                    <a class="page-link" href="/tripPlan/tripPlanList?type=${condition}&currentPage=${i}&planCondition=${search.planCondition}&searchKeyword=${search.searchKeyword}">${i}</a>
                                </c:if>

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




</body>
</html>