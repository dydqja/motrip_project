<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>motrip</title>
  <link rel="icon" type="image/png" href="assets/img/favicon.png" />

  <link rel="stylesheet" href="assets/css/min/bootstrap.min.css" media="all">
  <link rel="stylesheet" href="assets/css/jqueryui.css" media="all">
  <link rel="stylesheet" href="vendor/animate-css/animate.css" media="all">
  <link rel="stylesheet" href="assets/font/iconfont/iconstyle.css" media="all">
  <link rel="stylesheet" href="assets/font/font-awesome/css/font-awesome.css" media="all">
  <link rel="stylesheet" href="assets/css/main.css" media="all" id="maincss">
</head>

<body>

  <div class="pre-loader">
    <div class="loading-img"></div>
  </div>

  <header class="nav-menu fixed">
    <nav class="navbar normal">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="index.html">
            <img src="assets/img/logo.png" alt="">
          </a>
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>

        <div class="navbar-collapse collapse" id="main-navbar">
          <ul class="nav navbar-nav">
            <li class="dropdown">
              <a href="#">Home Pages <i class="fa fa-chevron-down nav-arrow"></i></a>
              <ul class="dropdown-menu">
                <li><a href="home_default.html">Default Home Page</a>
                </li>
                <li><a href="home_slider.html">Image Slider Default</a>
                </li>
                <li><a href="home_slider_with_searhbar.html">Slider / Search Bar</a>
                </li>
                <li><a href="home_boxed.html">Boxed/Background Image</a>
                </li>
                <li><a href="home_video.html">Home with Video</a>
                </li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#">Tour Pages</a>
              <ul class="dropdown-menu">
                <li><a href="trip_grid_withsidebar.html">Tour List</a>
                </li>
                <li><a href="trip_detail.html">Tour Detail</a>
                </li>
                <li><a href="location.html">Tour Location</a>
                </li>
                <li><a href="location_archive.html">Location Archive</a>
                </li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle">Features</a>
              <ul class="dropdown-menu">
                <li><a href="colorscheme.html">Color Scheme</a>
                </li>
                <li><a href="iconfont.html">Icon Font</a>
                </li>
                <li><a href="text_page.html">Typography</a>
                </li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle">Blog</a>
              <ul class="dropdown-menu">
                <li><a href="blog_list.html">Blog List</a>
                </li>
                <li><a href="blog_list2.html">Blog List Full Image</a>
                </li>
                <li><a href="blog_single.html">Blog Single</a>
                </li>
                <li><a href="blog_single_center.html">Blog Single Center</a>
                </li>
              </ul>
            </li>
            <li class="dropdown  megamenu">
              <a class="dropdown-toggle">Mega Menu</a>
              <div class="dropdown-menu">
                <div class="col-sm-3">
                  <h5 class="head">Home Variation</h5>
                  <ul>
                    <li><a href="home_default.html">Default Home Page</a>
                    </li>
                    <li><a href="home_slider.html">Image Slider Default</a>
                    </li>
                    <li><a href="home_slider_with_searhbar.html">Slider / Search Bar</a>
                    </li>
                    <li><a href="home_boxed.html">Boxed/Background Image</a>
                    </li>
                    <li><a href="home_video.html">Home with Video</a>
                    </li>
                  </ul>
                </div>
                <div class="col-sm-3">
                  <h5 class="head">Trip / Listing</h5>
                  <ul>
                    <li><a href="trip_detail.html">Trip Detail</a>
                    </li>
                    <li class="hor-line"></li>
                    <li><a href="trip_grid.html">Trip Grid</a>
                    </li>
                    <li><a href="trip_grid_withsidebar.html">Trip Grid with Sidebar</a>
                    </li>
                    <li><a href="trip_list.html">Trip List</a>
                    </li>
                    <li><a href="trip_list_full_img.html">Trip List - Full Image</a>
                    </li>
                    <li><a href="trip_list_2col.html">Trip List Two Column</a>
                    </li>
                  </ul>
                </div>
                <div class="col-sm-3">
                  <h5 class="head">Pages</h5>
                  <ul>
                    <li><a href="cart_page.html">Cart Page</a>
                    </li>
                    <li><a href="checkout_page.html">Checkout Page</a>
                    </li>
                    <li><a href="about_page.html">About Us Page</a>
                    </li>
                    <li><a href="team_page.html">Team Page</a>
                    </li>
                    <li><a href="contact_page.html">Contact Page</a>
                    </li>
                    <li><a href="contact_page2.html">Contact Page 2</a>
                    </li>
                  </ul>
                </div>
                <div class="col-sm-3">
                  <h5 class="head last">Misc Pages</h5>
                  <ul>
                    <li><a href="404_page.html">404 Page</a>
                    </li>
                    <li><a href="comming_soon.html">Comming Soon Page</a>
                    </li>
                    <li class="hor-line"></li>
                    <li><a href="login_page.html">Login Page</a>
                    </li>
                    <li><a href="signup_page.html">Sign Up Page</a>
                    </li>
                  </ul>
                </div>
              </div>
            </li>
            <li class="dropdown megamenu">
              <a href="#" class="dropdown-toggle">Elements</a>
              <div class="dropdown-menu">
                <div class="col-sm-3">
                  <h5 class="head">Misc 1</h5>
                  <ul>
                    <li><a href="element_feature_list.html">Feature List</a>
                    </li>
                    <li><a href="element_heading.html">Heading / Titles</a>
                    </li>
                    <li><a href="element_banner.html">Banner</a>
                    </li>
                    <li><a href="element_blockquote.html">Blockquote</a>
                    </li>
                    <li><a href="element_breadcrumb.html">Breadcrumb</a>
                    </li>
                    <li><a href="element_pagination.html">Pagination</a>
                    </li>

                  </ul>
                </div>
                <div class="col-sm-3">
                  <h5 class="head">Misc 2</h5>
                  <ul>
                    <li><a href="element_carousel.html">Carousel</a>
                    </li>
                    <li><a href="element_gallery.html">Gallery &amp; Lightbox</a>
                    </li>
                    <li><a href="element_step-timeline.html">Steps / Timeline</a>
                    </li>
                    <li><a href="element_testimonials.html">Testimonials</a>
                    </li>
                    <li><a href="element_jquery_ui.html">Jquery UI</a>
                    </li>
                  </ul>
                </div>
                <div class="col-sm-3">
                  <h5 class="head">Animation / Form</h5>
                  <ul>
                    <li><a href="element_animation.html">Animation</a>
                    </li>
                    <li><a href="element_button.html">Button</a>
                    </li>
                    <li><a href="element_button_effect.html">Button Effect</a>
                    </li>
                    <li><a href="element_form.html">Form</a>
                    </li>
                    <li><a href="element_counter.html">Counter</a>
                    </li>

                  </ul>
                </div>
                <div class="col-sm-3">
                  <h5 class="head">Tab / Table</h5>
                  <ul>
                    <li><a href="element_table.html">Table</a>
                    </li>
                    <li><a href="element_tooltip.html">Tooltip / Popover / Modal</a>
                    </li>
                    <li><a href="element_tabs.html">Tabs</a>
                    </li>
                    <li><a href="element_accordion.html">Accordion</a>
                    </li>
                    <li><a href="element_alert.html">Alert / Label</a>
                    </li>
                  </ul>
                </div>
              </div>
            </li>
            <li> <a href="login_page.html"><span class="icon-user"></span>Sign In</a>
            </li>
            <li class="dropdown">
              <a href="cart_page.html"><span class="icon-minicart"></span><span class="badge badge-danger">3</span></a>
              <ul class="dropdown-menu  dropdown-menu-right cart-menu">
                <li>
                  <img src="http://placehold.it/40x40" alt="" class="item-img">
                  <span class="delete icon-trash"></span>
                  <div class="text">
                    Lorem ipsum dolor sit amet, consectetur.
                    <p>USD 473 X 2</p>
                  </div>
                </li>
                <li>
                  <img src="http://placehold.it/40x40" alt="" class="item-img">
                  <span class="delete icon-trash"></span>
                  <div class="text">
                    Lorem ipsum dolor sit amet, consectetur.
                    <p>USD 473 X 2</p>
                  </div>
                </li>
                <li>
                  <img src="http://placehold.it/40x40" alt="" class="item-img">
                  <span class="delete icon-trash"></span>
                  <div class="text">
                    Lorem ipsum dolor sit amet, consectetur.
                    <p>USD 473 X 2</p>
                  </div>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </header>

  <div class="post-single left">
    <div class="page-img" style="background-image: url('http://placehold.it/1200x400');">
      <div class="page-img-txt container">
        <div class="row">
          <div class="col-sm-8">
            <h1 class="main-head">Like Nothing I’ve Seen</h1>	
            <p class="sub-head">Blog Post - with sidebar</p>

            <div class="author-img">
              <img src="http://placehold.it/70x70" alt="">
            </div>
            <div class="author">
              <span>By</span><a href="#">Aaron D. Cullen</a>
            </div>
            <p class="byline">
              <span>August 24, 2015</span>
              <span class="dot">·</span>
              <span class="italic">in</span>
              <a href="#">Adventure</a>, <a href="#">Asia</a>
              <span class="dot">·</span>
              <a href="#">4 Comments</a>
            </p>
          </div>
          <div class="colsm-4">
          </div>
        </div>
      </div>
    </div>

    <main class="white">
      <div class="container">
        <div class="row">
          <div class="col-sm-7">
            <div class="post">
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laudantium rerum sed quaerat ex obcaecati eos quod expedita eligendi distinctio animi blanditiis excepturi qui tempore, perspiciatis quia alias laboriosam maxime beatae.</p>
              <p>Ad ea et quibusdam assumenda eaque numquam expedita omnis recusandae, atque laborum. Obcaecati labore minus doloremque illo natus at praesentium consequuntur blanditiis sunt neque, tempore, quibusdam ipsa cum, corporis dolorum?</p>
              <p>Consectetur adipisicing elit. Explicabo dicta veritatis fugit repellat quae dolores saepe consequatur iure dolore earum fugiat corporis, velit quidem qui, veniam in laudantium. Asperiores, tempora.</p>
              <p>Eos dicta fuga voluptatum, error distinctio unde amet vero voluptate aspernatur architecto culpa ut, ullam nostrum incidunt commodi aliquam tenetur at illum molestiae excepturi necessitatibus voluptatibus. Sequi, necessitatibus quisquam
                sunt quidem dolores iste mollitia repudiandae, accusamus ipsam ea ullam! Fugit recusandae quo commodi dolorum omnis at quasi, pariatur numquam, aspernatur laborum, quos! Facere nobis eveniet porro quae saepe esse aliquam animi quos.</p>
              <blockquote class="with-icon">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quo, quam? Asperiores unde molestias iusto, quasi impedit ipsa necessitatibus, perferendis doloribus!</p>
                <footer>Someone famous in <cite title="Source Title">Source Title</cite>
                </footer>
              </blockquote>
              <p>Accusantium commodi? Quia officia eius, aperiam sit aspernatur perferendis quod recusandae! Nihil obcaecati, autem alias impedit totam perspiciatis tempore officia laudantium adipisci ipsum rerum natus accusantium, repellendus iusto nulla
                ullam ea corrupti architecto excepturi optio. Obcaecati incidunt, at eius pariatur eveniet, laboriosam ad quam. Magnam ex voluptatibus, minima? Sed, nulla, nostrum.</p>
            </div>

            <div class="tag-wrap">
              <a href="#" rel="tag">blog</a>
              <a href="#" rel="tag">more</a>
              <a href="#" rel="tag">one</a>
              <a href="#" rel="tag">read</a>	
            </div>

            <div class="share-box">
              <h5 class="title">Share this entry</h5>
              <div class="social-icon-wrap">
                <a href="#" class="social-icon"><span class="fa fa-facebook"></span></a>
                <a href="#" class="social-icon"><span class="fa fa-google"></span></a>
                <a href="#" class="social-icon"><span class="fa fa-twitter"></span></a>
                <a href="#" class="social-icon"><span class="fa fa-linkedin"></span></a>
              </div>
            </div>
            <div class="review-comment">
              <div class="section-title left">
                <h4>Reviews &amp; Comments</h4>
              </div>
              <ul class="media-list review-comment">
                <li>
                  <div class="media">
                    <div class="media-left">
                      <a href="#">
                        <img src="http://placehold.it/70x70" class="media-object" alt="">
                      </a>
                    </div>
                    <div class="media-body">
                      <h4 class="media-heading">Kim L. Burney</h4> 
                      <div class="rating">
                        <span class="icon-star"></span>
                        <span class="icon-star"></span>
                        <span class="icon-star"></span>
                        <span class="icon-star"></span>
                        <span class="icon-star-empty"></span>
                      </div>
                      Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.
                    </div>
                  </div>
                </li>
                <li>
                  <div class="media">
                    <div class="media-left">
                      <a href="#">
                        <img src="http://placehold.it/70x70" class="media-object" alt="">
                      </a>
                    </div>
                    <div class="media-body">
                      <h4 class="media-heading">Shing Ch'in</h4> 
                      <div class="rating">
                        <span class="icon-star"></span>
                        <span class="icon-star"></span>
                        <span class="icon-star"></span>
                        <span class="icon-star"></span>
                        <span class="icon-star-empty"></span>
                      </div>
                      Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.</div>
                  </div>
                </li>
              </ul>
              <div class="add-comment">
                <div class="form-group">
                  <label>Add Comment</label>
                  <textarea class="form-control">Your comment</textarea>
                  <button class="btn btn-primary">Add Comment</button>
                </div>
              </div>
            </div>

          </div>
          <div class="col-sm-4 col-sm-offset-1">
            <div class="sidebar">
              <div class="border-box">
                <div class="box-title">Search Trips</div>
                <div class="input-group">
                  <input type="text" class="form-control" placeholder="Search Site">
                  <div class="input-group-btn">
                    <button class="btn btn-primary">Search</button>
                  </div>
                </div>
              </div>

              <div class="border-box">
                <div class="box-title">Recent Blog Post</div>
                <div class="recent-post-list">
                  <div class="recent-post">
                    <div class="author-img">
                      <img src="http://placehold.it/50x50" class="media-object" alt="">
                    </div>
                    <div class="post-summary">
                      <p>Lorem ipsum dolor sit amet, cons adipisicing elit.</p>
                      <div class="byline">
                        <span class="updated">Aug 24, 2015</span>
                        <span class="dot">·</span>
                        <span class="italic">By</span>&nbsp;
                        <a href="#" rel="author" class="fn">Aaron D. Cullen</a>
                      </div>
                    </div>
                  </div>
                  <div class="recent-post">
                    <div class="author-img">
                      <img src="http://placehold.it/50x50" class="media-object" alt="">
                    </div>
                    <div class="post-summary">
                      <p>Lorem ipsum dolor sit amet, cons adipisicing elit.</p>
                      <div class="byline">
                        <span class="updated">Jan 24, 2015</span>
                        <span class="dot">·</span>
                        <span class="italic">By</span>&nbsp;
                        <a href="#" rel="author" class="fn">Keira Hopman</a>
                      </div>
                    </div>
                  </div>
                </div>
              </div>


              <div class="border-box">
                <div class="box-title">Categories</div>
                <ul class="list">
                  <li class="cat-item"><a href="#">Creative (2)</a>
                  </li>
                  <li class="cat-item"><a href="#">Design (9)</a>
                  </li>
                  <li class="cat-item"><a href="#">Image (2)</a>
                  </li>
                  <li class="cat-item"><a href="#">Photography (9)</a>
                  </li>
                  <li class="cat-item"><a href="#">Videos (4)</a>
                  </li>
                  <li class="cat-item"><a href="#">WordPress (4)</a>
                  </li>
                </ul>
              </div>

              <div class="border-box">
                <div class="box-title">Tags</div>
                <div class="tagcloud">
                  <a href="#" class="tag-link" title="2 topics">artwork</a> 
                  <a href="#" class="tag-link" title="2 topics">Photo</a> 
                  <a href="#" class="tag-link" title="3 topics">Video</a> 
                  <a href="#" class="tag-link" title="1 topic">Videos</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>

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

  <script src="vendor/jquery/dist/jquery.min.js"></script>
  <script src="vendor/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
  <script src="vendor/jquery.ui.touch-punch.min.js"></script>
  <script src="vendor/bootstrap/dist/js/bootstrap.min.js"></script>

  <script src="vendor/waypoints/lib/jquery.waypoints.min.js"></script>
  <script src="vendor/owlcarousel/owl.carousel.min.js"></script>
  <script src="vendor/retina.min.js"></script>
  <script src="vendor/jquery.imageScroll.min.js"></script>
  <script src="assets/js/min/responsivetable.min.js"></script>
  <script src="assets/js/bootstrap-tabcollapse.js"></script>

  <script src="assets/js/min/countnumbers.min.js"></script>
  <script src="assets/js/main.js"></script>

</body>

</html>