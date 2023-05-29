package com.bit.motrip.controller;


import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping(value = "addReviewView")
    public String addReviewView(Search search,Model model) throws Exception {
        System.out.println("/review/addReviewView: GET");
        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }
        // selectTripPlanList를 호출하여 tripPlanList를 가져옴
        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(search);
        model.addAttribute("tripPlanList", tripPlanList);
        System.out.println("제발 모달창 나와주겠니"+tripPlanList);

        return "review/addReviewView.jsp";
    }

    @PostMapping(value = "addReview")
    public String addReview(@ModelAttribute("review") Review review,
                            @RequestParam("tripPlanNo") int tripPlanNo) throws Exception {
        System.out.println("/review/addReview : POST");

        // 선택한 여행 계획 ID 설정
        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);

        reviewService.addReview(review);
        return "review/addReview.jsp";
    }




}//end of ReviewController
