<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Add Class carousel-fade just to fade transition -->

<script src="/assets/js/home.js"></script>
<script>
    $(document).ready(function(){
        const windowHeight = $(window).height(); // 브라우저 창의 높이를 가져옵니다.
        $('.carousel').height(windowHeight);
        $('#carousel').carousel({
            interval: 10000
        })
    });
    $(window).resize(function(){
        $('.equal-height > div').deasil_equalHeight();
    });
</script>
<div class="carousel slide carousel-fade full-height stick-top" id="carousel" style="min-height: 969px;">
    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <div class="item zooming with-overlay" style="background-image: url('http://placehold.it/1680x1050');"></div>
        <div class="item zooming with-overlay" style="background-image: url('http://placehold.it/1680x1050');"></div>
        <div class="item zooming with-overlay" style="background-image: url('http://placehold.it/1680x1050');"></div>
        <div class="item zooming with-overlay active" style="background-image: url('http://placehold.it/1680x1050');"></div>
        <div class="item zooming with-overlay" style="background-image: url('http://placehold.it/1680x1050');"></div>
        <div class="item zooming with-overlay" style="background-image: url('http://placehold.it/1680x1050');"></div>
        <div class="item zooming with-overlay" style="background-image: url('http://placehold.it/1680x1050');"></div>
        <div class="carousel-caption full-width center-txt" style="top: 283.5px;">
            <div class="container">
                <h1 class="main-header">Enjoy Adventure <br> Experience</h1>
                <hr>
                <p class="sub-header">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Veritatis modi tenetur obcaecati veniam harum ipsa voluptas, incidunt cum.</p>
                <br>
                <div class="search-bar padding-20">
                    <div class="col-sm-10 row">
                        <div class="col-sm-4 form-group">
                            <label>From</label>
                            <input type="text" class="form-control datepicker hasDatepicker" readonly="" id="dp1685780924860">
                        </div>
                        <div class="col-sm-4 form-group">
                            <label>To</label>
                            <input type="text" class="form-control datepicker hasDatepicker" readonly="" id="dp1685780924861">
                        </div>
                        <div class="col-sm-4 form-group">
                            <label>Price</label>
                            <select class="form-control">
                                <option value="">1000 - 2000</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <button class="btn btn-search btn-primary hvr-sweep-to-right">Search</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Controls -->
    <!-- Available Variation Class for carousel-control => circle, bottom, bottom-left, bottom-right" -->
    <a class="left carousel-control bottom-right" href="#carousel" role="button" data-slide="prev">
        <span class="icon-arr-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control bottom-right" href="#carousel" role="button" data-slide="next">
        <span class="icon-arr-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>


    <!-- Indicators -->
    <!-- Available Variation Class for carousel-indicators => dashed, circle" -->
    <ol class="carousel-indicators dashed">
        <li data-target="#carousel" data-slide-to="0" class=""></li>
        <li data-target="#carousel" data-slide-to="1" class=""></li>
        <li data-target="#carousel" data-slide-to="2" class=""></li>
        <li data-target="#carousel" data-slide-to="3" class="active"></li>
        <li data-target="#carousel" data-slide-to="4"></li>
        <li data-target="#carousel" data-slide-to="5"></li>
        <li data-target="#carousel" data-slide-to="6"></li>
        <li data-target="#carousel" data-slide-to="7"></li>
    </ol>
</div>


<div class="section bg-white">
    <div class="container">
        <div class="row  feature-list">

            <div class="col-sm-6 col-md-4">
                <span class="circle-icon line"><span class="icon-hand-scissor"></span></span>
                <div class="desc">
                    <h4>Plan Adventure Guaranteed</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odit fugit at facere, voluptatem accusamus similique autem.</p>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <span class="circle-icon line"><span class="icon-road-sign"></span></span>
                <div class="desc">
                    <h4>Take Rare Path</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Recusandae laborum soluta quos praesentium, magni repellendus.</p>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <span class="circle-icon line"><span class="icon-map"></span></span>
                <div class="desc">
                    <h4>Organise with Professional</h4>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quia blanditiis, deleniti necessitatibus doloribus vel.</p>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="flex-row bg-base">
    <div class="flex-col-6 cover-bg-img" style="background-image: url('http://placehold.it/1680x1050');"></div>
    <div class="flex-col-6">
        <div class="padding-100">
            <div class="main-title left">
                <h2>Explore World <br> Beyond</h2>
                <p>Consectetur adipisicing elit. Quisquam fugit ducimus, qui molestias.</p>
            </div>
            <div class="row">
                <div class="col-sm-6">Esse iusto quibusdam quae assumenda dignissimos eligendi magni dolor error sunt corporis laborum maiores. At ad, ratione delectus inventore voluptas cum nulla molestias perferendis iste quis laborum veniam reprehenderit ipsam vitae, corrupti.
                    Cumque enim, unde eveniet.</div>
                <div class="col-sm-6">Asperiores odit error cupiditate nam aperiam animi laborum aliquid. Doloremque, reiciendis perferendis praesentium necessitatibus quis cupiditate. Laborum dicta, ipsa aliquam fugiat!</div>
            </div>
            <br>
            <a href="" class="btn btn-md btn-primary btn-line">Check All Destinations</a>
        </div>
    </div>
