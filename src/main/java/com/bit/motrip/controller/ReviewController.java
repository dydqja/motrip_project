package com.bit.motrip.controller;


import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/review/*")

public class ReviewController {

    ///Field
    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private  TripPlanService tripPlanService;

    ///Contructor
    public ReviewController(){
        System.out.println("ReviewController 생성자");
        System.out.println(this.getClass());
    }
    ///Contructor
    public ReviewController(TripPlanService tripPlanService) {
        this.tripPlanService = tripPlanService;
    }



    @RequestMapping( value="addReviewView", method= RequestMethod.GET )
    public String addReviewView() throws Exception{
        System.out.println("/review/addReviewView: GET");
        return "review/addReviewView.jsp";
    }

    @RequestMapping( value="addReview", method=RequestMethod.POST )
    public String addReview(@ModelAttribute("review") Review review) throws Exception {
        System.out.println("/review/addReview : POST");
        reviewService.addReview(review);
        return "review/addReview.jsp";
    }



}//end of ReviewController
