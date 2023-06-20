<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="com.bit.motrip.domain.*"%>
<!DOCTYPE html>
<html>

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
</head>

<body>


<header class="nav-menu fixed">
  <%@ include file="/WEB-INF/views/layout/header.jsp" %>
</header>

<section class="gray">
  <div class="main-title">
    <h1>${chatRoomTitle} 사진첩</h1>
    <p>Motrip Gallery</p>
  </div>
  <div class="container-fluid">
    <div class="row">
      <div class="gallery" id="trip-gallery-2">
        <c:set var="i" value="0" />
        <c:forEach var="photo" items="${photos}">
          <c:set var="i" value="${ i+1 }" />
        <div class="col-sm-3">
          <a href="/imagePath/photos/${photo.photoId}" class="gallery-item" data-lightbox="trip-detail-gallery" data-title="Lorem ipsum dolor.">
            <img src="/imagePath/photos/${photo.photoId}" alt="..." class="img-responsive">
            <div class="hover-overlay">
              <span class="icon-search"></span>
            </div>
          </a>
        </div>
          </c:forEach>

</section>
<footer id="footer">
  <div class="container">
    <div class="row">
      <div class="col-sm-7 col-md-3">
        <h3>Mold Discover</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequuntur, quia, architecto? A, reiciendis eveniet! Esse est eaque adipisci natus rerum laudantium accusamus magni.</p>
      </div>
      <div class="col-sm-5 col-md-2">
        <h3>Quick Link</h3>
        <ul>
          <li>Holiday Package</li>
          <li>Summer Adventure</li>
          <li>Bus and Trasnportation</li>
          <li>Ticket and Hotel Booking</li>
          <li>Trek and Hikings</li>
        </ul>
      </div>
      <div class="col-sm-7 col-md-4">
        <h3>Newsletter Signup</h3>
        <p>Subscribe to our weekly newsletter to get news and update</p>
        <br>
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Your Email">
          <div class="input-group-btn">
            <button class="btn btn-primary">Subscribe</button>
          </div>
        </div>
      </div>
      <div class="col-sm-5 col-md-2">
        <h3>Contact Info</h3>
        <ul>
          <li>Mold Discover</li>
          <li>info@moldthemes.com</li>
        </ul>
        <div class="clearfix">
          <div class="social-icon-list">
            <ul>
              <li>
                <a href="https://twitter.com/moldthemes" class="icon-twitter"></a>
              </li>
              <li>
                <a href="mailto:info@moldthemes.com" class="icon-mail"></a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="copy"><span>&copy;</span> Copyright Mold Discover, 2017</div>
</footer>

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
<script src="/vendor/lightbox/js/lightbox.js"></script>
<script src="/assets/js/min/img_gallery.min.js"></script>

</body>

</html>