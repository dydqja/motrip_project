<%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 2023-06-03
  Time: 오전 5:16
  To change this template use File | Settings | File Templates.
--%>
<div class="pre-loader">
    <div class="loading-img"></div>
</div>

<header class="nav-menu fixed">
    <nav class="navbar normal">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="index.html">
                    <img src="/assets/img/logo.png" alt="">
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