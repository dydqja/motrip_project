<%--
복붙용 jsp 양식
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

<div class="post-single center">
    <div class="page-img" style="background-image: url('/media/whatBack.jpg');">
        <div class="page-img-txt container">
            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <h1 class="main-head">모여행이란</h1>
                    <h4 class="main-subhead">모여서 떠나는 여행 플랫폼</h4>

                    <br>
                    <div class="author-img">
                        <img src="/media/psw.png"/>
                        <%--<img src="/images/mtrip.jpg"/>--%>
                    </div>
                    <br>
                    <div class="author">
                        <p>여행, 인연, 그리고 사랑</p>
                        <span>By</span>  <a href="#">DevOps 박성원</a>
                    </div>
                    <p class="byline">
                        <span> 24, 2023</span>
                        <span class="dot">·</span>
                        <span class="italic">in</span>
                        <a href="#">Adventure</a>, <a href="#">Korea</a>
                    </p>
                </div>
                <div class="col-sm-2">
                </div>
            </div>
        </div>
    </div>

    <main class="white">
        <div class="container">
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="post">
                        <p>
                            &nbsp;&nbsp;&nbsp; 바쁜 현대사회 속에서 여행은 단연 빠질 수 없는 ‘힐링’이다. 여행은 단순 취미나 즐길 거리를 넘어서 현대인에게 치료제로서 작용하고 있는 것이다. 그러나 여행 목적지는 쉽게 정할 수 있지만
                            바쁜 일정 속에서 틈틈이 여행 계획을 짜는 것은 쉽지 않은 일이다. 여행지를 정하고 가보고 싶은 명소를 선정하는 설렘이 끝나면 동선과 이동시간을 고려해야 하는 고민에 머리가 아파진다.
                            더불어 여행 동료를 모집하고 함께 일정도 맞춰야 야한다면 고민은 깊어진다. 이를 통해 우리는 간편하고 빠르게 여행 계획을 작성할 수 있는 서비스를 떠올리게 되었다.
                        </p>
                        <br>
                        <p>
                            여기서 우리의 프로젝트 ‘모여행’ 이 시작되었다. ‘모여행’은 ‘모여서 여행’을 줄인 말로 누구나 쉽게 사용 가능한 UI를 통해 여행 계획을 수립할 수 있으며
                            부담 없이 여행 동료를 모집하고 여행이 끝난 후 추억으로 남길 사진과 여행 후기까지 작성할 수 있는 국내여행 플랫폼 서비스를 제공한다.
                        </p>
                        <br>
                        <p>
                            여행 계획 단계에서는 최적의 여행 동선을 생성할 수 있다. 사용자는 여행하고 싶은 목적지 간의 거리나 목적지 정보에 쉽게 접근하여 명소를 고를 수 있고 지도에 가보고 싶은 명소들을 입력하면
                            명소 간 이동시간을 계산하여 최적의 여행 동선을 계획할 수 있다. 또한 다른 사용자가 작성한 여행 계획들도 편리하게 검색할 수 있다.
                        </p>
                        <br>
                        <p>
                            채팅방을 통해 여럿이 여행 동료들을 모집할 수 있고 손쉽게 커뮤니케이션할 수 있다. 수립한 계획을 바탕으로 채팅방을 만들 수 있는데 채팅방은 UI가 보기 편하게 이루어져 있고, 음성 채팅과 화상채팅도 가능하여 여행 시작 전
                            동료들의 얼굴을 확인하고 성격도 맞춰볼 수 있다. 또한 채팅방에서 벗어나지 않고도 여행 계획을 보며 동료들과 채팅으로 일정을 맞출 수 있다.
                        </p>
                        <br>
                        <p>
                            여행을 다녀와서 후기로 여행에 대한 추억과 다음 여행 계획을 위한 자료를 남길 수 있다. 후기를 작성할 때는 다녀온 여행 계획을 기반으로 작성할 수 있고 여행 계획 당시 이용한 여행 동선들을 일차별로 확인할 수 있다.
                        </p>
                        <br>
                        <p>
                            모여행은 이처럼 여행 계획, 동료 모집과 커뮤니케이션, 여행 후기라는 큰 스텝들을 한데 엮어낸 플랫폼으로서 여행을 위해 여기저기 옮겨가며 서비스들을 이용하기 불편한 사람들에게 만족도를 높일 수 있는 역할을 수행할 것이다.
                            더불어 이 프로젝트를 통해 여행 계획을 더 즐겁고 편하게 만드는 방식을 제안함으로써 여행을 하는 사람이 많아지고 이는 곧 여행 산업에 긍정적인 영향과 국내 여행지의 발전에 좋은 영향을 미칠 것이다.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>

</body>

</html>