package com.bit.motrip.controller.review;


import com.bit.motrip.common.Search;
import com.bit.motrip.dao.chatroom.ChatRoomDao;
import com.bit.motrip.dao.tripplan.TripPlanDao;
import com.bit.motrip.domain.*;
import com.bit.motrip.service.chatroom.ChatMemberService;
import com.bit.motrip.service.chatroom.ChatRoomService;
import com.bit.motrip.service.review.CommentService;
import com.bit.motrip.service.review.ReviewService;
import com.bit.motrip.service.tripplan.TripPlanService;
import com.bit.motrip.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
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

    @Autowired
    @Qualifier("chatRoomDao")
    ChatRoomDao chatRoomDao; //Chatroom


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

    public ReviewController(TripPlanService tripPlanService,ReviewService reviewService) {
        this.tripPlanService = tripPlanService;
        this.reviewService = reviewService;
    }

    // 회원이 속한 채팅방으로 완료된 플랜목록 가져옴(ajax)

    @RequestMapping("getCompletedTripPlan")
    @ResponseBody
    public ResponseEntity<List<TripPlan>> getCompletedTripPlan(@RequestParam(required = false) Integer chatRoomNo, HttpSession session) {
        try {
            List<TripPlan> tripPlans = new ArrayList<>();

            if (chatRoomNo != null) {
                // chatRoomNo가 제공된 경우
                tripPlans = reviewService.getCompletedTripPlan(chatRoomNo);
                System.out.println("chatRoomNo>>>>>>>>>>"+chatRoomNo);
                System.out.println("chatRoomNo가 제공된 경우 tripPlans?>>>>>>>"+tripPlans);
            } else {
                // chatRoomNo가 제공되지 않은 경우
                tripPlans = reviewService.getPublicNonDeletedTripPlans();
                System.out.println("chatRoomNo가 제공되지 않은 경우 tripPlans?>>>>>>>"+tripPlans);
            }

            // 첫 번째 tripPlanNo를 가져옴
            int selectedTripPlanNo = 0;
            if (!tripPlans.isEmpty()) {
                selectedTripPlanNo = tripPlans.get(0).getTripPlanNo();
            }

            // 세션에 선택한 tripPlanNo 저장
            session.setAttribute("selectedTripPlanNo", selectedTripPlanNo);
            System.out.println("selectedTripPlanNo?>>>>>"+selectedTripPlanNo);

            return ResponseEntity.ok(tripPlans);
        } catch (Exception e) {
            // 예외 처리 로직 추가
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }






    @RequestMapping(value = "addReviewView", method = {RequestMethod.GET, RequestMethod.POST}) // 후기 작성
    public String addReviewView(Search search, Model model, HttpSession session) throws Exception {
        System.out.println("/review/addReviewView: GET");

        if (search.getPageSize() == 0) {
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }

        // 로그인된 유저 정보 가져오기
        User loggedInUser = (User) session.getAttribute("user");
        System.out.println("loggedInUser는>>>>" + loggedInUser);

        // 로그인되지 않은 경우 로그인 페이지로 이동
        if (loggedInUser == null) {
            return "redirect:/user/login"; // 로그인 페이지 경로로 수정해야 함
        }

        model.addAttribute("loggedInUser", loggedInUser);

        String reviewAuthor = loggedInUser.getUserId();
        session.setAttribute("reviewAuthor", reviewAuthor);
        System.out.println("reviewAuthor>>>>>>>"+reviewAuthor);

        return "review/addReviewView.jsp";
    }

    @RequestMapping(value = "addReview", method = {RequestMethod.GET, RequestMethod.POST}) // 등록된 후기 보기
    public String addReview(@ModelAttribute("review") Review review, @RequestParam("tripPlanNo") int tripPlanNo, Model model, HttpSession session) throws Exception {
        System.out.println("/review/addReview : POST");
        // addReviewView.jsp에서 reviewAuthor 값을 세션에서 읽어옴
        String reviewAuthor = (String) session.getAttribute("reviewAuthor");
        model.addAttribute("reviewAuthor", reviewAuthor);

        // 세션에서 선택한 tripPlanNo 가져오기
        int selectedTripPlanNo = (int) session.getAttribute("selectedTripPlanNo");
        // 선택한 tripPlanNo를 review 객체에 설정
        review.setTripPlanNo(selectedTripPlanNo);

        // Debug: Print review object
        System.out.println("Review data: " + review.toString());

        // tripPlanNo를 review 객체에 설정
        review.setTripPlanNo(tripPlanNo);

        // 선택한 여행 계획 ID 설정
        TripPlan tripPlan = tripPlanService.selectTripPlan(tripPlanNo);
        reviewService.addReview(review);
        System.out.println("addReview 컨트롤러는 들어오니?" + tripPlanNo);
        // review 객체를 모델에 추가
        model.addAttribute("review", review);
        System.out.println("review: " + review);

        // tripPlan 객체를 모델에 추가
        model.addAttribute("tripPlan", tripPlan);
        model.addAttribute("selectedTripPlanNo", selectedTripPlanNo);

        System.out.println("addReview가 될 tripPlanNo는??>>>>>" + tripPlanNo);
        return "review/addReview.jsp";
    }



    @GetMapping("getReviewList")// 공개된 모든 후기 목록 조회
    public String getReviewList(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {
        System.out.println("/review/getReviewList : GET");

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

    @GetMapping("getMyReviewList")// 내가 작성한 모든 후기 목록 조회
    public String getMyReviewList(@ModelAttribute("search")Search search, Model model, HttpSession session) throws Exception {
        System.out.println("/review/getMyReviewList : GET");

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

    @GetMapping("getReview")// 후기 단 1개 상세조회
    public String getReview(@RequestParam("reviewNo") int reviewNo, Model model, HttpSession session) {
        System.out.println("/review/getReview : GET");
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

    @PostMapping(value = "updateReview")//후기 수정
    public String updateReview(@ModelAttribute("review") Review review, Model model) throws Exception {
        System.out.println("/review/updateReview : POST");
        reviewService.updateReview(review);
        model.addAttribute("review", review);
        System.out.println();

        return "review/updateReview.jsp";
    }
    @PostMapping(value = "deleteReview")//후기완전삭제
    public String deleteReview(@RequestParam("reviewNo") int reviewNo) {
        System.out.println("/review/deleteReview : POST");
        reviewService.deleteReview(reviewNo);

        return "redirect:/review/getMyReviewList.jsp";
    }
    @PostMapping(value = "recoverReview")//후기 복구
    public String recoverReview(@RequestParam("reviewNo") int reviewNo) {
        System.out.println("/review/recoverReview : POST");
        reviewService.recoverReview(reviewNo);

        return "redirect:/review/getMyReviewList.jsp";
    }
}//end of ReviewController

