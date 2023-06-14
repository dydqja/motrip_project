<%--
  Created by IntelliJ IDEA.
  User: sean
  Date: 2023/06/02
  Time: 8:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Motrip</title>

  <link rel="icon" type="image/png" href="/assets/img/favicon.png" />

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

  <!-- Current Page JS -->
  <script src="/assets/js/min/home.min.js"></script>
  <script>
    $(document).ready(function() {
      // AJAX 요청을 보내고 채팅방의 수를 가져오는 함수
      function listChatRoomCounter() {
        $.ajax({
          url: "/chatRoom/json/getListCount",
          type: "POST",
          dataType: "json",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          data: JSON.stringify({}),
          success: function (data) {
            console.log(data);
            $("#chatRoomCounter").html(data); // 변경된 부분: data.count 값을 출력합니다.

          },
          error: function(xhr, status, error) {
            console.log("An error occurred: " + error);
          }
        });
      }
      function listTripCounter() {
        $.ajax({
          url: "/tripPlan/tripPlanCount",
          type: "POST",
          dataType: "json",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          data: JSON.stringify({}),
          success: function (data) {
            console.log(data);
            $("#tripPlanCounter").html(data); // 변경된 부분: data.count 값을 출력합니다.
            $(".total").text("Total : " + data);

          },
          error: function (xhr, status, error) {
            console.log("An error occurred: " + error);
          }
        });
      }
      function listUserCounter() {
        $.ajax({
          url: "/user/getUserCount",
          type: "POST",
          dataType: "json",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          data: JSON.stringify({}),
          success: function (data) {
            console.log(data);
            $("#userCounter").html(data); // 변경된 부분: data.count 값을 출력합니다.
            $(".total").text("Total : " + data);

          },
          error: function (xhr, status, error) {
            console.log("An error occurred: " + error);
          }
        });
      } // 덮어씌우면서 지워짐
      function listReviewCounter() {
        $.ajax({
          url: "/review/getReviewCount",
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

          },
          error: function (xhr, status, error) {
            console.log("An error occurred: " + error);
          }
        });
      }
      function indexTripPlanLikes() {
        $.ajax({
          url: "/tripPlan/indexTripPlanLikes",
          type: "POST",
          dataType: "json",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          data: JSON.stringify({}),
          success: function (data) {
            var indexTripPlan = data;
            console.log(indexTripPlan);

            for(var i=0; i<indexTripPlan.length; i++){
              $(".title" + i + "").text(indexTripPlan[i].tripPlanTitle);
              $(".day" + i + "").text(indexTripPlan[i].tripDays + " Days");
              $(".author" + i + "").text(indexTripPlan[i].tripPlanNickName);
              var tripPlanThumbnail = indexTripPlan[i].tripPlanThumbnail;
              $("#item-img" + i).css("background-image", "url('/imagePath/thumbnail/" + tripPlanThumbnail + "')");

              $("#like" + i).text(indexTripPlan[i].tripPlanLikes);
              $("#view" + i).text(indexTripPlan[i].tripPlanViews);

              var tripPlanNo = indexTripPlan[i].tripPlanNo;
              var tripPlanUrl = "/tripPlan/selectTripPlan?tripPlanNo=" + tripPlanNo;
              $("#tripPlanNo" + i).attr("href", tripPlanUrl);
              $("#image" + i).attr("href", tripPlanUrl);
            }
          },
          error: function (xhr, status, error) {
            console.log("An error occurred: " + error);
          }
        });
      }

      // 페이지가 열리면 함수 실행
      listChatRoomCounter();
      listTripCounter();
      listReviewCounter();
      listUserCounter();
      indexTripPlanLikes();
    });

  </script>
</head>

<!--
<div class="pre-loader" style="display: none;">
  <div class="loading-img"></div>
</div>
-->

<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="main-video with-overlay stick-top">
  <div class="main-image-txt center-txt">
    <h1 class="main-header zooming">모두의 여행</h1>
  </div>
  <video autoplay muted loop>
    <source src="/media/motrip.mp4" type="video/mp4">
  </video>
</div>

