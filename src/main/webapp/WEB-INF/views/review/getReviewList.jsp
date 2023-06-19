<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
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

<<div class="page-img" style="background-image: url('/images/tripplan2.jpg');">
  <div class="container">
    <div class="col-sm-8">
      <h1 class="main-head">모든 후기 보기 </h1>
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
                                                    id="reviewCounter">${page.totalCount}</span>Review
          </div>
        </div>
        <label><br></label>
        <div class="border-box">
          <div class="box-title">Search Condition</div>
          <div class="center-div" style="width: 100%; height: 100%;">
            <div class="btn-group" data-toggle="buttons">
              <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="newDate">
                <h4><span class="icon-calendar"></span>&nbsp
                  <input type="radio" name="options" id="newDate"
                         value="newDate" OnClick="window.location.href='/review/reviewList?type=${condition}&planCondition=newDate'"></h4>
                <h5>최신날짜순</h5>
              </label>
              <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="views">
                <h4><span class="icon-eye"></span>&nbsp<input type="radio" name="options"
                                                              id="views" value="views" OnClick="window.location.href='/review/reviewList?type=${condition}&reviewCondition=views'"></h4>
                <h5>조회수</h5>
              </label>
              <label class="btn-label" data-toggle="tooltip" data-placement="bottom" title="likes">
                <h4><span class="icon-hand-like"></span>&nbsp<input type="radio" name="options"
                                                                    id="likes" value="likes" OnClick="window.location.href='/review/reviewList?type=${condition}&reviewCondition=likes'"></h4>
                <h5>추천수</h5>
              </label>
            </div>
          </div>
        </div>

        <div class="sidebar">
          <div class="border-box">
            <div class="box-title">Review Search</div>
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
        <c:forEach var="review" items="${reviewList}">
          <c:set var="i" value="${ i+1 }"/>
          <div class="item-list review-item-list">
            <div class="col-sm-5">
              <div class="item-img row" style="background-image: url('/images/tripImage.jpg');"><input
                      type="hidden"
                      value=">${review.reviewNo}"
                      class="reviewNo"/></div>
            </div>

            <div class="col-sm-7">
              <div class="item-desc">
                <div>
                  <h6 class="right">${review.reviewRegDate}</h6>
                  <h5 class="item-title">${review.reviewTitle} </h5>
                  <div class="sub-title"  style="display: none;">
                   태그는 여기로
                  </div>
                </div>

                <div class="right">
                  <h4>${review.reviewAuthor}</h4>
                  <div class="right"  style="display: none;"><span class="icon-date"></span>
                   몇 박 몇일은 여기에
                  </div>
                  <div style="display: none;">
                 버튼 넣고 싶으면 여기에
                  </div>
                </div>
              </div>
              <div class="item-book">

                <button class="btn btn-sm btn-success" name="reviewNo"
                        <c:if test="${review.isReviewDeleted}">
                          style="display: none;"
                        </c:if>
                        id="reviewView${review.reviewNo}"
                        value="${review.reviewNo}">조회<input type="hidden"
                                                                value="${review.reviewNo}"
                                                                class="reviewNo"/>
                </button>


                <c:if test="${not empty sessionScope.user.userId && review.isReviewDeleted }">
                  <c:if test="${sessionScope.user.userId == reviewAuthor}">
                    <button id="btnDelete${review.reviewNo}" class="btn btn-sm btn-info btnDelete"
                            value="${review.reviewNo}">복구<input type="hidden"
                                                                    value="${review.reviewNo}"
                                                                    class="reviewNo"/>
                    </button>
                  </c:if>
                </c:if>

                <c:if test="${not empty sessionScope.user.userId && review.isReviewDeleted }">
                  <c:if test="${sessionScope.user.userId == reviewAuthor}">
                    <button id="btnDelete${review.reviewNo}" class="btn btn-sm btn-warning btnDelete"
                            value="${review.reviewNo}">삭제<input type="hidden"
                                                                    value="${tripPlan.reviewNo}"
                                                                    class="reviewNo"/>
                    </button>
                  </c:if>
                </c:if>

                <c:if test="${sessionScope.user.userId == reviewAuthor}">
                  <button id="btnTripPlanDelete${review.reviewNo}" class="btn btn-sm btn-danger btnTripPlanDelete"
                          <c:if test="${!review.isReviewDeleted}">
                            style="display: none;"
                          </c:if>
                          value="${review.reviewNo}">완전삭제<input type="hidden"
                                                                    value="${review.reviewNo}"
                                                                    class="reviewNo"/>
                  </button>
                </c:if>


                <div class="price">
                  <label class="icon-hand-like">${review.reviewLikes}</label>
                  <label></label>
                  <label class="icon-eye">${review.viewCount}</label>
                </div>
              </div>

            </div>
          </div>
        </c:forEach>


        <nav aria-label="Page navigation example" class="text-center">

          <ul class="pagination justify-content-center">

            <li class="page-item ${page.currentPage == 1 ? 'disabled' : ''}">

              <a class="page-link" href="/review/getReviewList?type=${condition}&currentPage=${page.currentPage - 1}&reviewCondition=${search.reviewCondition}&searchKeyword=${search.searchKeyword}"
                 aria-label="Previous">
                &laquo;
              </a>

            </li>

            <c:forEach var="i" begin="${beginUnitPage}" end="${endUnitPage}">

              <li class="page-item ${i == page.currentPage ? 'active' : ''}">

                <a class="page-link" href="/review/getReviewList?type=${condition}&currentPage=${i}&reviewCondition=${search.reviewCondition}&searchKeyword=${search.searchKeyword}">${i}</a>

              </li>

            </c:forEach>

            <li class="page-item ${page.currentPage == maxPage ? 'disabled' : ''}">

              <a class="page-link" href="/review/getReviewList?type=${condition}&currentPage=${page.currentPage + 1}&reviewCondition=${search.reviewCondition}&searchKeyword=${search.searchKeyword}"
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

    // 사진의 경우 여행플랜 삭제되었을때 아무것도 안눌리도록
    $(function () {
      $(".item-img").on("click", function () {
        var reviewNo = $(this).find(".reviewNo").val();
        if (reviewNo == 0) {
          // 삭제된 플랜을 눌렀을 때 아무 작업도 하지 않음
        } else {
          console.log(reviewNo);
          window.location.href = "/review/getReview?reviewNo=" + reviewNo;
        }
      });
    });

    // 버튼의 경우 여행플랜 삭제되었을때 아무것도 안눌리도록
    $(function () {
      $(".btn.btn-sm.btn-success").on("click", function () {
        var reviewNo = $(this).find(".reviewNo").val();
        if (reviewNo == 0) {
          // 삭제된 플랜을 눌렀을 때 아무 작업도 하지 않음
        } else {
          console.log(reviewNo);
          window.location.href = "/review/getReview?reviewNo=" + reviewNo;
        }
      });
    });

    // AJAX 요청을 보내고 여행플랜의 수를 가져오는 함수
    function listCounter() {
      $.ajax({
        url: "/review/reviewCount",
        type: "POST",
        dataType: "json",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        data: JSON.stringify({}),
        success: function (data) {
          console.log(data);
          $("#reviewCounter").html(data); // 변경된 부분: data.count 값을 출력합니다.
          $(".total").text("Total : " + data);
          var t = $(".counter");
          t.countUp({delay: 30, time: 3e3})
        },
        error: function (xhr, status, error) {
          console.log("An error occurred: " + error);
        }
      });
    }

    // 페이지가 열리면 함수 실행
    listCounter();
  });

</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>
</html>