</div>
<div class="flex-row bg-base">
    <div class="flex-col-6">
        <div class="counter-div base boxed">
            <div class="clearfix">
                <div class="col-sm-6 light">
                    <span class="icon-font icon-tent"></span>
                    <span class="counter">32</span>
                    <p>Number of People Camped</p>
                </div>
                <div class="col-sm-6 dark">
                    <span class="icon-font icon-camera"></span>
                    <span class="counter">12437</span>
                    <p>Pictures Taken this Year</p>
                </div>
                <div class="col-sm-6 dark">
                    <span class="icon-font icon-sun"></span>
                    <span class="counter">35</span>
                    <p>Average Temprature</p>
                </div>
                <div class="col-sm-6 light">
                    <span class="icon-font icon-umbrella"></span>
                    <span class="counter">45</span>
                    <p>Rainfall Last Year</p>
                </div>
            </div>
        </div>
    </div>
    <div class="flex-col-6 cover-bg-img" style="background-image: url('http://placehold.it/1680x1050');">
        <div class="padding-100">
            <div class="banner">
                <div class="line-box">
                    <br>
                    <br>
                    <h2>Great Places, Great Holiday</h2>
                    <a href="" class="btn btn-primary btn-lg hvr-sweep-to-right">Book Now</a>
                </div>
            </div>
        </div>
    </div>
</div>

<section class="bg-white">
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <div class="main-title left">
                    <h2>Our Top Destination</h2>
                    <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo</p>
                    <p>Eius nostrum accusamus alias. Voluptatibus, sequi, a. Qui nam, nihil, ipsa tempora illo delectus nobis. Illo, veritatis.</p>
                </div>
                <a href="" class="btn btn-lg btn-primary">All Tours</a>
            </div>

            <div class="col-sm-8">
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
                            <h5 class="item-title">Fitz Roy Trek</h5>
                            <div class="sub-title">
                                Argentina
                            </div>
                            <div class="item-excerpt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi id hic, voluptas rem, animi eniti, cupiditate.</div>

                            <div class="left"><span class="icon-calendar"></span> 5 Days/3 Nights</div>
                            <div class="right">
                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Difficulty - Easy"><span class="icon-easy"></span></a>
                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Ticket"><span class="icon-plane"></span></a>
                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Style - Camping"><span class="icon-tent"></span></a>
                            </div>
                        </div>
                        <div class="item-book">
                            <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">Book Now</a>
                            <div class="price">USD 121</div>
                        </div>
                    </div>
                </div>

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
                            <h5 class="item-title">Annapurna Circuit</h5>
                            <div class="sub-title">
                                Nepal
                            </div>
                            <div class="item-excerpt">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi amet dolor accusamus nihil.</div>

                            <div class="left"><span class="icon-calendar"></span> 5 Days/3 Nights</div>
                            <div class="right">
                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Difficulty - Hard"><span class="icon-hard"></span></a>
                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Ticket"><span class="icon-plane"></span></a>
                                <a href="" data-toggle="tooltip" data-placement="bottom" title="Style - Camping"><span class="icon-tent"></span></a>
                            </div>
                        </div>
                        <div class="item-book">
                            <a href="trip_detail.html" class="btn btn-primary hvr-sweep-to-right">Book Now</a>
                            <div class="price">USD 121</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="banner">
    <div class="container">
        <div class="section-title center">
            <h3>Featured Guides</h3>
        </div>
        <div class="row team">
            <div class="col-sm-6 col-md-4">
                <div class="member">
                    <div class="image">
                        <img src="http://placehold.it/370x260" alt="">
                    </div>
                    <h4 class="name">Kim L. Burney</h4>
                    <h5 class="detail">Guide/Writer</h5>
                    <p>This is Photoshop's version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean</p>
                    <div class="social">
                        <a href="#" class="icon icon-facebook"></a>
                        <a href="#" class="icon icon-twitter"></a>
                        <a href="#" class="icon icon-google"></a>
                        <a href="#" class="icon icon-rss"></a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="member">
                    <div class="image">
                        <img src="http://placehold.it/370x260" alt="">
                    </div>
                    <h4 class="name">Shing Ch'in</h4>
                    <h5 class="detail">Tour Guide</h5>
                    <p>This is Photoshop's version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean</p>
                    <div class="social">
                        <a href="#" class="icon icon-facebook"></a>
                        <a href="#" class="icon icon-twitter"></a>
                        <a href="#" class="icon icon-google"></a>
                        <a href="#" class="icon icon-rss"></a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="member">
                    <div class="image">
                        <img src="http://placehold.it/370x260" alt="">
                    </div>
                    <h4 class="name">Pitez Maltr</h4>
                    <h5 class="detail">City Guide</h5>
                    <p>This is Photoshop's version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean</p>
                    <div class="social">
                        <a href="#" class="icon icon-facebook"></a>
                        <a href="#" class="icon icon-twitter"></a>
                        <a href="#" class="icon icon-google"></a>
                        <a href="#" class="icon icon-rss"></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Current Page JS -->