<section>
  <div class="main-title">
    <h2>모두의 여행에서 <br>당신의 여행을 설계하세요.</h2>
    <p>모두의 여행과 함께 하면 좋은 점</p>
  </div>

  <div class="container">
    <div class="row  feature-list center">
      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-hand-scissor"></span></span>
        <div class="desc">
          <h5>믿을만한 여행동료들</h5>
          <p>휴대폰 실명인증을 거친 신원이 확실한 회원들과 함께</p>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-road-sign"></span></span>
        <div class="desc">
          <h5>좌우 구분 잘하세요</h5>
          <p>저희는 인생의 길을 찾아주는 웹사이트가 아닙니다.</p>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-map"></span></span>
        <div class="desc">
          <h5>나의 여행플랜 작성</h5>
          <p>지도에 경로를 그리며 여행플랜을 작성하세요<br>동선을 확인하고 완벽한 일정을 만드십시오</p>
        </div>
      </div>

      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-deer"></span></span>
        <div class="desc">
          <h5>멸종 위기의 고라니</h5>
          <p>고라니와 함께하는 한국여행을 즐기세요</p>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-flower"></span></span>
        <div class="desc">
          <h5>자연과 한마음</h5>
          <p>모여행은 친환경을 중시합니다. <br>모여행은 일회용 젓가락을 사용하지 않아요</p>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-binocular"></span></span>
        <div class="desc">
          <h5>새로운 발견! 잊지 못할 여행! </h5>
          <p>믿을 수 있는 여행 동료들과 함께<br>멋진 여행 후기를 작성해보세요.</p>
        </div>
      </div>

    </div>
  </div>
</section>

<%--
<div class="banner base">
  <div class="container">
    <div class="line-box">
      <div class="line-title">Lorem ipsum dolor sit</div>
      <h2>Great Places, Great Holiday</h2>
      <a href="" class="btn btn-primary btn-lg hvr-sweep-to-right">Enter</a>
    </div>
  </div>
</div>--%>

<section class="showcase" style="background: url('/assets/img/worldmap.png') no-repeat center; background-size: cover">
  <div class="main-title">
    <h2>최다 추천 여행계획</h2>
    <p>남들이 많이 알아보는 곳에는 그럴 만한 이유가 있습니다.</p>
  </div>
  <div class="container">

    <div class="row item">

      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" id="item-img0" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a id="image0" href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-locate" style="color: #2929e8;"></span>
              <h4 class="title0"><a href=""></a></h4>
            </div>

            <div class="sub-title">
              <span class="location"></span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day0"><span class="icon-sun"></span>3 Days</div>
                <div style="margin: 10%"></div>
                <div style="display: flex">
                  <h4><span class="icon-hand-like" id="like0" style="color: black"></span></h4>
                  <h4><span class="icon-eye" id="view0" style="color: black"></span></h4>
                </div>
              </div>
              <div class="right">
                <h4><div class="author0"></div></h4>
                <a id="tripPlanNo0" href="/tripPlan/selectTripPlan?tripPlanNo=tripPlanNo0" class="btn btn-primary hvr-sweep-to-right">조회</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" id="item-img1" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a id="image1" href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-locate" style="color: #2929e8;"></span>
              <h4 class="title1"><a href=""></a></h4>
            </div>

            <div class="sub-title">
              <span class="location"></span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day1"><span class="icon-sun"></span>3 Days</div>
                <div style="margin: 10%"></div>
                <div style="display: flex">
                  <h4><span class="icon-hand-like" id="like1" style="color: black"></span></h4>
                  <h4><span class="icon-eye" id="view1" style="color: black"></span></h4>
                </div>
              </div>
              <div class="right">
                <h4><div class="author1"></div></h4>
                <a id="tripPlanNo1" href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">조회</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" id="item-img2" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a id="image2" href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-locate" style="color: #2929e8;"></span>
              <h4 class="title2"><a href=""></a></h4>
            </div>

            <div class="sub-title">
              <span class="location"></span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day2"><span class="icon-sun"></span></div>
                <div style="margin: 10%"></div>
                <div style="display: flex">
                  <h4><span class="icon-hand-like" id="like2" style="color: black"></span></h4>
                  <h4><span class="icon-eye" id="view2" style="color: black"></span></h4>
                </div>
              </div>
              <div class="right">
                <h4><div class="author2"></div></h4>
                <a id="tripPlanNo2" href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">조회</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" id="item-img3" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a id="image3" href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-locate" style="color: #2929e8;"></span>
              <h4 class="title3"><a href=""></a></h4>
            </div>

            <div class="sub-title">
              <span class="location"></span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day3"><span class="icon-sun"></span></div>
                <div style="margin: 10%"></div>
                <div style="display: flex">
                  <h4><span class="icon-hand-like" id="like3" style="color: black"></span></h4>
                  <h4><span class="icon-eye" id="view3" style="color: black"></span></h4>
                </div>
              </div>
              <div class="right">
                <h4><div class="author3"></div></h4>
                <a id="tripPlanNo3" href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">조회</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" id="item-img4" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a id="image4" href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-locate" style="color: #2929e8;"></span>
              <h4 class="title4"><a href=""></a></h4>
            </div>

            <div class="sub-title">
              <span class="location"></span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day4"><span class="icon-sun"></span></div>
                <div style="margin: 10%"></div>
                <div style="display: flex">
                  <h4><span class="icon-hand-like" id="like4" style="color: black"></span></h4>
                  <h4><span class="icon-eye" id="view4" style="color: black"></span></h4>
                </div>
              </div>
              <div class="right">
                <h4><div class="author4"></div></h4>
                <a id="tripPlanNo4" href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">조회</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" id="item-img5" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a id="image5" href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-locate" style="color: #2929e8;"></span>
              <h4 class="title5"><a href=""></a></h4>
            </div>

            <div class="sub-title">
              <span class="location"></span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day5"><span class="icon-sun"></span></div>
                <div style="margin: 10%"></div>
                <div style="display: flex">
                  <h4><span class="icon-hand-like" id="like5" style="color: black"></span></h4>
                  <h4><span class="icon-eye" id="view5" style="color: black"></span></h4>
                </div>
              </div>
              <div class="right">
                <h4><div class="author5"></div></h4>
                <a id="tripPlanNo5" href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">조회</a>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>

  </div>
