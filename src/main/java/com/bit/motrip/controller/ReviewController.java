package com.bit.motrip.controller;


import com.bit.motrip.common.Search;
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

    @Autowired
    @Qualifier("chatMemberServiceImpl")
    private ChatMemberService chatMemberService;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

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

    @GetMapping(value = "addReviewView")//후기 작성
    public String addReviewView(Search search,int chatRoomNo,Model model,HttpSession session) throws Exception {
        System.out.println("/review/addReviewView: GET");
        // 로그인된 유저 정보 가져오기
        User loggedInUser = (User) session.getAttribute("user");

        // 로그인되지 않은 경우 로그인 페이지로 이동
        if (loggedInUser == null) {
            return "redirect:/login"; // 로그인 페이지 경로로 수정해야 함
        }

        // 로그인된 유저가 속한 chatRoom 목록 가져오기
        List<ChatMember> chatMemberList= chatMemberService.chatMemberList(chatRoomNo);

        // 선택 가능한 TripPlan들 가져오기
        List<TripPlan> tripPlanList = new ArrayList<>();
        for (ChatMember chatMember : chatMemberList) {
            TripPlan tripPlan = tripPlanService.selectTripPlan(chatMember.getTripPlanNo());
            tripPlanList.add(tripPlan);
        }

        model.addAttribute("tripPlanList", tripPlanList);
        model.addAttribute("loggedInUser", loggedInUser);

        if(search.getPageSize() == 0){
            search.setCurrentPage(1);
        } else {
            search.setCurrentPage(search.getCurrentPage());
        }
        return "review/addReviewView.jsp";
    }

    @PostMapping(value = "addReview")//등록된 후기
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

