<%--
  Created by IntelliJ IDEA.
  User: sean
  Date: 2023/06/05
  Time: 2:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="com.bit.motrip.domain.*"%>
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
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">--%>

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
    <script type="text/javascript">

        // function fncGoChatroom(){
        //     $("form").attr("method","POST").attr("action","/chatRoom/chat").submit();
        // }
        // function fncJoinChatroom(){
        //     alert("join-chatRoom");
        //     $("form").attr("method","POST").attr("action","/chatMember/joinChatRoom").submit();
        // }
        // function fncDeleteChatroom(){
        //     $("form").attr("method","get").attr("action","/chatRoom/deleteChatRoom").submit();
        // }
        // function fncAddChatroom(){
        //     $("form").attr("method","get").attr("action","/chatRoom/addChatRoom").submit();
        // }
        // //참여된 채팅방 들어가기
        // $(function() {$(".go").on("click", function() {fncGoChatroom();});});
        // //참여안된 채팅방 조인하기
        // $(function() {$(".join-chatRoom").on("click", function() {fncJoinChatroom();});});
        // //채팅방 삭제
        // $(function() {$(".delete").on("click", function() {fncDeleteChatroom();});});
        // //채팅방 생성
        // $(function() {$("#addChatRoom").on("click", function() {fncAddChatroom();});});
        window.onload = function(){
            $.ajax({
                url:"/chatRoom/json/getList",
                method:"post",
                dataType:"json",
                headers : {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                },
                data:JSON.stringify({
                }),
                success:function (data){
                    console.log(data);

                }
            })
        }
    </script>
</head>

<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>


<div class="page-img" style="background-image: url('/images/chatRoomImage.jpg');">
    <div class="container">
        <div class="col-sm-8">
            <h1 class="main-head">ChatRoom List</h1>
        </div>
        <div class="col-sm-4">
            <ul class="breadcrumb">
                <li><a href=""><span class="icon-home"></span></a>
                </li>
                <li><a href="">List</a>
                </li>
            </ul>
        </div>

    </div>
</div>

<main>
    <div class="container">
        <div class="row">
            <div class="col-sm-4">

                <div class="sidebar">
                    <div class="border-box">
                        <div class="box-title">CREATE CHATROOM</div>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="TripPlan" required>
                            <div class="input-group-btn">
                                <button class="btn btn-primary">Create</button>
                            </div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">ChatRoom Search</div>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search Site">
                            <div class="input-group-btn">
                                <button class="btn btn-primary">Search</button>
                            </div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">Gender</div>
                        <div class="center-div" style="width: 100%; height: 100%;">
                            <div class="btn-group" data-toggle="buttons">
                                <label class="btn btn-default active" data-toggle="tooltip" data-placement="bottom" title="venus-mars">
                                    <input type="radio" name="options" id="option1" checked>
                                    <span class="fa fa-venus-mars"></span>
                                </label>
                                <label class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="mars">
                                    <input type="radio" name="options" id="option4">
                                    <span class="fa fa-mars"></span>
                                </label>
                                <label class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="venus">
                                    <input type="radio" name="options" id="option5">
                                    <span class="fa fa-venus"></span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">Age Range</div>
                        <div class="price-widget">
                            <div id="price-slider"></div>
                            <div id="amount-min" class="pull-left"></div>
                            <div id="amount-max" class="pull-right"></div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">StartDate</div>

                        <div class="input-group">
                            <input type="text" class="form-control" id="datepicker" placeholder="StartDate">
                            <div class="input-group-btn">
                                Days
                            </div>
                        </div>
                    </div>

                    <div class="border-box">
                        <div class="box-title">DURATION</div>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Days">
                        </div>
                    </div>

                </div>




            </div>

            <div class="col-sm-8">

                <div class="sort-wrap">
                    <div class="sort-title">{search 한 채팅방 수} Matching Result</div>
                </div>
                <c:set var="i" value="0" />
                <c:forEach var="chatRoom" items="${list}">
                <c:set var="i" value="${ i+1 }" />
                <div class="item-list">
                    <div class="col-sm-5">
                        <div class="item-img row" style="background-image: url('http://placehold.it/320x250');">
                            <div class="item-overlay">
                                <a href="trip_detail.html"><span class="icon-binocular"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-7">
                        <div class="item-desc">
                            <h5 class="item-title">${chatRoom.chatRoomTitle}</h5>

                            <div class="sub-title">
                                {tripTitle}
                            </div>
                            <div class="left">
                                Age :
                            </div><br/>
                            <div class="left">
                                Gender :
                            </div><br/>
                            <div class="left"><span class="icon-calendar"></span>   ${chatRoom.strDate} {여행일 수}</div>

                            <div class="right">
<%--                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Difficulty - Hard"><span class="icon-hard"></span></a>--%>
<%--                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Ticket"><span class="icon-plane"></span></a>--%>
<%--                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Style - Camping"><span class="icon-tent"></span></a>--%>
                                    <a href="" title="${chatRoom.tripPlanNo}"><span class="icon-plane"></span></a>
                                    <a href="" ><span class="icon-user"></span></a>
                            </div>
                        </div>
                        <div class="item-book">
                            <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-left">Enter</a>

                            <a href="trip_detail.html" class="btn btn-primary " style="margin-left: 10px; background-color: #00b3ee">Enroll</a>
                            <div class="price">${chatRoom.currentPersons} / ${chatRoom.maxPersons}</div>
                        </div>
                    </div>
                </div>
                </c:forEach>
                <div class="pagination-wrap">
                    <span class="total">Total 127</span>
                    <nav class="pull-right">
                        <ul class="pagination">
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="First">First</a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">1</a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">2</a>
                            </li>
                            <li class="page-item"><span class="page-link">..</span>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">99</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Last">Last</a>
                            </li>
                        </ul>
                    </nav>
                    <div class="clearfix"></div>
                </div>



            </div>

        </div>
    </div>
</main>


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
<script src="/assets/js/min/priceslider.min.js"></script>
<script>
    $(document).ready(function(){
        $('#datepicker').datepicker();
    });
</script>
</body>

</html>