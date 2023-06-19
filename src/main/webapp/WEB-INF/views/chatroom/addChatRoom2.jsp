<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bit.motrip.domain.*" %>

<!DOCTYPE html>
<html lang="en" class="full-height">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mold Discover</title>
    <link rel="icon" type="image/png" href="/assets/img/favicon.png" />

    <link rel="stylesheet" href="/assets/css/bootstrap.css" media="all">
    <link rel="stylesheet" href="/assets/css/jqueryui.css" media="all">
    <link rel="stylesheet" href="/vendor/animate-css/animate.css" media="all">
    <link rel="stylesheet" href="/assets/font/iconfont/iconstyle.css" media="all">
    <link rel="stylesheet" href="/assets/font/font-awesome/css/font-awesome.css" media="all">
    <link rel="stylesheet" href="/assets/css/main.css" media="all" id="maincss">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">

        function fncAddChatroom(){
            $("form").attr("method","POST").attr("action","addChatRoom").submit();
        }

        $(function() {
            $("#sub").on("click", function() {
                var minAge = $("#price-slider").slider("values", 0);
                var maxAge = $("#price-slider").slider("values", 1);
                $('form input[name="minAge"]').val(minAge);
                $('form input[name="maxAge"]').val(maxAge);
                fncAddChatroom();
            });
        });


    </script>
</head>

<body class="login" style="background-image: url('http://placehold.it/1200x800');">
<div class="pre-loader">
    <div class="loading-img"></div>
</div>

<div class="form-box">
    <div class="form-head">
        <img src="/images/motrip-logo.gif"/>
        <hr>
        <div class="txt">Create ChatRoom</div>
    </div>
    <div class="form-body">
        <form>
            <input type="hidden" name="userId" value="${sessionScope.user.userId}" >
            <input type="hidden" name="tripPlanNo" value="${tripPlanNo}" >
            <input type="hidden" name="minAge" value="">
            <input type="hidden" name="maxAge" value="">
            <div class="form-group">
                <label>CHATROOM TITLE</label>
                <div class="input-group">
                    <div class="input-group-addon icon-backpack"></div>
                    <input type="text" name="chatRoomTitle" class="form-control"  required />
                </div>
            </div>
            <div class="form-group">
                <label>START DATE</label>
                <div class="input-group">
                    <div class="input-group-addon icon-date"></div>
                    <input type="text" name="travelStartDate" class="form-control" id="datepicker" placeholder="날짜입력하세요" required >
                </div>
            </div>
<%--            <div class="form-group">--%>
<%--                <label>GENDER</label>--%>
<%--                <div class="input-group">--%>
<%--                    <div class="input-group-addon icon-lock"></div>--%>
<%--                    <input type="password" class="form-control" placeholder="Password" />--%>
<%--                </div>--%>
<%--            </div>--%>
            <div class="form-group">
                <label>MEMBERS</label>
                <div class="input-group">
                <div class="input-group-addon icon-user"></div>
                <input type="number" name="maxPersons" min="1" max="10" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label>GENDER</label><br/>
                <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-default active" data-toggle="tooltip" data-placement="bottom" title="venus-mars">
                        <input type="radio" name="gender" id="option1" value="MF" checked>
                        <span class="fa fa-venus-mars"></span>
                    </label>
                    <label class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="mars">
                        <input type="radio" name="gender" id="option4" value="M">
                        <span class="fa fa-mars"></span>
                    </label>
                    <label class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="venus">
                        <input type="radio" name="gender" id="option5" value="F">
                        <span class="fa fa-venus"></span>
                    </label>
                </div>
            </div>
<%--            <div class="form-group">--%>
<%--                <label>AGE</label>--%>
<%--                <div id="h-slider" class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all" aria-disabled="false">--%>
<%--                    <div class="ui-slider-range ui-widget-header ui-corner-all" style="left:0%;width:100%;"></div>--%>
<%--                        <a class="ui-slider-handle ui-state-default ui-corner-all" href="#" style="left:0%"></a>--%>
<%--                        <a class="ui-slider-handle ui-state-default ui-corner-all" href="#" style="left:100%"></a>--%>

<%--                </div>--%>
<%--            </div>--%>

            <div class="form-group">
                <label>AGE</label>
                <div id="price-slider"></div>
                <div id="amount-min" class="pull-left"></div>
                <div id="amount-max" class="pull-right"></div>
            </div>


            <br>
            <button type="submit" id="sub" class="btn btn-primary hvr-grow">Create</button>

        </form>
    </div>
</div>
<script src="/vendor/jquery/dist/jquery.min.js"></script>
<script src="/vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
<script src="/vendor/jquery.ui.touch-punch.min.js"></script>
<script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>
---
<script src="/vendor/waypoints/lib/jquery.waypoints.min.js"></script>
<script src="/vendor/owlcarousel/owl.carousel.min.js"></script>
<script src="/vendor/retina.min.js"></script>
<script src="/vendor/jquery.imageScroll.min.js"></script>
<script src="/assets/js/min/responsivetable.min.js"></script>
<script src="/assets/js/bootstrap-tabcollapse.js"></script>
<script src="/assets/js/min/countnumbers.min.js"></script>

---


<script src="/vendor/retina.min.js"></script>
<script src="/assets/js/main.js"></script>

<!-- Current Page JS -->
<script src="/assets/js/min/login.min.js"></script>
<script src="/assets/js/min/jqueryuipage.min.js"></script>
<script src="/assets/js/min/priceslider.min.js"></script>
</body>

</html>