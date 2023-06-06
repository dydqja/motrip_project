<%--
복붙용 jsp 양식
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

<body>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<section>
    <div class="main-title">
        <h1>Banner</h1>
        <p>Available variation of promotional banner.</p>
    </div>
    <div class="banner base">
        <div class="container">
            <div class="line-box">
                <div class="line-title">Lorem ipsum dolor sit.</div>
                <h1>Great Places, Great Holiday</h1>
                <a href="" class="btn btn-primary btn-lg hvr-sweep-to-right">Book Now</a>
            </div>
        </div>
    </div>
</section>

<section>
    <div class="main-title">
        <h1>Boxed</h1>
        <p>Enhaced bootstrap component that will adapt according to your color scheme and typography.</p>
    </div>
    <div class="container">
        <div class="banner primary">
            <div class="line-box">
                <div class="line-title">We provide best support to our customers</div>
                <br>
                <h2>For Support email us at</h2>
                <h3>info@moldthemes.com</h3>
                <a href="" class="btn btn-base btn-lg hvr-sweep-to-right">Book Now</a>
            </div>
        </div>
    </div>
</section>

<section>
    <div class="main-title">
        <h1>Gray</h1>
        <p>Enhaced bootstrap component that will adapt according to your color scheme and typography.</p>
    </div>
    <div class="container">
        <div class="banner gray">
            <div class="line-box">
                <div class="line-title">쓸데없이 멋있는 테스트 페이지</div>
                <h1>알람 거절 테스트용</h1>
                <a href="" class="btn btn-primary btn-lg hvr-sweep-to-right">돌아가세요</a>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>

</html>