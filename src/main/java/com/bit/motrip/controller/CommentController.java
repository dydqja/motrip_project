package com.bit.motrip.controller;

import com.bit.motrip.service.review.CommentService;
import com.bit.motrip.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

@Controller
public class CommentController {

    @Autowired
    @Qualifier("commentServiceImpl")
    private CommentService commentService;

    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;


}//end of CommentController
