package com.bit.motrip.controller;


import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Comment;
import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.domain.User;
import com.bit.motrip.service.review.CommentService;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.tripplan.TripPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/review/*")

public class ReviewController {
    ///Field
    @Autowired
    @Qualifier("reviewServiceImpl")
    private ReviewService reviewService;

    @Autowired
    @Qualifier("commentServiceImpl")
    private CommentService commentService;

    @Autowired
    @Qualifier("tripPlanServiceImpl")
    private  TripPlanService tripPlanService;

    ///Contructor
    public ReviewController(){
        System.out.println("ReviewController 생성자");
        System.out.println(this.getClass());
    }

    @Value(value = "#{review['reviewPageSize']}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;
    @Value(value = "#{review['reviewPageUnit']}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
    int pageSize;
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
/*        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(search);
        model.addAttribute("tripPlanList", tripPlanList);
        System.out.println("제발 모달창 나와주겠니"+tripPlanList);*/

        return "review/addReviewView.jsp";
    }

    @PostMapping(value = "addReview")
    public String addReview(@ModelAttribute("review") Review review,
                            @RequestParam("tripPlanNo") int tripPlanNo,  Model model) throws Exception {
        System.out.println("/review/addReview : POST");

        // Debug: Print review object
        System.out.println("Review data: " + review.toString());

        // reviewRegDate를 서버에서 가져와서 설정
        review.setReviewRegDate(new Date()); // 현재 시간 등을 설정해야 함

        // 선택한 여행 계획 ID 설정
        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);
        reviewService.addReview(review);
        System.out.println("addReview 컨트롤러는 들어오니?"+tripPlanNo);

        // review 객체를 모델에 추가
        model.addAttribute("review", review);
        System.out.println("review :" +review);


        // tripPlan 객체를 모델에 추가
        model.addAttribute("tripPlan", tripPlan);

        // reviewRegDate를 모델에 추가
        model.addAttribute("reviewRegDate", review.getReviewRegDate());

        return "review/addReview.jsp";
    }

    @GetMapping("getReviewList")
    public String getReviewList(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {
        System.out.println("GET : reviewList()");

        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }

        Map<String, Object> reviewList = reviewService.selectReviewList(search);

        System.out.println(reviewList.get("reviewList").toString());
        model.addAttribute("reviewList", reviewList.get("reviewList"));

        return "review/getReviewList.jsp";
    }

    @GetMapping("getMyReviewList")
    public String getMyReviewList(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {
        System.out.println("GET : getMyReviewList()");

        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }

        User user = (User) session.getAttribute("user");
        System.out.println("여긴 컨트롤러 user"+user);
        if (user != null) {
            String userId = user.getUserId();
            System.out.println("여긴 컨트롤러 userId"+userId);
            model.addAttribute("reviewAuthor", userId);
            model.addAttribute("userId", userId);
        }
        Map<String, Object> myReviewList = reviewService.selectReviewList(search);
        System.out.println("myReviewList>>>>>"+myReviewList);
        model.addAttribute("myReviewList", myReviewList.get("reviewList"));

        return "review/getMyReviewList.jsp";
    }

    @GetMapping("getReview")
    public String getReview(@RequestParam("reviewNo") int reviewNo, Model model, HttpSession session) {
        try {
            // 후기 상세 조회
            Review getReview = reviewService.getReview(reviewNo);
            if (getReview != null) {
                // 댓글 목록 조회
                List<Comment> commentList = commentService.getCommentList(reviewNo);

                model.addAttribute("getReview", getReview);
                System.out.println("getReview>>>>>>>>>>>"+getReview);
                model.addAttribute("commentList", commentList);
                System.out.println("commentList>>>>>>>>>"+commentList);

                // 작성자 정보 설정
                String commentAuthor = (String) session.getAttribute("nickname");
                System.out.println("commentAuthor>>>>>>>>>>>>>"+commentAuthor);
                model.addAttribute("commentAuthor", commentAuthor);

                return "review/getReview.jsp";
            } else {
                model.addAttribute("errorMessage", "해당 후기를 찾을 수 없습니다.");
                return "error";
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "후기 조회 중 오류가 발생했습니다.");
            e.printStackTrace();
            return "error";
        }//컨트롤러에 유저 세션 저장해야만해- 했어
    }

    @PostMapping(value = "updateReview")
    public String updateReview(@ModelAttribute("review") Review review, Model model) throws Exception {
        reviewService.updateReview(review);
        model.addAttribute("review", review);

        return "review/updateReview.jsp";
    }
    @PostMapping(value = "deleteReview")
    public String deleteReview(@RequestParam("reviewNo") int reviewNo) {
        reviewService.deleteReview(reviewNo);

        return "redirect:/review/getMyReviewList.jsp";
    }
    @PostMapping(value = "recoverReview")
    public String recoverReview(@RequestParam("reviewNo") int reviewNo) {
        reviewService.recoverReview(reviewNo);

        return "redirect:/review/getMyReviewList.jsp";
    }
}//end of ReviewController

