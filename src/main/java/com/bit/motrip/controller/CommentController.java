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

    private ReviewService reviewService;

    // Setter 메서드 추가
    public void setReviewService(ReviewService reviewService) {
        this.reviewService = reviewService;
    }



}//end of CommentController