</section>

<div class="counter-div base boxed">
  <div class="clearfix">
    <div class="col-sm-6 col-md-3 light">
      <span class="icon-font icon-tent"></span>
      <span class="counter" id="chatRoomCounter"></span>
      <p>등록된 채팅방 숫자</p>
    </div>
    <div class="col-sm-6 col-md-3 dark">
      <span class="icon-font icon-map"></span>
      <span class="counter" id="tripPlanCounter"></span>
      <p>작성된 여행 수</p>
    </div>
    <div class="col-sm-6 col-md-3 light">
      <span class="icon-font icon-pencil"></span>
      <span class="counter" id="reviewCounter"></span>
      <p>작성된 후기의 숫자</p>
    </div>
    <div class="col-sm-6 col-md-3 dark">
      <span class="icon-font icon-user"></span>
      <span class="counter" id="userCounter"></span>
      <p>가입된 회원 수</p>
    </div>
  </div>
</div>
<div class="banner supported-by">
  <ul class="supported-list">
    <li>
      <a href="https://www.bitcamp.co.kr/content/company">
        <img src="/assets/img/supported_by/bitcamp.png" style="width: 164px; height: 41px">
      </a>
    </li>
    <li>
      <a href="https://ncamp.kr/">
        <img src="/assets/img/supported_by/navercloudcamp.png" style="width: 164px; height: 41px">
        <%--width 164 height 41--%>
      </a>
    </li>
    <li>
      <a href="https://magicecole.com/">
        <img src="/assets/img/supported_by/magicecole.png" style="width: 164px; height: 41px">
      </a>
    </li>
    <li>
      <a href="https://www.bitcamp.co.kr/content/company">
        <img src="/assets/img/supported_by/bitcamp.png" style="width: 164px; height: 41px">
      </a>
    </li>
    <li>
      <a href="https://ncamp.kr/">
        <img src="/assets/img/supported_by/navercloudcamp.png" style="width: 164px; height: 41px">
      </a>
    </li>
  </ul>
</div>
<%--
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d37319.30096857599!2d-111.50394094053527!3d44.81298564157587!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x5351e55555555555%3A0xaca8f930348fe1bb!2sYellowstone+National+Park!5e0!3m2!1sen!2snp!4v1493435077252"
        style="width: 100%; border:0" height="450" allowfullscreen></iframe>--%>

<script>


</script>
<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>

</html>