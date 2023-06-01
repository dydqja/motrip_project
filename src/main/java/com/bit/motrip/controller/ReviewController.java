package com.bit.motrip.controller;


import com.bit.motrip.common.Search;
import com.bit.motrip.domain.Review;
import com.bit.motrip.domain.TripPlan;
import com.bit.motrip.domain.User;
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
        Map<String, Object> tripPlanList = tripPlanService.selectTripPlanList(search);
        model.addAttribute("tripPlanList", tripPlanList);
        System.out.println("제발 모달창 나와주겠니"+tripPlanList);

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
    @GetMapping("selectReviewList")
    public String selectReviewList(@ModelAttribute("search") Search search, Model model) throws Exception {
        System.out.println("GET: ReviewList()");

        if (search.getPageSize() == 0) {
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }

        Map<String, Object> reviewList = reviewService.selectReviewList(search);
        List<Review> reviews = (List<Review>) reviewList.get("reviewList");
        List<Map<String, Object>> publicReviews = new ArrayList<>();
        List<Map<String, Object>> myReviews = new ArrayList<>();

        for (Review review : reviews) {
            Map<String, Object> reviewData = new HashMap<>();
            reviewData.put("reviewNo", review.getReviewNo());
            reviewData.put("reviewTitle", review.getReviewTitle());
            reviewData.put("reviewThumbnail", review.getReviewThumbnail());
            reviewData.put("reviewLikes", review.getReviewLikes());
            reviewData.put("viewCount", review.getViewCount());
            reviewData.put("reviewRegDate", review.getReviewRegDate());

            if (isPublicReview(review)) {
                reviewData.put("reviewAuthor", review.getReviewAuthor());
                publicReviews.add(reviewData);
            } else {
                myReviews.add(reviewData);
            }
        }

        model.addAttribute("publicReviews", publicReviews);
        model.addAttribute("myReviews", myReviews);

        return "review/selectReviewList.jsp";
    }

    @GetMapping("/publicReviewList")
    public String getPublicReviewList(@ModelAttribute("search") Search search, Model model, HttpSession session) throws Exception {
        System.out.println("GET : getPublicReviewList()");

        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }
        System.out.println(session.getAttribute("user"));

        Map<String, Object> reviewList = reviewService.selectReviewList(search);
        reviewList.get("reviewList");

        List<Review> reviews = (List<Review>) reviewList.get("reviewList");
        List<Map<String, Object>> publicReviews = new ArrayList<>();
        List<Map<String, Object>> myReviews = new ArrayList<>();

        System.out.println(reviewList.get("reviewList").toString());
        model.addAttribute("reviewList", reviewList.get("reviewList"));

        return "review/getPublicReviewList.jsp";
    }

    @GetMapping("/myReviewList")
    public String getMyReviewList(@RequestParam("reviewAuthor") String reviewAuthor, Search search,Model model, HttpSession session) throws Exception {
        // 로그인된 사용자의 ID를 세션에서 가져옵니다.
        User loggedInUserId = (User) session.getAttribute("user");
        System.out.println("loggedInUserId"+loggedInUserId);

        // reviewAuthor 값을 로그인된 사용자의 ID로 설정합니다.
        if (loggedInUserId != null) {
            reviewAuthor = loggedInUserId.getUserId().toString();
        } else {
            // 로그인되지 않은 사용자에게 처리할 방법을 정의하세요.
        }
        // 나의 후기 목록을 가져와서 모델에 추가합니다.
        List<Review> myReviews = reviewService.getMyReviewList(reviewAuthor,search);
        model.addAttribute("myReviews", myReviews);

        return "review/getMyReviewList.jsp";
    }
    private boolean isPublicReview(Review review) {
        // 공개된 후기인지 여부를 판단하는 로직을 구현
        // review.isReviewPublic() 또는 다른 조건을 사용하여 판단할 수 있습니다.
        return review.isReviewPublic();
    }

    @GetMapping(value = "getReview")// 리뷰 단 1개 상세조회
    public String getReview(@RequestParam("reviewNo") int reviewNo, Model model) throws Exception {
        Review review = reviewService.getReview(reviewNo);
        model.addAttribute("review", review);

        return "review/reviewDetail.jsp";
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

        return "redirect:/review/getPublicReviewList.jsp";
    }

    @PostMapping(value = "recoverReview")
    public String recoverReview(@RequestParam("reviewNo") int reviewNo) {
        reviewService.recoverReview(reviewNo);

        return "redirect:/review/getPublicReviewList.jsp";
    }
}//end of ReviewController

