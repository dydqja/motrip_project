<%--
  Created by IntelliJ IDEA.
  User: sean
  Date: 2023/06/02
  Time: 8:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Mold Discover . HTML Template</title>
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

</head>
<div class="pre-loader" style="display: none;">
  <div class="loading-img"></div>
</div>
<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="main-video with-overlay stick-top" style="background-image: url('http://placehold.it/1680x1050');">
  <div class="main-image-txt center-txt">
    <h1 class="main-header">모두의 여행</h1>
    <hr>
  </div>
  <video autoplay="" muted="" loop="">
    <source src="/media/motrip1.mp4" type="video/mp4">
    Your browser does not support the video tag.
  </video>

</div>
<section>
  <div class="main-title">
    <h2>모여행에서 당신의 여행을 설계하세요.</h2>
    <p>모여행과 함께 하면 좋은 점</p>
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
          <h5>Take Rare Path</h5>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Recusandae laborum soluta quos praesentium, magni repellendus.</p>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-map"></span></span>
        <div class="desc">
          <h5>Organize with Profestional</h5>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quia blanditiis, deleniti necessitatibus doloribus vel.</p>
        </div>
      </div>

      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-deer"></span></span>
        <div class="desc">
          <h5>Closer To Wildlife</h5>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam illo sit accusamus vel similique id quisquam, dolor maiores.</p>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-flower"></span></span>
        <div class="desc">
          <h5>Near to Nature</h5>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil harum sapiente ipsa hic voluptas? Ut architecto eveniet possimus.</p>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <span class="square-icon"><span class="icon-binocular"></span></span>
        <div class="desc">
          <h5>Behold Awesome Scenary</h5>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate quisquam esse quia, necessitatibus quos. Modi cum?</p>
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
      <a href="" class="btn btn-primary btn-lg hvr-sweep-to-right">Book Now</a>
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
          <div class="item-img" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-easy"></span>
              <h4 class="title"><a href="">Routeburn Track</a></h4>
            </div>

            <div class="sub-title">
              <span class="location">New Zealand</span>
              <span class="grade">Easy</span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day"><span class="icon-sun"></span>3 Days</div>
                <div class="night"><span class="icon-moon"></span>2 Nights</div>
              </div>
              <div class="right">
                <div class="price">USD 1029</div>
                <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">Book Now</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-hard"></span>
              <h4 class="title"><a href="">Fitz Roy Trek</a></h4>
            </div>

            <div class="sub-title">
              <span class="location">Patagonia, Argentina</span>
              <span class="grade">Hard</span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day"><span class="icon-sun"></span>3 Days</div>
                <div class="night"><span class="icon-moon"></span>2 Nights</div>
              </div>
              <div class="right">
                <div class="price">USD 121</div>
                <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">Book Now</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-extreme"></span>
              <h4 class="title"><a href="">Annapurna Circuit</a></h4>
            </div>

            <div class="sub-title">
              <span class="location">Nepal</span>
              <span class="grade">Extreme</span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day"><span class="icon-sun"></span>3 Days</div>
                <div class="night"><span class="icon-moon"></span>2 Nights</div>
              </div>
              <div class="right">
                <div class="price">USD 121</div>
                <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">Book Now</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-hard"></span>
              <h4 class="title"><a href="">Overland Track</a></h4>
            </div>

            <div class="sub-title">
              <span class="location">Australia</span>
              <span class="grade">Hard</span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day"><span class="icon-sun"></span>3 Days</div>
                <div class="night"><span class="icon-moon"></span>2 Nights</div>
              </div>
              <div class="right">
                <div class="price">USD 121</div>
                <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">Book Now</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-medium"></span>
              <h4 class="title"><a href="">The Haute Route</a></h4>
            </div>

            <div class="sub-title">
              <span class="location">France-Switzerland</span>
              <span class="grade">Medium</span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day"><span class="icon-sun"></span>3 Days</div>
                <div class="night"><span class="icon-moon"></span>2 Nights</div>
              </div>
              <div class="right">
                <div class="price">USD 121</div>
                <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">Book Now</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-md-4">
        <div class="item-grid">
          <div class="item-img" style="background-image: url('http://placehold.it/368x240');">
            <div class="item-overlay">
              <a href="trip_detail.html"><span class="icon-binocular"></span></a>
            </div>
          </div>
          <div class="item-desc">
            <div class="item-info">
              <span class="icon-hard"></span>
              <h4 class="title"><a href="">Torres del Paine Circuit</a></h4>
            </div>

            <div class="sub-title">
              <span class="location">Chile</span>
              <span class="grade">Hard</span>
            </div>

            <div class="item-detail">
              <div class="left">
                <div class="day"><span class="icon-sun"></span>3 Days</div>
                <div class="night"><span class="icon-moon"></span>2 Nights</div>
              </div>
              <div class="right">
                <div class="price">USD 121</div>
                <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">Book Now</a>
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
      <span class="counter">32</span>
      <p>등록된 여행계획의 숫자</p>
    </div>
    <div class="col-sm-6 col-md-3 dark">
      <span class="icon-font icon-camera"></span>
      <span class="counter">12437</span>
      <p>나눈 대화의 수</p>
    </div>
    <div class="col-sm-6 col-md-3 light">
      <span class="icon-font icon-sun"></span>
      <span class="counter">35</span>
      <p>작성된 후기의 숫자</p>
    </div>
    <div class="col-sm-6 col-md-3 dark">
      <span class="icon-font icon-umbrella"></span>
      <span class="counter">45</span>
      <p>Rainfall Last Year</p>
    </div>
  </div>
</div>
<div class="banner supported-by">
  <ul class="supported-list">
    <li>
      <a href="#">
        <img src="/assets/img/supported_by/logo_2.png">
      </a>
    </li>
    <li>
      <a href="#">
        <img src="/assets/img/supported_by/logo_1.png">
      </a>
    </li>
    <li>
      <a href="#">
        <img src="/assets/img/supported_by/logo_3.png">
      </a>
    </li>
    <li>
      <a href="#">
        <img src="/assets/img/supported_by/logo_4.png">
      </a>
    </li>
    <li>
      <a href="#">
        <img src="/assets/img/supported_by/logo_5.png">
      </a>
    </li>
  </ul>
</div>
<%--
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d37319.30096857599!2d-111.50394094053527!3d44.81298564157587!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x5351e55555555555%3A0xaca8f930348fe1bb!2sYellowstone+National+Park!5e0!3m2!1sen!2snp!4v1493435077252"
        style="width: 100%; border:0" height="450" allowfullscreen></iframe>--%>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>

</html>